# 78. Utilize mTLS Sender-Constrained Tokens for Enhanced Authentication

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, mtls, sender-constrained tokens, token binding, openid connect, oidc, oauth2, certificate, api security

## Status

Accepted

Builds on [30. Best Practice for Gateway-to-Gateway Authentication Using mTLS](0030-best-practice-for-gateway-to-gateway-authentication-using-mtls.md)

Governed by [120. Configure Trusted Certificate Authorities for mTLS and Plugin Integrations](0120-configure-trusted-certificate-authorities-for-mtls-and-plugin-integrations.md)

Builds on [30. Best Practice for Gateway-to-Gateway Authentication Using mTLS](0030-best-practice-for-gateway-to-gateway-authentication-using-mtls.md)

Governed by [120. Configure Trusted Certificate Authorities for mTLS and Plugin Integrations](0120-configure-trusted-certificate-authorities-for-mtls-and-plugin-integrations.md)

## Context

Bearer tokens are vulnerable to theft and replay attacks if exposed. One robust solution is to bind tokens to the client’s TLS certificate, ensuring that tokens can only be used by the client that originally received them. This approach is called **mTLS sender-constrained access tokens**, and it's aligned with zero trust principles.

When using mTLS for OAuth 2.0 client authentication and sender-constrained access tokens, the client must present the same certificate used during token issuance in each API request. This helps prevent misuse of tokens, even if intercepted.

## Decision

Implement mTLS sender-constrained tokens in Kong Gateway to enhance API access security:

- **Client Authentication**:

  - Use mutual TLS (mTLS) to authenticate clients during OAuth token requests.
  - Configure the Identity Provider (IdP) to issue **sender-constrained tokens** (e.g., RFC8705-style).

- **Token Binding Enforcement**:

  - Use Kong's **OpenID Connect plugin** to:
    - Enforce TLS client certificate validation at the gateway.
    - Validate that the presented certificate matches the one used when the token was issued.

- **Kong Configuration**:

  - Enable `client_certificate` requirement in the OIDC plugin.
  - Use Kong Gateway’s built-in mTLS capabilities to terminate and inspect client TLS certs.
  - Optionally, log and alert on certificate mismatches or validation failures.

- **Infrastructure Support**:
  - Ensure TLS termination occurs at the Gateway to maintain access to the client certificate for downstream validation.

## Consequences

### Positive

- Strong cryptographic binding between token and client.
- Prevents token misuse even if intercepted or leaked.
- Enhances trust in machine-to-machine communication, aligning with zero trust architecture.

### Risks

- Increases certificate management complexity (issuance, rotation, revocation).
- Clients must support mTLS and manage private key material securely.
- Latency and operational overhead from TLS handshakes and certificate validation.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0078-utilize-mtls-sender-constrained-tokens-for-enhanced-authentication.md)

- [RFC 8705: OAuth 2.0 mTLS Token Binding](https://datatracker.ietf.org/doc/html/rfc8705)
- [Kong Blog: mTLS Sender-Constrained Tokens](https://konghq.com/blog/engineering/mtls-sender-constrained-tokens)
- [Kong mTLS Documentation](https://docs.konghq.com/gateway/latest/kong-enterprise/mtls-auth/)
- [Kong OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
