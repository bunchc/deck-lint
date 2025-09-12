# 61. Secure Third-Party API Integrations with Mutual TLS and Input Validation

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, third-party, mtls, input validation, certificate management, api integration, allowlisting, external api, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

When consuming third-party APIs, organizations expose themselves to external risks such as trust boundary breaches, data leakage, and exploitation of weak integration points. Trust must be explicitly established and maintained, and all inbound and outbound traffic must be validated.

## Decision

Secure third-party API consumption using multiple defensive measures:

- **Mutual TLS (mTLS)**:
  - Require mutual TLS authentication between Kong Gateway and trusted external services.
  - Validate client certificates against a configured trusted Certificate Authority (CA).
- **Request Validator and OAS Validation plugins**:
  - Validate third-party responses where feasible to ensure they conform to expected formats.
  - Validate and sanitize all user-supplied input sent to third-party APIs before forwarding.
- Limit trust exposure:
  - Explicitly allowlist allowed endpoints, IPs, or domains.
  - Apply request and response transformations to enforce boundary controls.

Optional Enhancements:

- Implement circuit breakers and rate limiting on third-party API calls to prevent downstream outages from cascading.
- Audit third-party integrations regularly for security and operational risks.

## Consequences

### Positive

- Establishes strong trust relationships with third-party services through authenticated channels.
- Reduces the risk of exploitation via insecure or compromised external APIs.
- Provides traceability and auditability of external API interactions.

### Risks

- mTLS setup and certificate management introduce additional operational complexity.
- Validation schemas must evolve alongside third-party API contract changes.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0061-secure-third-party-api-integrations-with-mutual-tls-and-input-validation.md)

- [mTLS Authentication Plugin](https://docs.konghq.com/hub/kong-inc/mtls-auth/)
- [Certificate Management](https://docs.konghq.com/gateway/latest/admin-api/certificates/)
