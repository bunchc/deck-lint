# 49. Enforce Object-Level Authorization with OIDC and ACL Plugins

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, authorization, oidc, acl, object-level-authorization, bola, jwt, claims, access-control, identity-propagation, zero-trust, owasp

## Status

Accepted

Uses [26. OIDC Plugin Redirect URI & Flow Pattern Best Practices](0026-oidc-plugin-redirect-uri-and-flow-pattern-best-practices.md)

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

Integrated by [72. Integrate Kong Gateway with OPA for Declarative Access Control](0072-integrate-kong-gateway-with-opa-for-declarative-access-control.md)

Extended by [72. Implement Fine-Grained Access Policies Using Kong and OPA](0073-implement-fine-grained-access-policies-using-kong-and-opa.md)

Implemented by [82. Manage Application Authentication for Diverse Audiences](0082-manage-application-authentication-for-diverse-audiences.md)

## Context

APIs are often vulnerable to Broken Object Level Authorization (BOLA), where an attacker can access resources belonging to another user simply by guessing identifiers (e.g., user IDs, order numbers). Protecting each object access request with strong authorization checks is critical to API security.

## Decision

Implement object-level authorization with the following strategies:

- Use **OpenID Connect (OIDC)** plugin to authenticate API users and retrieve identity attributes (e.g., user ID, roles, groups).
- Apply the **ACL (Access Control List)** plugin to restrict access based on identity or consumer group membership.
- When possible, delegate resource authorization to backend APIs using identity claims from the validated JWT token.

Optional Enhancements:

- Enrich request headers with user metadata using Kong plugins (e.g., Request Transformer) to facilitate backend checks.
- Implement fine-grained policies through Kong’s OPA (Open Policy Agent) plugin if complex authorization is required.

## Consequences

### Positive

- Strong mitigation against Broken Object Level Authorization attacks.
- Fine-grained access control policies at both the gateway and backend layers.
- Leverages centralized authentication and identity propagation.

### Risks

- Backend services must correctly validate user identity to prevent trust boundary weaknesses.
- ACL plugin management must stay in sync with group or role membership changes.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0049-enforce-object-level-authorization-with-oidc-and-acl-plugins.md)
- [OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
- [ACL Plugin](https://docs.konghq.com/hub/kong-inc/acl/)
