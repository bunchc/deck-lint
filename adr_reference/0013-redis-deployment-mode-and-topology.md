# 13. Redis Deployment Mode & Topology

Date: 2025-04-22

## Tags

redis, cache, high-availability, rate-limiting, topology, clustering, scalability, resilience

## Status

Accepted

Detailed by [14. Counter Namespacing & Synchronization Strategy](0014-redis-counter-namespacing-synchronization-strategy.md)

Configured by [15. Redis Connection Pool Configuration](0015-redis-connection-pool-configuration.md)

Sized according to [19. Non‑Functional Requirements & Redis Sizing](0019-non-functional-requirements-redis-sizing.md)

Supports [16. Sync‑Rate Policy for Rate‑Limiting Advanced & Service Protection Plugins](0016-sync-rate-policy-for-rate-limiting-advanced-and-service-protection-plugins.md)

Supports [17. Rate‑Limiting Algorithm Selection & Window‑Type Trade‑offs](0017-rate-limiting-algorithm-selection-and-window-type-trade-offs.md)

## Context

Redis offers two primary deployment modes for Kong’s rate‑limiting plugins:

- **Standalone Redis**: single primary (reads/writes), optional replicas unused by Kong.
- **Clustered Redis**: data sharded across primaries/replicas via Redis Cluster’s hash‑slot protocol, enabling horizontal scaling and resilience.

## Decision

Use **Redis Cluster** (cluster mode enabled) for all production RLA and Service Protection deployments.

- Start with at least 1 primary + 1 replica for high availability.
- For larger scale, deploy 3+ primaries each with a replica to distribute load.

## Consequences

### Positive Outcomes

- Horizontal scaling of rate‑limit counters across multiple nodes.
- Resilience to node failures via replica promotion.
- Native AWS ElastiCache support for cluster mode.

### Risks

- Operational complexity in managing cluster slots and node topology.
- Slightly higher resource usage for cluster metadata and inter‑node communication.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0013-redis-deployment-mode-and-topology.md)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
- [Redis Configuration in Kong](https://docs.konghq.com/gateway/latest/reference/configuration/#datastore-cache-section)
