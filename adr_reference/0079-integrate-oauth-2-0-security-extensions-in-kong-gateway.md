# 79. Integrate OAuth 2.0 Security Extensions in Kong Gateway

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authorization, oauth2, pkce, jar, token-binding, dpop, jwt, oidc, security-extensions, zero-trust, token-security, nonce, oauth, openid connect, csrf, state, fapi, security best practices, token validation

## Status

Accepted

## Context

The OAuth 2.0 standard has known vulnerabilities in its core flows, especially when applied to modern mobile and browser-based clients. To address these issues, several security extensions have been Accepted and widely adopted to strengthen token exchange, authorization requests, and client binding.

Kong Gateway, when used as an OAuth 2.0-compliant resource server or token introspection gateway, should support and enforce these modern security enhancements for better protection against threats like token leakage, CSRF, replay, and mix-up attacks.

## Decision

Enhance OAuth 2.0 flows at Kong Gateway by adopting the following security extensions:

- **PKCE (Proof Key for Code Exchange)**:

  - Enforce PKCE for public clients to protect against authorization code interception attacks.
  - Use `code_challenge` and `code_verifier` in OIDC plugin configuration and validate during token issuance.

- **JWT Secured Authorization Requests (JAR)**:

  - Require authorization requests to be signed using JWTs, ensuring that the request parameters are tamper-proof.
  - Leverage JAR to support confidential communication of sensitive scopes or redirection URIs.

- **Token Binding and Sender Constrained Tokens**:

  - Enforce token binding using mTLS or DPoP.
  - Ensure that access tokens are unusable outside their intended client context.

- **Nonce and State Validation**:

  - Rigorously enforce `nonce` and `state` checks to prevent CSRF and replay attacks in implicit or hybrid flows.

- **Use of Signed Tokens (JWT Access Tokens)**:
  - Prefer signed JWTs over opaque tokens where possible to reduce introspection dependencies and enable stateless verification at the gateway.

## Consequences

### Positive

- Significantly improves the security of OAuth 2.0 implementations.
- Ensures compliance with evolving industry best practices (e.g., FAPI, OWASP).
- Reduces risk of interception, forgery, or misrouting of tokens and authorization codes.

### Risks

- Increased configuration complexity for clients and identity providers.
- Requires additional cryptographic key management and validation logic.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0079-integrate-oauth-2-0-security-extensions-in-kong-gateway.md)

- [OAuth 2.0 PKCE (RFC 7636)](https://datatracker.ietf.org/doc/html/rfc7636)
- [OAuth 2.0 JAR (RFC 9101)](https://datatracker.ietf.org/doc/html/rfc9101)
- [Kong OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
- [Kong Blog: 3 Extensions to Improve OAuth 2.0 Security](https://konghq.com/blog/engineering/3-extensions-to-improve-security)
