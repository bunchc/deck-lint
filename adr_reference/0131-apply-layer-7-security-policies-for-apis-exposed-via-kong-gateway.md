# 131. Apply Layer 7 Security Policies for APIs Exposed via Kong Gateway

Date: 2025-04-25

## Tags

kong, gateway, security, waf, layer7, input-validation, authentication, authorization, rate-limiting, monitoring, owasp, compliance

## Status

Accepted

## Context

Kong Gateway operates as the entry point for API traffic in modern architectures. Without Layer 7 (application layer) security controls in place, exposed APIs are vulnerable to:

- Injection attacks (SQLi, XSS)
- Protocol misuse
- API enumeration
- Unauthorized access to sensitive data

Traditional Layer 3/4 firewalls (IP/port-based) are insufficient to mitigate API-specific threats. Therefore, Kong must enforce Layer 7 protections directly within the gateway.

## Decision

Implement a defense-in-depth strategy using Kong plugins and configuration to enforce strong application-layer security for all exposed APIs.

### Implementation Guidelines

#### 1. Apply Web Application Firewall (WAF) Protections

If available, use:

- Third-party WAF integrations (e.g., Imperva, Wallarm plugins)
- Custom validation logic using pre-function or openresty scripts

Inspect request headers, parameters, payloads, and apply blocking policies.

#### 2. Enable Input Validation Plugins

Use the following plugins where applicable:

- `request-validator`: Validate JSON schema of payloads
- `oas-validation`: Validate against OpenAPI specifications

Example (request-validator):

```bash
curl -X POST http://localhost:8001/services/my-api/plugins \
  --data "name=request-validator" \
  --data "config.schema=..."
```

Example (oas-validation):

```bash
curl -X POST http://localhost:8001/services/my-api/plugins \
  --data "name=oas-validation" \
  --data "config.spec_path=/path/to/openapi.yaml"
```

#### 3. Enforce Strict Authentication and Authorization

- Use OAuth2/OIDC for APIs where possible
- Implement scope-based or claim-based authorization for sensitive APIs
- Require mutual TLS (mTLS) for service-to-service APIs

#### 4. Apply Rate Limiting and Abuse Prevention

Protect APIs from excessive or malicious traffic:

- `rate-limiting`
- `rate-limiting-advanced`
- `bot-detection`

#### 5. Sanitize Sensitive Headers and Payloads

Use `response-transformer` or custom Lua plugins to:

- Remove sensitive headers (`Authorization`, `Cookie`) from logs
- Mask sensitive fields in API responses (e.g., PII, PCI data)

#### 6. Log and Monitor Security Events

Forward suspicious activities to SIEM platforms by:

- Logging 4xx/5xx responses
- Flagging blocked traffic
- Monitoring access patterns (e.g., brute-force attempts)

## Consequences

### Positive Outcomes

- Strong protection against common API vulnerabilities
- Improved compliance with OWASP API Security Top 10 standards
- Early detection and mitigation of malicious behavior
- Increased confidence for public API exposure

### Risks and Trade-offs

- Slight additional latency for security plugins
- Requires active maintenance and tuning of validation schemas and WAF policies
- False positives may block legitimate traffic if rules are too strict

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0131-apply-layer-7-security-policies-for-apis-exposed-via-kong-gateway.md)

- [Request Validator Plugin](https://docs.konghq.com/hub/kong-inc/request-validator/)
- [OAS Validation Plugin](https://docs.konghq.com/hub/kong-inc/oas-validation/)
