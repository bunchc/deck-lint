# 54. Protect Admin APIs with Route-Level ACL Enforcement

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, authorization, admin api, acl, access control, mtls, rbac, privileged access, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

Implemented by [82. Manage Application Authentication for Diverse Audiences](0082-manage-application-authentication-for-diverse-audiences.md)

## Context

Administrative or privileged APIs (e.g., configuration endpoints, user management APIs) require strict access controls. Failure to protect these APIs can lead to severe privilege escalation or system compromise.

## Decision

Protect administrative APIs at the API Gateway layer using:

- **ACL (Access Control List) plugin**:
  - Enforce that only authenticated, authorized consumers belonging to specific groups can access admin or sensitive routes.
- **Route-specific security configuration**:
  - Apply stronger authentication methods (e.g., mutual TLS, OAuth2 scopes) to administrative routes compared to public API routes.
- **Differentiated routing**:
  - Isolate administrative routes behind separate ingress paths, IP restrictions, or dedicated Virtual Services (if applicable).

Optional Enhancements:

- Enable Kong’s mTLS plugin for Admin APIs requiring machine-to-machine trust validation.
- Require multi-factor authentication for users accessing sensitive Admin APIs.

## Consequences

### Positive

- Strong mitigation against Broken Function Level Authorization vulnerabilities.
- Reduces risk of unauthorized access to privileged operations.
- Centralized enforcement simplifies auditing and access reviews.

### Risks

- ACL group memberships must be tightly managed and audited.
- Overly broad ACL configurations could expose Admin APIs to unintended users.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0054-protect-admin-apis-with-route-level-acl-enforcement.md)
- [Admin API RBAC](https://docs.konghq.com/gateway/latest/kong-enterprise/rbac/examples/)
- [ACL Plugin](https://docs.konghq.com/hub/kong-inc/acl/)
