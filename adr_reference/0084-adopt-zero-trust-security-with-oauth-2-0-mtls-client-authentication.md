# 84. Adopt Zero Trust Security with OAuth 2.0 mTLS Client Authentication

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, authorization, zero-trust, mtls, oauth2, openid-connect, sender-constrained-tokens, client-authentication, certificate-binding, identity-verification

## Status

Accepted

## Context

In Zero Trust architectures, no client is inherently trusted — authentication and authorization must be continuously enforced and verified at every interaction point. One critical building block is **mutual TLS (mTLS)**, which authenticates both the client and server using X.509 certificates.

For OAuth 2.0 flows, mTLS can also be used as a client authentication method. This approach enables **sender-constrained tokens**, binding access tokens to a specific client identity, thus enhancing security against token theft or replay.

Kong Gateway supports OAuth 2.0 mTLS authentication and can enforce this via its **OpenID Connect plugin** and TLS configurations.

## Decision

Adopt OAuth 2.0 mTLS client authentication at Kong Gateway to enforce Zero Trust principles:

### Implementation

- **Identity Provider (IdP)**:

  - Configure the OAuth Authorization Server to accept client authentication via mTLS.
  - Issue sender-constrained access tokens that are bound to client certificates (e.g., per RFC 8705).

- **Kong Gateway**:

  - Enable mTLS termination at the gateway to validate client certificates.
  - Use the **OpenID Connect plugin** to:
    - Validate tokens presented in the `Authorization` header.
    - Optionally validate that the client certificate matches the token’s certificate thumbprint or binding.

- **Client Requirements**:
  - Clients must use a valid, provisioned client certificate when initiating token requests and accessing APIs.
  - Certificates must be rotated and revoked according to standard lifecycle policies.

## Consequences

### Positive

- Strengthens access control by binding tokens to specific clients.
- Aligns API authentication with Zero Trust security models.
- Provides strong cryptographic identity assurance for machine-to-machine communication.

### Risks

- Introduces operational complexity in issuing, rotating, and revoking client certificates.
- Client libraries and infrastructure must support TLS mutual authentication.
- Errors in certificate trust chains can lead to access denial or outages.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0084-adopt-zero-trust-security-with-oauth-2-0-mtls-client-authentication.md)

- [RFC 8705: OAuth 2.0 Mutual-TLS Client Authentication](https://datatracker.ietf.org/doc/html/rfc8705)
- [Kong OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
- [Kong mTLS Authentication Guide](https://docs.konghq.com/gateway/latest/kong-enterprise/mtls-auth/)
- [Kong Blog: Enabling Zero Trust Security with OAuth 2.0 mTLS](https://konghq.com/blog/engineering/zero-trust-oauth-2-0-mtls-client-authentication)
