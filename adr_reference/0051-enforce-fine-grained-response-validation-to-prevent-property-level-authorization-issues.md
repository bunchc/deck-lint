# 51. Enforce Fine-Grained Response Validation to Prevent Property-Level Authorization Issues

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authorization, data-leakage, property-level-authorization, response-validation, json-filtering, pii-protection, sensitive-data, bola, bopla, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

Even when access control is enforced at the object level, APIs may accidentally return sensitive data properties to unauthorized users. This occurs when responses contain more fields than necessary, leading to Broken Object Property Level Authorization vulnerabilities.

## Decision

Strengthen response control by:

- Using Kong’s **Response Transformer** or **jq** plugins to filter sensitive fields from API responses at the Gateway when needed.
- Implementing **Request Validator** plugins to ensure strict schema validation for both requests and responses.
- Designing backend APIs to support scoped responses (e.g., minimize fields based on scopes or user roles).

Optional Enhancements:

- When APIs return user-specific resources, ensure the backend checks user identity before responding.
- Define response schemas in OpenAPI specifications and validate them automatically during CI/CD.

## Consequences

### Positive

- Prevents unauthorized disclosure of sensitive attributes through over-exposed APIs.
- Strengthens Data Minimization principles (privacy/security best practices).
- Reduces the attack surface exposed to consumers.

### Risks

- Increases maintenance complexity if transformations must track evolving API contracts.
- Risk of performance impact if excessive transformations are applied at runtime.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0051-enforce-fine-grained-response-validation-to-prevent-property-level-authorization-issues.md)
- [Response Transformer Plugin](https://docs.konghq.com/hub/kong-inc/response-transformer/)
- [Request Validator Plugin](https://docs.konghq.com/hub/kong-inc/request-validator/)
