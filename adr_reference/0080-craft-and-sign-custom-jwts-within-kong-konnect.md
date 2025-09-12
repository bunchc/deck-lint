# 80. Craft and Sign Custom JWTs Within Kong Konnect

Date: 2025-04-24

## Tags

kong, gateway, plugin, security, authentication, authorization, jwt, token-management, custom-plugins, lua-scripting, identity, token-signing, custom-claims

## Status

Accepted

## Context

JSON Web Tokens (JWTs) are widely used for stateless authentication and authorization between services. In many cases, services require tokens that are customized — with specific claims, audiences, or scopes — and cryptographically signed by a trusted authority.

Kong Konnect can be extended to programmatically generate and sign custom JWTs, providing centralized, policy-driven token issuance at the gateway layer. This is particularly useful for delegation, identity transformation, and enforcing consistent claims across internal or partner services.

## Decision

Enable custom JWT crafting and signing using Kong Konnect by:

- **Extending Kong Gateway** with a custom plugin or leveraging Lua scripting to dynamically create JWTs:

  - Construct payloads with claims such as `sub`, `aud`, `iss`, `exp`, `scope`, or custom attributes.
  - Sign tokens using a private key stored securely (e.g., via Kong Vault or injected secrets).
  - Use standard algorithms like `RS256`.

- **Use Cases**:

  - **Token Transformation**: Convert incoming opaque tokens or third-party tokens into JWTs understood by downstream systems.
  - **Delegation**: Issue tokens representing a downstream identity for call chaining or service-to-service trust.
  - **Claim Injection**: Add environment or service metadata to enhance traceability or policy enforcement.

- **Security Considerations**:
  - Maintain a short TTL (`exp`) and validate `aud` to prevent token abuse.
  - Protect private keys used for signing using vault integration or encrypted environment variables.

## Consequences

### Positive

- Enables standardized, stateless identity propagation and delegation.
- Reduces dependency on upstream IdPs for issuing internal-use JWTs.
- Supports hybrid architectures with mixed token formats or providers.

### Risks

- Incorrect claim construction can lead to unauthorized access or impersonation.
- Requires secure key management and rotation practices.
- Adds operational overhead for validating and auditing custom token logic.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0080-craft-and-sign-custom-jwts-within-kong-konnect.md)

- [Kong Gateway JWT Plugin](https://docs.konghq.com/hub/kong-inc/jwt/)
- [Kong Vault](https://docs.konghq.com/gateway/latest/kong-enterprise/vaults/)
- [Kong Blog: How to Craft and Sign Custom JWTs](https://konghq.com/blog/engineering/craft-and-sign-custom-jwt)
- [JWT Specification (RFC 7519)](https://datatracker.ietf.org/doc/html/rfc7519)
