# 120. Configure Trusted Certificate Authorities for mTLS and Plugin Integrations

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, authentication, deployment, mtls, tls, ca, certificate, security, upstream, oidc, header-cert-auth, compliance

## Status

Accepted

Governs [78. Utilize mTLS Sender-Constrained Tokens for Enhanced Authentication](0078-utilize-mtls-sender-constrained-tokens-for-enhanced-authentication.md)

## Context

Mutual TLS (mTLS), upstream authentication, and certain Kong plugins rely on the verification of certificates. Proper configuration of trusted Certificate Authorities (CAs) is essential for:

- Validating client certificates in mTLS scenarios
- Securing Kong’s communication with upstream services or identity providers
- Ensuring data integrity in plugins like `mtls-auth`, `openid-connect`, or `header-cert-auth`

If Kong is not configured with the correct CA certificates, it may reject legitimate requests, fail to establish secure upstream connections, or expose the system to impersonation attacks.

## Decision

Configure Kong to use trusted CA bundles for all relevant components, ensuring secure and verifiable TLS communication.

### Implementation Guidelines

#### 1. Upload CA Certificates to Kong

Use the Admin API or declarative configuration to add trusted CA certs:

```bash
curl -X POST http://localhost:8001/ca_certificates \
  --data "cert=@my-ca.crt" \
  --data "tags[]=trusted"
```

You can retrieve the certificate ID from the response, which will be referenced in later steps.

#### 2. Reference CAs in Plugins

Use the `ca_certificates` field when configuring plugins like `mtls-auth`:

```bash
curl -X POST http://localhost:8001/plugins \
  --data "name=mtls-auth" \
  --data "config.ca_certificates[]=abc123-def456"
```

This ensures only client certs signed by a known CA will be accepted.

#### 3. Configure Client Authentication for Upstreams

When Kong connects to upstreams over mTLS, use the `ca_certificates` and `client_certificate` fields in the `Service` entity:

```json
{
  "name": "payments-api",
  "url": "https://payments.internal",
  "client_certificate": { "id": "client-cert-id" },
  "ca_certificates": ["trusted-ca-id"],
  "tls_verify": true
}
```

#### 4. Secure Plugin Integrations (OIDC, Header Cert Auth)

- OIDC plugins may validate identity provider certificates
- Header-based auth plugins (e.g., AWS ALB + `header-cert-auth`) rely on validating TLS headers injected by upstream proxies

Always reference the correct trusted CA bundle for these validations.

#### 5. Keep CA Bundles Updated

Monitor and rotate trusted CA certificates as needed:

- When root/intermediate certificates expire or are revoked
- When partners or platforms rotate CA infrastructure

Automate this using CI/CD and GitOps for declarative deployments.

## Consequences

### Positive Outcomes

- Secures communication across gateways, services, and identity providers
- Prevents unauthorized access via untrusted or rogue certificates
- Enables strong identity assertion through mTLS and secure plugins

### Risks and Trade-offs

- Incorrect CA configuration may result in failed requests or service downtime
- Requires operational discipline for rotation and validation
- Plugin configurations may silently fail if misconfigured

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0120-configure-trusted-certificate-authorities-for-mtls-and-plugin-integrations.md)

- [mTLS Auth Plugin](https://docs.konghq.com/hub/kong-inc/mtls-auth/)
- [Header Cert Auth Plugin](https://docs.konghq.com/hub/kong-inc/header-cert-auth/)
