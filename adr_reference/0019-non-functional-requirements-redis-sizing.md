# 19. Non‑Functional Requirements & Redis Sizing

Date: 2025-04-22

## Tags

redis, sizing, performance, requirements, capacity

## Status

Accepted

Provides sizing guidance for [13. Redis Deployment Mode & Topology](0013-redis-deployment-mode-and-topology.md)

Relates to [98. Size Kong Deployment Based on Traffic and Platform Requirements](0098-size-kong-deployment-based-on-traffic-and-platform-requirements.md)

## Context

Successful rate‑limit deployments require collecting NFRs—TPS, namespace counts, sync rates, instance counts—to size Redis for CPU, memory, and IOPS headroom.

## Decision

- Use NFR form to capture:
  - Required throughput (TPS)
  - Number of namespaces (services, consumer groups)
  - sync_rate distribution
  - Number of DPs and workers
- Base Redis cluster capacity on peak IOPS = (#namespaces × (sync_rate⁻¹) × ops_per_sync).
- Allocate ≥ 25% headroom for spikes and future growth.

## Consequences

### Positive Outcomes

- Right‑sized Redis avoids CPU saturation and eviction storms.
- Predictable performance under high‑TPS scenarios.

### Risks

- Underestimation leads to throttling, errors, or latency spikes.
- Over‑provisioning increases infrastructure cost.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0019-non-functional-requirements-redis-sizing.md)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
- [Sizing Guidelines](https://docs.konghq.com/gateway/latest/production/sizing-guidelines/)
