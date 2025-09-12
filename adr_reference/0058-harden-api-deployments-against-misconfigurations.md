# 58. Harden API Deployments Against Misconfigurations

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, authorization, deployment, misconfiguration, default-deny, cors, rbac, deck, security posture, api hardening, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

Misconfigurations—such as overly permissive routes, missing authentication on admin endpoints, improper CORS settings, or leaked environment variables—are among the most common and severe API security issues. Hardened defaults and careful configuration reviews are essential.

## Decision

Adopt the following best practices to secure API deployments:

- Enforce **default-deny** posture:
  - All APIs must explicitly define authentication, authorization, and validation requirements.
- Use **OAS Validation** plugin:
  - Validate API request and response structures based on strict OpenAPI contracts to detect deviations early.
- Apply **CORS plugin** carefully:
  - Configure allowed origins, methods, and headers explicitly.
  - Avoid wildcard `*` settings unless absolutely necessary and safe.
- Restrict access to Kong Admin APIs:
  - Use IP allowlists, RBAC, mTLS authentication, and ACL plugins where applicable.
- Regularly audit Gateway configurations:
  - Review deployed services, routes, and plugins for consistency with security best practices.

Optional Enhancements:

- Integrate Kong’s declarative config (`decK`) drift detection to identify unintended changes in infrastructure as code workflows.
- Establish a regular API Security Posture Review process during production readiness assessments.

## Consequences

### Positive

- Greatly reduces the attack surface due to overlooked misconfigurations.
- Improves compliance with industry regulations and audit standards.
- Provides a consistent security baseline across all APIs.

### Risks

- Hardening defaults may temporarily break non-compliant legacy clients.
- Requires developer enablement and education on proper security configuration patterns.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0058-harden-api-deployments-against-misconfigurations.md)

- [Kong Security Documentation](https://docs.konghq.com/gateway/latest/production/security/)
- [Kong Configuration Guide](https://docs.konghq.com/gateway/latest/reference/configuration/)
