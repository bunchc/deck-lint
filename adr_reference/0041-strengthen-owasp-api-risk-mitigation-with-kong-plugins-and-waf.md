# 41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, authorization, deployment, monitoring, owasp, api-top-10, waf, input-validation, rate-limiting, bot-detection, schema-validation, data-protection, access-control, logging, observability, compliance, threat-detection

## Status

Accepted

Implemented by [49. Enforce Object-Level Authorization with OIDC and ACL Plugins](0049-enforce-object-level-authorization-with-oidc-and-acl-plugins.md)

Implemented by [50. Centralize Authentication Logic Using Kong Gateway](0050-centralize-authentication-logic-using-kong-gateway.md)

Implemented by [51. Enforce Fine-Grained Response Validation to Prevent Property-Level Authorization Issues](0051-enforce-fine-grained-response-validation-to-prevent-property-level-authorization-issues.md)

Implemented by [52. Limit API Data Exposure with Response Transformation Plugins](0052-limit-api-data-exposure-with-response-transformation-plugins.md)

Implemented by [53. Implement Rate Limiting and Size Limiting to Mitigate Resource Exhaustion](0053-implement-rate-limiting-and-size-limiting-to-mitigate-resource-exhaustion.md)

Implemented by [54. Protect Admin APIs with Route-Level ACL Enforcement](0054-protect-admin-apis-with-route-level-acl-enforcement.md)

Implemented by [55. Protect Sensitive Business Flows with Bot Detection and Rate Limiting](0055-protect-sensitive-business-flows-with-bot-detection-and-rate-limiting.md)

Implemented by [56. Enforce Schema Validation and Parameter Allowlisting to Prevent Mass Assignment](0056-enforce-schema-validation-and-parameter-allowlisting-to-prevent-mass-assignment.md)

Implemented by [57. Validate and Sanitize User Input to Mitigate SSRF Risks](0057-validate-and-sanitize-user-input-to-mitigate-ssrf-risks.md)

Implemented by [58. Harden API Deployments Against Misconfigurations](0058-harden-api-deployments-against-misconfigurations.md)

Implemented by [59. Strict Input Validation to Prevent Injection Attacks](0059-strict-input-validation-to-prevent-injection-attacks.md)

Implemented by [60. Implement API Inventory Management and Versioning Control](0060-implement-api-inventory-management-and-versioning-control.md)

Implemented by [61. Secure Third-Party API Integrations with Mutual TLS and Input Validation](0061-secure-third-party-api-integrations-with-mutual-tls-and-input-validation.md)

Implemented by [62. Enable Comprehensive API Logging and Monitoring for Incident Detection](0062-enable-comprehensive-api-logging-and-monitoring-for-incident-detection.md)

Implemented by [72. Integrate Kong Gateway with OPA for Declarative Access Control](0072-integrate-kong-gateway-with-opa-for-declarative-access-control.md)

Implemented by [69. Integrate Kong Gateway with Traceable for Enhanced API Security](0069-integrate-kong-gateway-with-traceable-for-enhanced-api-security.md)

## Context

APIs introduce new attack surfaces that differ from traditional web applications. Mitigating OWASP API Top 10 risks is essential.

## Decision

Deploy layered security measures:

- Enable API gateway plugins for request validation, rate limiting, and bot protection.
- Deploy Web Application Firewall (WAF) solutions in front of the API Gateway.
- Monitor and alert on security anomalies.

## Consequences

### Positive

- Defense-in-depth protection against API abuse.
- Faster response to evolving attack patterns.

### Risks

- Risk of false positives if WAF rules are too aggressive.
- Requires ongoing tuning of security policies.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)
- [Kong API Testing](https://docs.konghq.com/gateway/latest/kong-enterprise/inso/)
