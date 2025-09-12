# 57. Validate and Sanitize User Input to Mitigate SSRF Risks

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, kubernetes, ssrf, input validation, sanitization, allowlisting, openapi, request validator, egress control, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

Server-Side Request Forgery (SSRF) vulnerabilities occur when APIs fetch resources based on user input (e.g., URLs, IPs) without proper validation. Attackers can exploit SSRF to make unauthorized network requests, access internal services, or escalate privileges.

## Decision

Enforce strict validation and sanitization of all user-supplied inputs used in network calls:

- Use **Request Validator** plugin:
  - Validate request body, query parameters, and headers against allowed patterns and schemas.
- Use **OAS Validation plugin**:
  - Validate incoming API requests against a strict OpenAPI contract to restrict acceptable fields and formats.
- Implement allowlists at the backend service level:
  - Allow network requests only to known safe domains or IP ranges.
- Sanitize and normalize URLs before processing them:
  - Strip or reject dangerous URL schemes (e.g., `file://`, `gopher://`) or localhost/private IP access if unintended.

Optional Enhancements:

- Implement outbound network egress policies (e.g., firewall rules, Kubernetes network policies) to control where services can send traffic.
- Reject unexpected redirects or non-HTTP(S) protocols from URL parsing routines.

## Consequences

### Positive

- Strong reduction in the risk of SSRF vulnerabilities through proactive validation and outbound traffic control.
- Enhanced security posture for APIs that interact with third-party resources or user-supplied URLs.
- Improved trust and compliance for critical service integrations.

### Risks

- Validation rules may need to be updated when API input models evolve.
- Over-restrictive allowlists could limit legitimate integration flexibility if not planned carefully.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0057-validate-and-sanitize-user-input-to-mitigate-ssrf-risks.md)
- [Request Validator Plugin](https://docs.konghq.com/hub/kong-inc/request-validator/)
- [Kong Security Documentation](https://docs.konghq.com/gateway/latest/production/security/)
