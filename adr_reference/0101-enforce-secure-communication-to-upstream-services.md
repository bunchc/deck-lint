# 101. Enforce Secure Communication to Upstream Services

Date: 2025-04-25

## Tags

kong, api, gateway, security, kubernetes, tls, mtls, upstream, encryption, zero-trust, compliance, certificate-management

## Status

Accepted

## Context

Kong Gateway, by default, allows communication with upstream services over HTTP or HTTPS. In production, transmitting traffic in clear text from Kong to upstreams introduces a security risk, especially for services handling sensitive data.

To mitigate man-in-the-middle (MITM) attacks and maintain end-to-end confidentiality, it is critical to enforce HTTPS or mutual TLS (mTLS) when Kong connects to upstream services.

## Decision

All communication from Kong to upstream APIs and services must be encrypted using HTTPS or mTLS. The choice depends on the security posture of the organization and the sensitivity of the transmitted data.

### For HTTPS:

- Set the `protocol` field of each Kong `Service` to `https`
- (Optional) Enable `tls_verify` to validate the upstream’s certificate
- (Optional) Pin to a known CA by setting `ca_certificates`

Example:

```json
{
  "name": "orders-api",
  "protocol": "https",
  "host": "orders.internal.svc",
  "port": 443,
  "tls_verify": true,
  "ca_certificates": ["abc123-ca-cert-id"]
}
```

For mTLS:

- Configure the client_certificate property in the Kong Service
- Provide the certificate and key using the Admin API or Kubernetes secrets
- Upstream must be configured to require and validate the client certificate

Example:

```json
{
  "name": "secure-api",
  "protocol": "https",
  "host": "secure.api.svc",
  "port": 443,
  "client_certificate": {
    "id": "abc123-client-cert-id"
  },
  "tls_verify": true
}
```

## Consequences

### Positive Outcomes

- Prevents interception or tampering of API traffic.
- Enables strong upstream service identity verification using client certs.
- Aligns with Zero Trust and regulatory requirements (e.g., PCI-DSS, HIPAA).

### Risks and Trade-offs

- Requires certificate lifecycle management (provisioning, rotation).
- May add slight performance overhead for TLS handshakes.
- Misconfigurations can result in failed upstream connectivity.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0101-enforce-secure-communication-to-upstream-services.md)

- [Kong: Configuring TLS for Upstreams](https://docs.konghq.com/gateway/latest/how-kong-works/routing-traffic/#proxy-tcptls-traffic)
