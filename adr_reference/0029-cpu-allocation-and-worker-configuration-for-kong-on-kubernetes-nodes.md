# 29. CPU Allocation & Worker Configuration for Kong on Kubernetes Nodes

Date: 2025-04-22

## Tags

kong, gateway, kubernetes, monitoring, resource-allocation, cpu, performance-tuning, worker-configuration, scaling

## Status

Accepted

Related to [31. Setting `nginx_worker_processes` for Kong Gateway on Large Kubernetes Nodes](0031-setting-nginx-worker-processes-for-kong-gateway-on-large-kubernetes-nodes.md)

## Context

When running Kong Gateway (and Kong Ingress Controller + Data Plane) on Kubernetes worker nodes, each node has a fixed CPU capacity (e.g. 16 vCPU). Kubernetes system daemons (kubelet, kube‑proxy, CNI, etc.) and DaemonSets (logging, monitoring) also require CPU. By default, Kong recommends setting its `worker_processes` equal to the number of CPUs allocated to it—but we must first carve out CPU for system components to avoid contention and unstable performance.

## Decision

1. **Measure & reserve system CPU**
   - On each node, inspect CPU requests/usage of system DaemonSets and core Kubernetes components. Call this `systemCPU`.
2. **Compute Kong CPU budget**
   - Let `nodeCPU` = total vCPU on the node (e.g. 16).
   - Set `kongCPU = nodeCPU − systemCPU`.
3. **Configure Kubernetes CPU requests (no limits)**
   - For each Kong Gateway (or KIC+DP) Pod, request `kongCPU` CPU. Do _not_ set a CPU limit—requests drive Pod placement only.
4. **Set Kong `worker_processes`**
   - In the Kong configuration, set `worker_processes = kongCPU`.
5. **Multi‑pod considerations**
   - If running multiple Kong pods per node (e.g. two KIC+DP instances), split the `kongCPU` equally (e.g. if `kongCPU = 14` and two Pods, each requests 7 CPU and `worker_processes = 7`).

## Alternatives Considered

- **Hard‑coding `n−2` or `n−1`** for `worker_processes`: simpler but inflexible if systemCPU varies by node or over time.
- **Setting CPU limits**: Kubernetes limits add throttling overhead and aren’t needed for placement in typical Kong use‑cases.

## Consequences

### Positive Outcomes

- **Predictable performance**: Kong workers have dedicated CPU without system contention.
- **Correct Pod scheduling**: CPU requests accurately reflect resource needs, avoiding overcommit.
- **Scalability**: Multi‑pod splits allow handling multiple ingress classes (KIC + DP) per node.

### Risks & Trade‑offs

- **Measurement effort**: Requires initial and periodic measurement of `systemCPU` per node type.
- **Under‑allocation**: Over‑reserving for system pods reduces Kong capacity.
- **Over‑allocation**: Under‑reserving for system pods may cause CPU contention and instability.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0029-cpu-allocation-and-worker-configuration-for-kong-on-kubernetes-nodes.md)
- [Kong Configuration Reference](https://docs.konghq.com/gateway/latest/reference/configuration/)
- [Performance Tuning Guide](https://docs.konghq.com/gateway/latest/production/performance-tuning/)
