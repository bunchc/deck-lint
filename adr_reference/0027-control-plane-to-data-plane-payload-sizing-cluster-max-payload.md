# 27. Control‑Plane to Data‑Plane Payload Sizing (`cluster_max_payload`)

Date: 2025-04-22

## Tags

control-plane, data-plane, payload, sizing, cluster-max-payload

## Status

Accepted

Applies to [2. Recommended Kong Deployment Architectures](0002-recommended-kong-deployment-architectures.md)

## Context

The `cluster_max_payload` setting on Kong Control Plane (CP) governs the maximum size of the configuration bundle sent to each Data Plane (DP). The default is 16 MB, but some customers have needed values approaching 600 MB. In Kong 2.x, DPs loaded the entire bundle into a shared‐dictionary in memory (capped by `mem_cache_size`), so an oversized bundle could fail to load. In Kong 3.x, the bundle is persisted to disk via LMDB—controlled by `lmdb_map_size` — and only “hot” entities reside in RAM (capped by `mem_cache_size`), changing the memory/performance trade‑offs.

## Decision

1. **Measure actual payload sizes** in your environment by enabling CP bundle‐size logging or inspecting LMDB files on DPs.
2. **Set `cluster_max_payload`** to the largest observed bundle size plus a safe margin (e.g. +10 %).
3. **Align DP memory settings**:
   - In **Kong 2.x**: ensure `mem_cache_size` ≥ `cluster_max_payload`.
   - In **Kong 3.x**:
     - Set `lmdb_map_size` ≥ `cluster_max_payload` so LMDB can persist the full bundle to disk.
     - Configure `mem_cache_size` to hold your expected working set of entities; if too small, frequent eviction from the LRU cache will degrade performance.

## Alternatives Considered

- **Leave at default (16 MB):** simple, but fails when real bundle size exceeds default.
- **Unbounded `cluster_max_payload`:** avoids CP errors but can overwhelm DP memory or disk unless DP settings are adjusted in tandem.

## Consequences

### Positive Outcomes

- CP→DP configuration pushes succeed reliably without bundle‐too‐large errors.
- DP memory and disk usage remain predictable, matching observed configuration sizes.
- Performance remains stable by sizing caches appropriately.

### Risks

- **Over‑sizing** `cluster_max_payload` without adjusting DP settings can lead to DP memory exhaustion (2.x) or disk‐backed LMDB bloat (3.x).
- **Under‑sizing** leads to push failures when CP bundle exceeds the limit.
- Requires periodic re‑measurement as entity counts or plugin configurations evolve.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0027-control-plane-to-data-plane-payload-sizing-cluster-max-payload.md)
- [Hybrid Mode Configuration](https://docs.konghq.com/gateway/latest/production/deployment-topologies/hybrid-mode/cp-dp-config/)
- [Performance Tuning](https://docs.konghq.com/gateway/latest/production/performance-tuning/)
