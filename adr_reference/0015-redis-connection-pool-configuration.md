# 15. Redis Connection Pool Configuration

Date: 2025-04-22

## Tags

redis, connection-pool, configuration, performance

## Status

Accepted

Configures [13. Redis Deployment Mode & Topology](0013-redis-deployment-mode-and-topology.md)

## Context

Kong creates one keepalive connection pool per unique Redis host:port. Default pool sizes (30 in Kong 2.8; 256 in 3.x) may be sub‑optimal. Pools are lazy‑loaded by the first plugin instance.

## Decision

- Enforce platform‑wide defaults via linting:
  - `keepalive_pool_size = ceil(1.3 × #plugin_instances)`
  - `keepalive_backlog = 2 × #plugin_instances`
- Disallow tenant overrides of pool settings.
- Document values in NFRs.

## Consequences

### Positive Outcomes

- Predictable Redis connection usage.
- Avoid connection storms and resource exhaustion.

### Risks

- Mis‑calculated defaults could under‑ or over‑provision connections.
- Changes require DP restarts to take effect.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0015-redis-connection-pool-configuration.md)
- [Kong Configuration Reference](https://docs.konghq.com/gateway/latest/reference/configuration/#redis-section)
- [Performance Tuning Guide](https://docs.konghq.com/gateway/latest/production/performance-tuning/)
