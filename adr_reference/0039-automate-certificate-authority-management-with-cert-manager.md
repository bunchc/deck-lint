# 39. Automate Certificate Authority Management with cert-manager

Date: 2025-04-22

## Tags

kong, api, gateway, kubernetes, cert-manager, certificate-management, tls, ssl, automation, acme, lets-encrypt, pki, certificate-renewal, security, rbac, lifecycle-management

## Status

Accepted

Automates [21. HTTP‑01 ACME Challenge Handling for Kong Proxy Certificates](0021-http-01-acme-challenge-handling-for-kong-proxy-certificates.md)

## Context

Manual management of TLS certificates across Kong Gateways introduces risks of expiration, downtime, and human error.

## Decision

Automate certificate lifecycle:

- Deploy cert-manager or a similar certificate operator in the Kubernetes cluster.
- Issue certificates automatically via Let's Encrypt or internal PKI.
- Use cert-manager to renew certificates without human intervention.

## Consequences

### Positive

- Reduces risk of certificate expiration and service outages.
- Simplifies certificate management across environments.

### Risks

- cert-manager requires appropriate RBAC permissions and cluster maintenance.
- Initial setup of ACME challenges or internal PKI integration can be complex.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0039-automate-certificate-authority-management-with-cert-manager.md)
- [TLS/SSL Reference](https://docs.konghq.com/gateway/latest/admin-api/certificates/)
- [Managing TLS in Kong Gateway](https://docs.konghq.com/gateway/latest/how-to/configure-tls/)
