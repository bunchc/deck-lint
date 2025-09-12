# 59. Strict Input Validation to Prevent Injection Attacks

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, input-validation, injection, owasp, schema-validation, sanitization, data-protection, validation, sql injection, nosql injection, command injection, defense in depth, api security, input filtering, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

Injection attacks—such as SQL injection, LDAP injection, command injection, or NoSQL injection—occur when unvalidated or improperly sanitized user inputs are interpreted as executable commands or queries. APIs must strictly validate and sanitize all incoming data to prevent such attacks.

## Decision

Adopt comprehensive input validation strategies across the API platform:

- **Request Validator plugin**:
  - Enforce strict schema validation for request payloads, query parameters, and headers.
  - Reject requests containing unexpected, malformed, or dangerous input types.
- **OAS Validation plugin**:
  - Validate incoming requests against OpenAPI specifications to enforce structure, types, allowed patterns, and value ranges.
- **Sanitization and normalization**:
  - Apply backend-level input sanitization for fields that interact with databases, command interpreters, or external systems.
  - Encode or escape special characters appropriately based on data context (e.g., HTML encoding for rendered fields).

Optional Enhancements:

- Integrate static application security testing (SAST) and dynamic API scanning into CI/CD pipelines to detect injection risks.
- Apply defense-in-depth by validating input at both Gateway and backend layers.

## Consequences

### Positive

- Strongly mitigates risks associated with SQLi, NoSQLi, OS command injections, and other common input-based attacks.
- Improves system robustness and reduces the likelihood of critical security incidents.
- Increases confidence in API security posture during audits and assessments.

### Risks

- Validation schemas must be continuously updated to match evolving API contracts.
- Overly strict input rules may inadvertently reject legitimate but unusual client inputs if not carefully designed.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0059-strict-input-validation-to-prevent-injection-attacks.md)

- [Request Validator Plugin](https://docs.konghq.com/hub/kong-inc/request-validator/)
- [OAS Validation Plugin](https://docs.konghq.com/hub/kong-inc/oas-validation/)
- [CORS Plugin](https://docs.konghq.com/hub/kong-inc/cors/)
