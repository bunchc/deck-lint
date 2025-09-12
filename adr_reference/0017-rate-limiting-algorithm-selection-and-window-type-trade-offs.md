# 17. Rate‑Limiting Algorithm Selection & Window‑Type Trade‑offs

Date: 2025-04-22

## Tags

rate-limiting, algorithm, window-type, performance, consistency

## Status

Accepted

Depends on [13. Redis Deployment Mode & Topology](0013-redis-deployment-mode-and-topology.md)

Governed by [18. Multi‑Tenant Governance & Configuration Enforcement](0018-redis-multi-tenant-govenance-and-configuration-enforcement.md)

Required by [112. Apply Rate Limiting to Sensitive or High-Traffic Endpoints](0112-apply-rate-limiting-to-sensitive-or-high-traffic-endpoints.md)

## Context

The two primary algorithms—Fixed Window and Sliding Window—offer different accuracy vs. performance profiles. Sliding yields smoother enforcement with under‑allowance at real‑time sync; Fixed offers throughput at the cost of burstiness.

## Decision

- Default to **Sliding Window** for strict enforcement with sync_rate ≥1 s.
- Offer **Fixed Window** as an option where throughput and predictability trump occasional bursts.
- Support `disable_penalty` flag to exclude 429s from counting when needed.

## Consequences

### Positive Outcomes

- Sliding Window: tight control, smooth rejection.
- Fixed Window: simpler, predictable performance.

### Risks

- Sliding at high sync rates may under‑utilize quotas.
- Fixed may introduce traffic bursts at window edges.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0017-rate-limiting-algorithm-selection-and-window-type-trade-offs.md)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
- [Service Protection Plugin](https://docs.konghq.com/hub/kong-inc/service-protection/)
