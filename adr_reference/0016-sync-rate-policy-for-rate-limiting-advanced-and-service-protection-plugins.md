# 16. Sync‑Rate Policy for Rate‑Limiting Advanced & Service Protection Plugins

Date: 2025-04-22

## Tags

rate-limiting, sync-rate, service-protection, plugins, redis

## Status

Accepted

Depends on [13. Redis Deployment Mode & Topology](0013-redis-deployment-mode-and-topology.md)

Governed by [18. Multi‑Tenant Governance & Configuration Enforcement](0018-redis-multi-tenant-govenance-and-configuration-enforcement.md)

Basis for [53. Implement Rate Limiting and Size Limiting to Mitigate Resource Exhaustion](0053-implement-rate-limiting-and-size-limiting-to-mitigate-resource-exhaustion.md)

## Context

Sub‑second sync rates drastically increase Redis IOPS and DP CPU. Real‑world tests show sync rates <1 s lead to spikes and potential over/under‑enforcement.

## Decision

- Enforce **minimum sync_rate = 1 second** for all RLA and SP plugin configurations.
- Discourage sub‑second rates except in controlled test environments.

## Consequences

### Positive Outcomes

- up to 10× reduction in Redis IOPS and DP CPU load.
- Predictable enforcement behavior without undue resource pressure.

### Risks

- Less real‑time accuracy; acceptable over‑allowance trade‑off.
- Some enforcement spikes at window boundaries.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0016-sync-rate-policy-for-rate-limiting-advanced-and-service-protection-plugins.md)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
- [Service Protection Plugin](https://docs.konghq.com/hub/kong-inc/service-protection/)
