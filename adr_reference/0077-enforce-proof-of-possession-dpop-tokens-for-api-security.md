# 77. Enforce Proof-of-Possession (DPoP) Tokens for API Security

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authorization, oauth2, dpop, token-binding, proof-of-possession, jwt, cryptographic-binding, token-security, replay-protection, openid connect, oidc, access token, token validation, oauth, api security, token replay

## Status

Updated

## Context

Traditional OAuth 2.0 Bearer tokens can be misused if intercepted, as possession alone grants access. **Proof-of-Possession (PoP)** tokens, particularly **DPoP (Demonstrating Proof-of-Possession at the Application Layer)**, bind access tokens to a specific client using a cryptographic key, mitigating replay attacks and unauthorized reuse.

Kong Gateway supports DPoP through its **OpenID Connect plugin**, enabling secure token validation and enforcing client-bound authorization flows in compliance with OAuth 2.0 extensions.

## Decision

Enable and configure DPoP in Kong Gateway using the **OpenID Connect (OIDC) plugin**:

- **DPoP Support in OIDC Plugin**:

  - Validate DPoP proofs included in requests as per [IETF draft](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-dpop).
  - Bind tokens to public keys during issuance (via the Identity Provider).
  - Enforce the presence and correctness of `DPoP` HTTP header (signed JWT) on protected requests.
  - Prevent token misuse by checking key confirmation, signature, method, and URI.

- **Kong Configuration**:

  - Use Kong’s OIDC plugin in `authorization_code` or `client_credentials` flows.
  - Enable `validate_dpop` in the plugin configuration to activate DPoP validation logic.
  - Log and monitor invalid DPoP attempts for observability.

- **Client Requirements**:
  - Clients must support DPoP: generate a public/private key pair, sign JWT proofs, and include them with each request.

## Consequences

### Positive

- Strong mitigation of OAuth token replay attacks.
- Fully standards-compliant (OAuth 2.0 PoP).
- Can be enforced without modifying upstream services.

### Risks

- Requires Identity Provider (IdP) support for DPoP token issuance.
- Clients must implement DPoP support, including key management and JWT signing.
- Adds cryptographic validation overhead to API Gateway processing.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0077-enforce-proof-of-possession-dpop-tokens-for-api-security.md)

- [DPoP Draft Specification](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-dpop)
- [Kong OpenID Connect Plugin - How to Validate DPoP](https://docs.konghq.com/hub/kong-inc/openid-connect/how-to/demonstrating-proof-of-possession/)
- [Kong Blog: Demonstrating Proof of Possession (DPoP)](https://konghq.com/blog/engineering/demonstrating-proof-of-possession-dpop-preventing-illegal-access-of-apis)
- [OAuth 2.0 PoP Architecture](https://tools.ietf.org/html/draft-ietf-oauth-pop-architecture)
