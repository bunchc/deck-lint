# 21. HTTP‑01 ACME Challenge Handling for Kong Proxy Certificates

Date: 2025-04-22

## Tags

kong, api, gateway, deployment, kubernetes, tls, ssl, certificates, acme, lets-encrypt, cert-manager, automation, http-01, certificate-renewal, security

## Status

Accepted

Automated by [39. Automate Certificate Authority Management with cert-manager](0039-automate-certificate-authority-management-with-cert-manager.md)

## Context

We need to automate issuance and renewal of TLS certificates (via Let’s Encrypt) for Kong proxy hostnames using cert‑manager’s HTTP‑01 solver. HTTP‑01 challenges require an HTTP endpoint at `/.well‑known/acme‑challenge/<token>` **before** the proxy is up, but Kong isn’t yet serving that path until its certificate exists.

## Decision

Adopt a three‑part solution so cert‑manager can validate HTTP‑01 challenges and Kong can serve production traffic:

1. **Helm chart Certificate resource**

   ```yaml
   certificates:
     enabled: true
     clusterIssuer: "letsencrypt-prod"
     proxy:
       enabled: true
       commonName: "x-kong.client-domain.com"
   proxy:
     enabled: true
     type: LoadBalancer
     annotations:
       service.beta.kubernetes.io/azure-load-balancer-internal: "false"
       service.beta.kubernetes.io/azure-load-balancer-ipv4: "<IP>"
   ```

2. Dedicated ACME‑only Ingress for cert‑manager’s HTTP‑01 solver

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
   name: acme-challenge
   annotations:
       cert-manager.io/acme-challenge-type: http01
       cert-manager.io/issuer: letsencrypt-prod
   spec:
   rules:
   - host: x-kong.client-domain.com
       http:
       paths:
       - path: /.well-known/acme-challenge/
           pathType: Prefix
           backend:
           service:
               name: acme-solver
               port:
               number: 80
   ```

3. Kong route to the Solver Service

   - Disable TLS in Kong’s Data Plane temporarily.
   - Discover the HTTP‑01 solver Service name:

   ```
   ACME_SVC=$(kubectl get svc -n $NAMESPACE \
   -l acme.cert-manager.io/http01-solver=true \
   -o jsonpath="{.items[0].metadata.name}")
   ```

   - Create a Kong Service & Route pointing /.well-known/acme-challenge to the solver:

   ```
   curl -X PUT http://localhost:8001/services/acme-solver \
   --data url=http://$ACME_SVC.$NAMESPACE.svc.cluster.local:8089

   curl -X PUT http://localhost:8001/routes/acme-solver \
   --data paths[]="/.well-known/acme-challenge"
   ```

   - Optionally expose the solver as a stable K8s Service (acme-solver-stable) so it survives pod rotations.

After cert issuance/renewal, perform a Helm upgrade to re‑enable TLS in Kong and trigger a pod reload with the new certificate.

### Alternatives Considered

- DNS‑01 challenges (via DNS provider API)
  - Pros: no HTTP endpoint required up front.
  - Cons: requires DNS API access and client support.
- External NGINX solver only
  - Pros: HTTP solver.
  - Cons: adds another ingress path outside of Kong’s control.

## Consequences

### Positive

- Fully automated certificate issuance & renewal using standard cert‑manager flows.
- No manual intervention once configured.

### Negative

- Kong reload required after each certificate renewal.
- Multiple certificates for different hostnames require additional solver routes and services.
- Slight complexity added to Helm chart and deployment manifests.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0021-http-01-acme-challenge-handling-for-kong-proxy-certificates.md)
- [Kong Gateway with TLS/SSL](https://docs.konghq.com/gateway/latest/admin-api/certificates/)
- [Certificate Management](https://docs.konghq.com/gateway/latest/how-to/configure-tls/)
