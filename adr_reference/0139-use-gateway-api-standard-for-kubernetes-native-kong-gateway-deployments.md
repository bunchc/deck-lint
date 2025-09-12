# 139. Use Gateway API Standard for Kubernetes-Native Kong Gateway Deployments

Date: 2025-04-25

## Tags

kong, gateway, kubernetes, gateway-api, deployment, routing, crd, kic, modernization, interoperability

## Status

Accepted

## Context

As Kubernetes becomes the de-facto platform for API-centric applications, the Gateway API project (formerly "Service APIs") offers a standard, extensible way to model API traffic routing, load balancing, and policy attachment. Kong Ingress Controller (KIC) natively supports Gateway API resources alongside traditional Ingress resources.

Moving toward Gateway API adoption provides:

- Greater portability across ingress implementations
- More expressive configuration options (e.g., traffic splitting, header-based matching)
- Future-proofing as Gateway API becomes GA and increasingly adopted by the CNCF ecosystem

## Decision

For Kubernetes-based Kong Gateway deployments, prefer using Gateway API resources (e.g., `Gateway`, `HTTPRoute`, `GRPCRoute`, `TCPRoute`) over legacy Ingress resources wherever possible.

### Implementation Guidelines

#### 1. Deploy Gateway API Custom Resource Definitions (CRDs)

Install the Gateway API CRDs compatible with Kong Ingress Controller:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.7.0/standard-install.yaml
```

Confirm CRD availability:

```bash
kubectl get crds | grep gateway.networking.k8s.io
```

#### 2. Enable Gateway API Mode in KIC

In Kong Ingress Controller deployment configuration:

```yaml
env:
  - name: CONTROLLER_ENABLED_GATEWAY_API
    value: "true"
```

Ensure Kong ingress-controller has permission to manage Gateway API resources.

#### 3. Define Gateways and Routes

Example Gateway:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: kong-gateway
spec:
  gatewayClassName: kong
  listeners:
    - name: https
      port: 443
      protocol: HTTPS
      tls:
        mode: Terminate
        certificateRefs:
          - kind: Secret
            name: tls-cert
```

Example HTTPRoute:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: payments-route
spec:
  parentRefs:
    - name: kong-gateway
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /payments
      backendRefs:
        - name: payments-svc
          port: 443
```

#### 4. Gradually Migrate from Ingress Resources

Use side-by-side deployments:

- Maintain existing Ingress resources while onboarding new APIs with Gateway API.
- Validate behavior and plugin attachment equivalence.
- Plan deprecation and cleanup of legacy resources over time.

#### 5. Leverage Gateway API Extensions for Kong-Specific Features

Kong extends Gateway API with additional capabilities (e.g., plugins at route level):

- `konghq.com/plugins` annotations
- Extended match types (e.g., SNI for TLS routing)

Stay up-to-date with KIC documentation for supported extensions.

## Consequences

### Positive Outcomes

- Aligns API gateway configuration with Kubernetes-native standards
- Unlocks richer routing and policy expression compared to traditional Ingress
- Future-proofs Kong Gateway integrations in multi-cloud and hybrid environments
- Enables interoperability with other Gateway API-compatible systems

### Risks and Trade-offs

- Requires learning curve for Gateway API concepts vs. classic Ingress
- Partial coverage depending on Kong Ingress Controller version (some advanced features require annotations)
- Migration complexity for legacy Ingress-based deployments

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0139-use-gateway-api-standard-for-kubernetes-native-kong-gateway-deployments.md)

- [Kong Gateway API Support](https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/gateway-api/)
- [Kubernetes Gateway API Project](https://gateway-api.sigs.k8s.io/)
- [Kong Ingress Controller Configuration](https://docs.konghq.com/kubernetes-ingress-controller/latest/)
