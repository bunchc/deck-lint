# 40. Mature Zero Trust Network Posture

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, zero-trust, tls, mtls, identity, compliance, network-security, service-mesh, defense-in-depth, certificate-management, authorization

## Status

Accepted

Supported by [30. Best Practice for Gateway-to-Gateway Authentication Using mTLS](0030-best-practice-for-gateway-to-gateway-authentication-using-mtls.md)

## Context

Modern architectures require "never trust, always verify" network models. Both internal and external API traffic must be protected consistently.

## Decision

Adopt a Zero Trust approach:

- Enforce TLS for all traffic (external and internal).
- Use mTLS for service-to-service authentication.
- Validate identities at every layer (client certificates, JWTs, OIDC tokens).

## Consequences

### Positive

- Stronger security across API ecosystem.
- Simplified compliance with regulatory frameworks (e.g., PCI-DSS, HIPAA).

### Risks

- Requires careful certificate management at scale.
- Increases complexity in microservice environments if not automated.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0040-mature-zero-trust-network-posture.md)
- [mTLS Authentication Plugin](https://docs.konghq.com/hub/kong-inc/mtls-auth/)
