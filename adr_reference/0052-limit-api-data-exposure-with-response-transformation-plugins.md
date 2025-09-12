# 52. Limit API Data Exposure with Response Transformation Plugins

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, data privacy, least privilege, pii, compliance, gdpr, hipaa, response transformation, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

APIs that expose unnecessary fields or internal data increase the risk of sensitive information disclosure. Minimizing data exposure ensures that only intended, safe information reaches clients.

## Decision

Adopt the principle of "least privilege" for API responses:

- Use Kong’s **Response Transformer** or **jq** plugin to:
  - Remove unneeded fields from responses.
  - Restructure or mask sensitive fields (e.g., obfuscating PII or account details).
- Encourage backend services to return minimal, consumer-appropriate payloads by default.
- Integrate API data exposure reviews into API design and security validation processes.

Optional Enhancements:

- Automate detection of exposed fields during contract testing by comparing mock vs production payloads.
- Implement field-based access controls when APIs support different consumer profiles.

## Consequences

### Positive

- Reduces the risk of information leakage and compliance violations (e.g., GDPR, HIPAA).
- Improves API usability by limiting payload size to necessary information only.
- Strengthens consumer trust by safeguarding user data.

### Risks

- Misconfigured response transformations may unintentionally strip necessary fields.
- API evolution must be carefully managed to keep transformations aligned with contract changes.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0052-limit-api-data-exposure-with-response-transformation-plugins.md)
- [Response Transformer Plugin](https://docs.konghq.com/hub/kong-inc/response-transformer/)
