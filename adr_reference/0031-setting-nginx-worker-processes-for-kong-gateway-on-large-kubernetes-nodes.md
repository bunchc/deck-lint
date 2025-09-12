# 31. Setting `nginx_worker_processes` for Kong Gateway on Large Kubernetes Nodes

Date: 2025-04-22

## Tags

kong, gateway, deployment, kubernetes, nginx, worker-processes, performance, resource-allocation, autoscaling, hpa, cpu, memory, tuning, scaling, optimization, production

## Status

Accepted

Related to [29. CPU Allocation & Worker Configuration for Kong on Kubernetes Nodes](0029-cpu-allocation-and-worker-configuration-for-kong-on-kubernetes-nodes.md)

## Context

When deploying Kong Gateway Data Planes (DPs) on Kubernetes worker nodes with high vCPU counts (e.g., AWS instances with 64 cores), setting `nginx_worker_processes: auto` causes Kong to create one worker per physical CPU core. This leads to an excessive number of workers (e.g., 64), which causes:

- High memory consumption.
- Wasted resources when traffic doesn't demand so many workers.
- Potential contention if worker processes are more numerous than available CPU allocated to the Pod (in Kubernetes, CPUs are _requested_, not necessarily fully dedicated).

Thus, guidance is needed for sizing `nginx_worker_processes` appropriately to balance resource usage, performance, and Horizontal Pod Autoscaler (HPA) scaling.

## Decision

1. **Avoid using `auto` for `nginx_worker_processes` in Kubernetes deployments.**
2. **Start with a low, fixed number of workers**, typically aligned to the CPU requested for the Pod:
   - Example: a Pod with 4 vCPUs request → `nginx_worker_processes: 4`
3. **Ensure Pod CPU Requests and Limits match** the number of workers (e.g., 4 CPUs requested, 4 workers configured).
4. **Enable HPA (Horizontal Pod Autoscaling)**:
   - Scale out based on RPS (requests per second) and CPU usage.
5. **Simulate customer traffic patterns** (configuration update rates, normal vs peak loads) to fine‑tune worker counts and autoscaling thresholds.
6. **Memory Sizing**:
   - Memory should roughly be **2× CPU** in small instances.
   - Tune up memory if large response bodies or large buffer sizes are expected.

## Alternatives Considered

- **Keep `auto`**: easy but problematic with oversized instances.
- **Manually set an arbitrarily high number of workers**: wastes memory and can overload the node under heavy reconfiguration events.

## Consequences

### Positive Outcomes

- Resource utilization (CPU/memory) remains predictable.
- Prevents worker overprovisioning on large nodes.
- Easier to autoscale horizontally based on real traffic rather than vertical scaling inside a Pod.

### Risks & Trade-offs

- Starting with too few workers can bottleneck request handling under peak traffic.
- Slight manual tuning effort needed when sizing initial deployments or when customer traffic patterns shift.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0031-setting-nginx-worker-processes-for-kong-gateway-on-large-kubernetes-nodes.md)
- [Kong Configuration Reference](https://docs.konghq.com/gateway/latest/reference/configuration/)
- [Performance Tuning Guide](https://docs.konghq.com/gateway/latest/production/performance-tuning/)
