# 108. Secure the Admin API with IP Restrictions and Authentication

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, kubernetes, admin-api, ip-restriction, access-control, rbac, defense-in-depth, least-privilege, admin-security, network-security

## Status

Accepted

Implements [114. Enable Audit Logging for the Admin API](0114-enable-audit-logging-for-the-admin-api.md)

Basis for [115. Protect the Admin API with Rate Limiting and DDoS Controls](0115-protect-the-admin-api-with-rate-limiting-and-ddos-controls.md)

Basis for [123. Harden Kong Gateway Admin API for Production Environments](0123-harden-kong-gateway-admin-api-for-production-environments.md)

## Context

The Kong Admin API is a powerful interface used for managing services, routes, plugins, consumers, and more. Unrestricted access to this API can result in severe security breaches, including unauthorized configuration changes, credential disclosure, or traffic disruption.

In production environments, access to the Admin API must be strictly controlled using a defense-in-depth approach: network-level controls (IP allowlists), authentication mechanisms (e.g., RBAC tokens or OIDC), and protocol-level encryption (HTTPS/mTLS).

## Decision

Restrict access to the Kong Admin API using a combination of the following mechanisms:

### 1. IP Allowlisting

Limit access to the Admin API port (default `8001`) to trusted IP ranges (e.g., platform CI/CD pipelines, Kong admins, secure VPN networks).

In a Kubernetes or cloud environment, use:

- Security groups
- Network policies
- Ingress firewall rules

### 2. Admin API Authentication

Enable authentication on the Admin API using RBAC tokens or the OpenID Connect plugin.

Example (RBAC Token):

```bash
curl -X POST http://localhost:8001/rbac/users \
  --data "name=admin-user" \
  --data "user_token=<secure-token>" \
  --data "enabled=true"
```

RBAC roles can be used to scope privileges:

- read-only
- admin
- workspace-admin

3. HTTPS / TLS

Expose the Admin API only over HTTPS. Use valid certificates from an internal or public CA.

Set the following:

```yaml
KONG_ADMIN_LISTEN=0.0.0.0:8444 ssl
KONG_ADMIN_SSL_CERT=/path/to/cert.pem
KONG_ADMIN_SSL_CERT_KEY=/path/to/key.pem
```

4. Disable Public Access

If Kong is deployed in a cluster behind a load balancer, ensure the Admin API is not exposed to the internet.

In Konnect, the Admin API is managed through the SaaS control plane and should be accessed only through Konnect’s secure interface.

Consequences

Positive Outcomes

- Prevents unauthorized changes to Kong’s configuration.
- Reduces attack surface area in production environments.
- Enables auditability and access control through RBAC.

Risks and Trade-offs

- Adds operational complexity in securing CI/CD pipelines and admin access workflows.
- Misconfigured IP rules or RBAC roles may block legitimate access.
- RBAC tokens must be stored and rotated securely.

References

- [Admin API Security Guidelines](https://docs.konghq.com/gateway/latest/production/running-kong/secure-admin-api/#main)

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0108-secure-the-admin-api-with-ip-restrictions-and-authentication.md)
