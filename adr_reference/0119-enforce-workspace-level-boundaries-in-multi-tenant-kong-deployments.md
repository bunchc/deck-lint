# 119. Enforce Workspace-Level Boundaries in Multi-Tenant Kong Deployments

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, deployment, workspaces, multi-tenant, rbac, isolation, compliance, automation

## Status

Accepted

## Context

Kong Enterprise provides the concept of **workspaces** to logically isolate configuration, credentials, plugins, and services across teams, departments, or environments. This is especially important in **multi-tenant** or **shared platform** use cases where different teams require autonomy and security boundaries.

Without proper workspace separation and governance, risks include:

- Accidental modification of shared resources
- Exposure of consumer credentials or secrets
- Inconsistent application of policies
- Difficulties in audit and compliance tracking

## Decision

Use Kong workspaces to enforce tenant-level boundaries for configuration and administration. Each team, customer, or environment should be assigned a dedicated workspace to operate in isolation.

### Implementation Guidelines

#### 1. Define Workspaces for Logical Separation

Typical workspace examples:

- Per application team (e.g., `payments`, `billing`, `catalog`)
- Per environment (e.g., `dev`, `staging`, `prod`)
- Per client/tenant (e.g., `partner-a`, `partner-b`)

Workspaces can be created via the Admin API or declarative configuration:

```bash
curl -X POST http://localhost:8001/workspaces \
  --data "name=billing"
```

#### 2. Assign RBAC Roles per Workspace

Use workspace-scoped RBAC tokens:

- Grant teams access only to their designated workspace
- Prevent cross-workspace access or misconfiguration

```bash
curl -X POST http://localhost:8001/rbac/users \
  --data "name=billing-ci" \
  --data "workspace=billing"
```

#### 3. Apply Plugins and Consumers within Workspaces

Ensure all plugin, route, and credential configurations are workspace-specific:

- No global plugins unless universally required
- Use consumer groups and tags within each workspace

#### 4. Use decK with `--workspace` Flag

Automate deployment using decK:

```bash
deck sync --workspace billing --state billing.yaml
```

This ensures configurations are safely managed per workspace without global impact.

#### 5. Audit Workspace Activity

Enable audit logging per workspace and enforce naming/tagging standards to track changes.

## Consequences

### Positive Outcomes

- Strong isolation of tenants and application teams
- Reduced blast radius of misconfigurations
- Supports compliance and auditability
- Simplifies scoped access and automation via RBAC

### Risks and Trade-offs

- Increases number of entities to manage
- Cross-workspace service reuse is non-trivial
- Risk of plugin policy duplication without shared global policies

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0119-enforce-workspace-level-boundaries-in-multi-tenant-kong-deployments.md)

- [Workspaces in Kong Enterprise](https://docs.konghq.com/gateway/latest/kong-enterprise/workspaces/)
