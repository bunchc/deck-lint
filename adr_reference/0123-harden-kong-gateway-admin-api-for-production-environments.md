# 123. Harden Kong Gateway Admin API for Production Environments

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, admin-api, rbac, tls, transport-security, network-restriction, production-hardening, defense-in-depth, workspace-scoping, access-control, hardening, compliance, audit-logging

## Status

Accepted

Builds on [108. Secure the Admin API with IP Restrictions and Authentication](0108-secure-the-admin-api-with-ip-restrictions-and-authentication.md)

Builds on [114. Enable Audit Logging for the Admin API](0114-enable-audit-logging-for-the-admin-api.md)

Basis for [148. Secure Kong Manager (Admin GUI) for Production Environments](0148-secure-kong-manager-admin-gui-for-production-environments.md)

## Context

The Kong Admin API provides full access to all configuration objects including services, routes, plugins, credentials, certificates, and consumers. In production environments, unrestricted or exposed Admin API access poses a severe risk to availability, confidentiality, and integrity.

By default, the Admin API may be accessible over HTTP or without access control. If not properly protected, attackers could manipulate the configuration or extract sensitive information.

## Decision

Harden the Admin API using a combination of transport-layer security, network restrictions, authentication, and RBAC controls.

### Implementation Guidelines

#### 1. Disable HTTP and Require HTTPS

Only expose the Admin API over HTTPS using a valid TLS certificate:

```yaml
admin_gui_ssl_cert: /etc/kong/ssl/admin.crt
admin_gui_ssl_cert_key: /etc/kong/ssl/admin.key
```

Avoid using self-signed certs unless access is internal-only and trusted.

#### 2. Restrict Admin API Listener

Bind the Admin API listener only to a private interface:

```yaml
admin_listen: 127.0.0.1:8001 ssl
```

If remote access is required, use firewall rules or mTLS to restrict which clients can connect.

#### 3. Enable Kong Enterprise RBAC

Use RBAC tokens to authenticate and authorize users or automation tools:

```bash
curl -i -X POST http://localhost:8001/rbac/users \
  --data "name=ci-bot" \
  --data "roles=read-only"
```

Assign only necessary permissions based on principle of least privilege.

#### 4. Monitor Admin API Access

- Enable and ship Admin API logs using plugins such as `http-log`
- Review access patterns and alert on suspicious behavior
- Rotate RBAC tokens periodically

#### 5. Use Workspace Scoping

If using Kong Enterprise workspaces, scope RBAC tokens to individual workspaces to prevent cross-tenant access.

#### 6. Consider Admin API Gateway Proxy

In some environments, place Kong's Admin API behind another API gateway that handles additional:

- Authentication (e.g., OIDC, mTLS)
- Rate limiting or audit logging
- Header injection or masking

## Consequences

### Positive Outcomes

- Prevents unauthorized access to critical infrastructure APIs
- Enables fine-grained access control via RBAC
- Reduces exposure to accidental or malicious configuration changes
- Supports regulatory compliance and audit requirements

### Risks and Trade-offs

- Increases complexity for automation and troubleshooting
- Requires management of RBAC roles, tokens, and audit logs
- Must balance between accessibility and lockdown for platform teams

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0123-harden-kong-gateway-admin-api-for-production-environments.md)
