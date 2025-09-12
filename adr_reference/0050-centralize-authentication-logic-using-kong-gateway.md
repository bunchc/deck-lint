# 50. Centralize Authentication Logic Using Kong Gateway

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, authorization, identity, access control, oidc, mtls, api security, compliance, owasp

## Status

Accepted

Implemented by [26. OIDC Plugin Redirect URI & Flow Pattern Best Practices](0026-oidc-plugin-redirect-uri-and-flow-pattern-best-practices.md)

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

Integrated by [72. Integrate Kong Gateway with OPA for Declarative Access Control](0072-integrate-kong-gateway-with-opa-for-declarative-access-control.md)

Implemented by [82. Manage Application Authentication for Diverse Audiences](0082-manage-application-authentication-for-diverse-audiences.md)

## Context

Authentication inconsistencies across APIs increase the risk of security gaps, token misuse, and misconfigured access controls. Centralizing authentication enforcement at the API Gateway ensures consistency and simplifies management across services.

## Decision

Use Kong Gateway to centralize and enforce all API authentication by:

- Configuring authentication plugins such as:
  - **OIDC (OpenID Connect)** for token-based authentication using enterprise identity providers.
  - **Key Authentication** for static token validation.
  - **HMAC Authentication** for secure API key use cases.
- Validating authentication at the Gateway layer before forwarding requests to upstream services.
- Optionally injecting validated identity information (e.g., claims, user IDs) into upstream requests via headers for backend authorization.

Optional Enhancements:

- Require mutual TLS (mTLS) for sensitive machine-to-machine communications.
- Use plugin chaining to support multi-factor authentication scenarios (e.g., API key + JWT).

## Consequences

### Positive

- Eliminates inconsistent authentication logic across services.
- Simplifies auditing and compliance reporting.
- Reduces developer burden by handling authentication at the platform level.

### Risks

- Backend services must still enforce object-level and business-level authorization independently.
- Misconfigured authentication plugins at the Gateway can introduce systemic vulnerabilities.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0050-centralize-authentication-logic-using-kong-gateway.md)
- [Authentication Guide](https://docs.konghq.com/gateway/latest/how-to/authentication/)
- [Kong Authentication Plugins](https://docs.konghq.com/hub/#authentication)
