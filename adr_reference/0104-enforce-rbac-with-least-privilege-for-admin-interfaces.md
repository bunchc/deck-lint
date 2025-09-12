# 104. Enforce RBAC with Least Privilege for Admin Interfaces

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, authorization, rbac, admin-api, least-privilege, role-based-access, privilege-management, access-control, admin-security, identity-management

## Status

Accepted

## Context

Kong Gateway exposes powerful management interfaces such as the Admin API, Kong Manager (GUI), and Dev Portal. These interfaces allow operations such as adding services, updating routing, or modifying plugins — all of which could impact the traffic flow or security posture of APIs.

Without Role-Based Access Control (RBAC), all users or systems with access to the Admin API or UI could perform any action, increasing the risk of misconfiguration, service disruption, or unauthorized access. Production-grade systems must limit administrative access based on the principle of least privilege.

## Decision

RBAC must be enabled for all Kong Enterprise control plane interfaces in production environments.

### Implementation Recommendations

#### Admin API:

- **Enable RBAC** by configuring RBAC roles, tokens, or integrating with external identity providers (via OpenID Connect or LDAP).
- Use **workspace-scoped RBAC** where appropriate.
- Lock down access to Admin API using:
  - Network policies (e.g., IP whitelisting or private subnets)
  - Authentication (OIDC, JWT, Basic Auth)
  - Authorization (RBAC roles)

#### Kong Manager:

- Configure Kong Manager login via an identity provider (e.g., Okta, Azure AD) using the OpenID Connect plugin.
- Use **RBAC roles** (e.g., read-only, workspace editor, super admin) to restrict operations based on user responsibility.
- Disable Kong Manager in environments where UI access is not required.

#### Dev Portal:

- Enable login protection and RBAC for Portal user roles.
- Avoid exposing developer onboarding interfaces without authentication.

## Consequences

### Positive Outcomes

- Prevents privilege escalation and unauthorized changes to gateway configuration.
- Supports auditability and compliance with enterprise access control standards.
- Enables fine-grained delegation of responsibility across teams or tenants.

### Risks and Trade-offs

- Increases configuration complexity and user management overhead.
- Requires mapping organizational roles to Kong-specific privileges.
- Misconfiguration of RBAC could inadvertently block access or grant excessive permissions.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0104-enforce-rbac-with-least-privilege-for-admin-interfaces.md)

- [RBAC Overview](https://docs.konghq.com/gateway/latest/production/access-control/enable-rbac/)
- [Admin API Security](https://docs.konghq.com/gateway/latest/reference/configuration/#admin_listen)
- [Kong Manager Access Control](https://docs.konghq.com/gateway/latest/kong-manager/auth/rbac/)
- [OIDC Plugin for Authentication](https://docs.konghq.com/hub/kong-inc/openid-connect/)
