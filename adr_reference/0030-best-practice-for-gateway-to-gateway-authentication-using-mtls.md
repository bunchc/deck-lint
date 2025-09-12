# 30. Best Practice for Gateway-to-Gateway Authentication Using mTLS

Date: 2025-04-22

## Tags

mtls, authentication, security, gateway, zero-trust, kong, certificate-management, service-to-service, machine-to-machine, tls, client-certificate, identity, bi-directional-auth

## Status

Accepted

Supports [40. Mature Zero Trust Network Posture](0040-mature-zero-trust-network-posture.md)

Basis for [78. Utilize mTLS Sender-Constrained Tokens for Enhanced Authentication](0078-utilize-mtls-sender-constrained-tokens-for-enhanced-authentication.md)

## Context

In some architectures, Kong Gateway instances (e.g., running in different clusters or trust boundaries) must communicate with one another. To protect against unauthorized access, we need to ensure only authenticated requests from one Kong Gateway (A) are accepted by another Kong Gateway (B).

Several methods are possible for service-to-service authentication—IP restriction, JWT, shared secrets—but mTLS (mutual TLS) is preferred for its security guarantees and compatibility with Kong Gateway features.

## Decision

Adopt **mTLS-based authentication** for Kong-to-Kong traffic where trust and identity must be enforced between Gateways.

### Implementation Overview

#### On Gateway A (Client)

- Define a `client_certificate` using the Admin API or declarative config.
- Associate the `client_certificate` with the relevant `service` in Kong that targets Gateway B.
- Example:

```json
{
  "name": "gw-b-service",
  "protocol": "https",
  "host": "gw-b.internal",
  "port": 443,
  "client_certificate": {
    "id": "<client-cert-id>"
  },
  "tls_verify": true,
  "ca_certificates": ["<ca-cert-id>"]
}
```

#### In Gateway B (Server)

- Enable the mtls-auth plugin on a route or service that receives traffic from Gateway A.
- Configure the plugin with the appropriate CA certificate(s) that signed Gateway A’s client cert.
- Create a Kong consumer and link it to the client certificate via Subject Alternative Name (SAN) or Common Name (CN) match.

### Optional Enhancements

- Use IP restrictions or network policies (e.g., AWS security groups) to scope inbound traffic at the infrastructure level.
- If mutual trust across many gateways is required, consider a service mesh approach (e.g., Kuma/mesh plugin), though mTLS by itself suffices for smaller topologies.

### Alternatives Considered

- IP Restrictions only: simple but insecure over untrusted networks.
- Shared secrets or API keys: require additional plugin config and secure storage.
- JWT or HMAC auth: strong but adds token management overhead.
- Service mesh: robust for large-scale systems but introduces operational complexity.

## Consequences

### Positive Outcomes

- Secure, bidirectional identity validation for Gateway-to-Gateway traffic.
- TLS-based authentication is widely supported and standard in enterprise environments.
- Can be extended to support multiple trusted clients using CA trust chains.

### Risks & Trade-offs

- Requires certificate management (issuance, rotation, revocation).
- Must maintain plugin-to-certificate mapping for SAN/CN resolution.
- Slightly increased complexity versus simpler shared-secret methods.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0030-best-practice-for-gateway-to-gateway-authentication-using-mtls.md)
- [mTLS Authentication Plugin](https://docs.konghq.com/hub/kong-inc/mtls-auth/)
