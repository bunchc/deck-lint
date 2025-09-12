# 136. Apply Least Privilege Design for Kong Admin API Consumers and Automation

Date: 2025-04-25

## Tags

kong, gateway, security, admin-api, rbac, least-privilege, access-control, compliance, automation

## Status

Accepted

## Context

The Kong Admin API enables full control over critical gateway configurations including services, routes, plugins, consumers, certificates, and credentials. Improper access control or over-privileged Admin API tokens (whether for humans or automation) can result in:

- Unintended changes that destabilize traffic routing
- Security vulnerabilities due to accidental configuration exposure
- Compliance risks and audit failures

Applying the principle of least privilege ensures each Kong Admin API consumer — whether human or machine — only has the minimum necessary access to perform its role safely.

## Decision

Mandate least privilege access control for all Admin API users, service accounts, and automation systems in Kong Gateway.

### Implementation Guidelines

#### 1. Create Role-Based Access Control (RBAC) Users Per Function

- Separate users for CI/CD pipelines, API owners, platform operators, auditors
- Avoid shared tokens across different systems or teams

Example:

```bash
curl -X POST http://localhost:8001/rbac/users \
  --data "name=api-deploy-bot" \
  --data "roles=workspace-admin"
```

#### 2. Assign Minimal Necessary RBAC Roles

Prefer narrowly scoped roles over global `super-admin`:

| Role              | Use Case                                   |
| ----------------- | ------------------------------------------ |
| `read-only`       | Observability, monitoring agents           |
| `workspace-admin` | Team-specific deployment automation        |
| `admin`           | Platform SREs managing multiple workspaces |
| `super-admin`     | Reserved only for break-glass emergencies  |

#### 3. Scope Access to Specific Workspaces

If using Kong Enterprise workspaces:

- Assign users and tokens to specific workspaces
- Avoid granting cluster-wide access unless absolutely necessary

Example:

```bash
curl -X POST http://localhost:8001/rbac/users \
  --data "name=billing-team-admin" \
  --data "workspace=billing"
```

#### 4. Rotate and Expire Admin Tokens Regularly

- Issue short-lived tokens when possible
- Rotate tokens periodically (e.g., every 90 days)
- Revoke old tokens immediately upon user role change or departure

#### 5. Audit Admin API Access Patterns

- Enable Kong audit logs
- Forward logs to SIEM systems
- Alert on anomalous activity (e.g., token usage from unexpected IPs, mass deletions)

#### 6. Protect Admin API Endpoints

- Restrict Admin API access by IP range or VPN access
- Require mTLS or OAuth2 protection where possible
- Disable external access to Admin API except via trusted management networks

## Consequences

### Positive Outcomes

- Reduces blast radius of accidental or malicious configuration changes
- Simplifies compliance with security standards (e.g., ISO 27001, SOC2)
- Supports fine-grained audit trails for administrative activity
- Strengthens Kong Gateway’s operational and security posture

### Risks and Trade-offs

- Increased administrative overhead for RBAC user and token management
- Potential inconvenience for users needing temporary elevated privileges
- Requires careful planning and documentation of role mappings

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0136-apply-least-privilege-design-for-kong-admin-api-consumers-and-automation.md)

- [RBAC Management in Kong Gateway](https://docs.konghq.com/gateway/3.10.x/production/access-control/enable-rbac/#main)
