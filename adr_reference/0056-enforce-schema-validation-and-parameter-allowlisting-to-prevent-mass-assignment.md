# 56. Enforce Schema Validation and Parameter Allowlisting to Prevent Mass Assignment

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authorization, input validation, schema validation, allowlisting, mass assignment, oas, json schema, api security, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

Mass Assignment vulnerabilities occur when APIs bind all incoming client parameters directly to internal objects without filtering or validating them. Attackers can exploit this to modify unintended fields like user roles, permissions, or financial limits, leading to privilege escalation or data corruption.

## Decision

Adopt strong input validation and allowlisting strategies at the API Gateway:

- **OAS Validation plugin**:
  - Validate incoming requests against a published OpenAPI (OAS) specification.
  - Ensure only explicitly defined fields are accepted, rejecting unexpected or extra parameters automatically.
- **Request Validator plugin** (where OpenAPI spec is not available):
  - Define JSON schema validations to enforce field allowlisting manually.
- Encourage backend services to also validate fields at the application layer (defense in depth).

Optional Enhancements:

- Integrate OpenAPI contract validation into CI/CD pipelines to detect schema drift early.
- Implement fine-grained authorization policies on sensitive fields even after validation (e.g., some fields updatable only by admins).

## Consequences

### Positive

- Eliminates risks of unintended field manipulation through Mass Assignment.
- Guarantees strict adherence to API contracts, improving both security and developer experience.
- Facilitates easier auditing and compliance reviews.

### Risks

- Requires up-to-date and well-maintained OpenAPI specifications.
- Potential client friction if unexpected fields are silently rejected without clear error messaging.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0056-enforce-schema-validation-and-parameter-allowlisting-to-prevent-mass-assignment.md)
- [Request Validator Plugin](https://docs.konghq.com/hub/kong-inc/request-validator/)
- [OAS Validator Plugin](https://docs.konghq.com/hub/kong-inc/oas-validation/)
