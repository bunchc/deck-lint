# 14. Counter Namespacing & Synchronization Strategy

Date: 2025-04-22

## Tags

redis, counter, namespacing, synchronization, rate-limiting

## Status

Accepted

Details implementation of [13. Redis Deployment Mode & Topology](0013-redis-deployment-mode-and-topology.md)

## Context

Rate‑limit plugins create background sync jobs per unique namespace (consumer, group, service, etc.). Namespacing and job behavior significantly impact Redis and DP CPU load.

## Decision

- **Namespace per service** for Service Protection; **per consumer‑group** for RLA.
- **Share namespaces** across plugin instances when possible to minimize sync jobs.
- Background sync jobs run indefinitely until DP restart; ensure DP restarts are coordinated to avoid gaps.

## Consequences

### Positive Outcomes

- Reduced number of background jobs and Redis connections.
- Lower DP CPU utilization and more predictable load.

### Risks

- Over‑sharing namespaces could couple unrelated services’ quotas.
- DP restarts temporarily halt sync; requires orchestration to maintain availability.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0014-redis-counter-namespacing-synchronization-strategy.md)
- [Rate Limiting Advanced Plugin Configuration](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/configuration/)
