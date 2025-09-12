# 111. Enforce TLS for All Inbound and Outbound Connections

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, tls, mtls, encryption, compliance, zero-trust, hardening

## Status

Accepted

## Context

Transport Layer Security (TLS) is essential for ensuring the confidentiality and integrity of data in transit. In an API gateway context, this includes both:

- **Inbound traffic**: from clients to Kong (API consumers)
- **Outbound traffic**: from Kong to upstream services (API producers)

Failure to enforce TLS on either side risks exposing sensitive information, credentials, or business data. It may also violate compliance requirements such as PCI-DSS, HIPAA, or internal InfoSec standards.

## Decision

Kong Gateway must be configured to require TLS on all external-facing and internal service-to-service connections, except where explicitly required otherwise (e.g., health checks in test environments).

### Inbound TLS Configuration

#### 1. Enable HTTPS Proxy Port

```yaml
env:
  - name: KONG_PROXY_LISTEN
    value: "0.0.0.0:8443 ssl"
```

Ensure that valid certificates are provisioned via:

- Static files (for self-managed Kong)
- ACME plugin (for automated Let's Encrypt)
- External ingress controller (e.g., terminating TLS at Envoy/Nginx before Kong)

#### 2. Disable HTTP Proxy Port Unless Needed

```yaml
env:
  - name: KONG_PROXY_LISTEN
    value: "0.0.0.0:8443 ssl"
```

Or restrict HTTP to internal-only access when required.

### Outbound TLS Configuration

#### 1. Use HTTPS for Upstream URLs

Ensure `url`, `host`, and `protocol` fields in `service` entities specify `https`.

#### 2. Verify TLS Certificates

Set `tls_verify = true` and provide CA certificates if upstream services use private or internal PKI.

Example:

```json
{
  "name": "secure-service",
  "url": "https://backend.internal/api",
  "tls_verify": true,
  "ca_certificates": ["06d04e57-78fe-4801-97ee-ad14857f98cf"]
}
```

#### 3. Client Certificates (Optional)

Use mutual TLS (mTLS) for sensitive upstreams requiring identity authentication.

## Consequences

### Positive Outcomes

- Protects sensitive data in transit across all traffic paths
- Meets enterprise security and compliance standards
- Enables advanced use cases like mutual TLS and service mesh integrations

### Risks and Trade-offs

- TLS misconfiguration can cause service disruptions
- Performance overhead from encryption (minor in most cases)
- Requires certificate lifecycle management (provisioning, rotation, renewal)

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0111-enforce-tls-for-all-inbound-and-outbound-connections.md)

- [mTLS Authentication Plugin](https://docs.konghq.com/hub/kong-inc/mtls-auth/)
