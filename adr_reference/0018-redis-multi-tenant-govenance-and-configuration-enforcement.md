# 18. Multi‑Tenant Governance & Configuration Enforcement

Date: 2025-04-22

## Tags

redis, multi-tenant, governance, configuration, enforcement

## Status

Accepted

Governs [16. Sync‑Rate Policy for Rate‑Limiting Advanced & Service Protection Plugins](0016-sync-rate-policy-for-rate-limiting-advanced-and-service-protection-plugins.md)

Governs [17. Rate‑Limiting Algorithm Selection & Window‑Type Trade‑offs](0017-rate-limiting-algorithm-selection-and-window-type-trade-offs.md)

## Context

In shared‑platform deployments, tenant overrides of Redis settings can break pooling and connectivity. Linting rules are needed to enforce platform defaults.

## Decision

- Inject Redis configuration defaults via Helm/CI (host, port, pool args).
- Enforce immutability of these fields with Deck file linting rules (error on any override).
- Centralize all plugin configs in a platform‑owned repo.

## Consequences

### Positive Outcomes

- Consistent, platform‑wide Redis connectivity.
- Prevents runaway resource usage by individual tenants.

### Risks

- Tenants lose flexibility for edge cases.
- Linting rules need maintenance alongside Kubernetes schema changes.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0018-redis-multi-tenant-govenance-and-configuration-enforcement.md)
- [Workspaces in Kong](https://docs.konghq.com/gateway/latest/kong-enterprise/workspaces/)
- [Teams and Admins in Kong](https://docs.konghq.com/gateway/latest/kong-enterprise/teams-admins/)
