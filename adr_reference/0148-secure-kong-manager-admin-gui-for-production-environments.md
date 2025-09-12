# 148. Secure Kong Manager (Admin GUI) for Production Environments

Date: 2025-04-25

## Tags

kong, gateway, admin-gui, kong-manager, security, rbac, authentication, tls, access-control, compliance, monitoring, hardening

## Status

Accepted

Builds on [123. Harden Kong Gateway Admin API for Production Environments](0123-harden-kong-gateway-admin-api-for-production-environments.md)

## Context

Kong Manager provides a graphical user interface (GUI) for managing services, routes, consumers, plugins, and more within Kong Gateway.  
While convenient for platform teams and API owners, the Kong Manager interface presents significant risks if not properly secured:

- Unauthorized users could manipulate live gateway configurations.
- Sensitive credentials, certificates, and plugin settings could be exposed.
- Non-compliant administrative access paths could violate internal or external security standards.

Thus, Kong Manager must be treated as a high-value administrative interface and secured with strong access controls, encryption, monitoring, and auditability.

## Decision

Apply strict security controls to protect Kong Manager deployments in production environments.

### Implementation Guidelines

#### 1. Require HTTPS/TLS for All Kong Manager Access

- Always deploy Kong Manager behind HTTPS.
- Use certificates signed by trusted certificate authorities (CAs).
- Implement automatic certificate renewal via ACME, Let's Encrypt, or corporate PKI integrations.

Example `kong.conf` settings:

```yaml
admin_gui_ssl_cert = /etc/kong/ssl/admin.crt
admin_gui_ssl_cert_key = /etc/kong/ssl/admin.key
```

#### 2. Restrict Network Access to Kong Manager

- Limit Kong Manager access to trusted networks only (e.g., VPN, internal corporate networks).
- Apply IP whitelisting at load balancers, Kubernetes Ingress, or network security groups (NSGs).
- For external access, enforce strong firewall rules and secure tunnels.

#### 3. Require RBAC Authentication for All Users

- Enable Kong Enterprise RBAC (Role-Based Access Control) for Kong Manager.
- Integrate with Single Sign-On (SSO) providers via OpenID Connect or LDAP.
- Enforce MFA (multi-factor authentication) through IdP integration.

User roles should be strictly defined:

- **Super Admins**: Only minimal, designated individuals.
- **Workspace Admins**: Per-team scoped access.
- **Read-Only Users**: Observability only.

Disable default anonymous access to Kong Manager.

#### 4. Audit Administrative Actions

- Enable audit logging for all Admin API and Kong Manager operations.
- Forward logs to SIEM or log aggregation platforms (e.g., Splunk, Datadog).
- Alert on critical actions (e.g., role escalations, credential changes, plugin deletions).

Ensure that administrative actions through Kong Manager are fully traceable.

#### 5. Implement GUI Session Management

- Enforce session expiration (timeout) policies.
- Prefer short-lived session tokens (e.g., 15–30 minutes of inactivity).
- Use secure cookies (with `Secure`, `HttpOnly`, and `SameSite` attributes).

#### 6. Disable Unused Interfaces

- If Admin API and Kong Manager GUIs are served separately, ensure only intended interfaces are exposed externally.
- Disable Kong Manager altogether in high-security environments where only declarative GitOps management is preferred.

#### 7. Monitor GUI Access Patterns

- Track Kong Manager logins and access logs for unusual patterns:
  - Access from unfamiliar IPs
  - Excessive failed login attempts
  - Changes during maintenance freezes
- Alert security teams on anomalous behavior.

## Consequences

### Positive Outcomes

- Protects administrative control of Kong Gateway from unauthorized access
- Strengthens compliance alignment (e.g., PCI-DSS, SOC2, HIPAA)
- Enables full visibility into platform administrative operations
- Reduces risk of accidental misconfigurations by unauthorized users

### Risks and Trade-offs

- Adds minor operational overhead for RBAC, SSO, and session management configuration
- May slightly delay administrative actions if access flows are tightly secured
- Requires careful coordination with identity, security, and networking teams

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0148-secure-kong-manager-admin-gui-for-production-environments.md)

- [Kong Manager Authentication and RBAC](https://docs.konghq.com/gateway/latest/kong-enterprise/admin-gui/rbac/)
- [Kong Audit Logging Documentation](https://docs.konghq.com/gateway/latest/kong-enterprise/audit-logging/)
- [Best Practices for Securing Web Admin Interfaces](https://owasp.org/www-project-top-ten/)
- Kong Go-Live Hardening Checklist – Admin GUI Protection
