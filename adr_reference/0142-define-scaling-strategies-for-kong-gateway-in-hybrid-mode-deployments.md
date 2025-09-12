# 142. Define Scaling Strategies for Kong Gateway in Hybrid Mode Deployments

Date: 2025-04-25

## Tags

kong, gateway, hybrid-mode, scaling, control-plane, data-plane, autoscaling, performance, resilience, kubernetes

## Status

Accepted

## Context

Kong Hybrid Mode separates the Control Plane (CP) and Data Planes (DPs), allowing for scalable, fault-tolerant API gateway architectures. Without clear scaling strategies for CP and DP nodes:

- CP bottlenecks could block configuration propagation
- DP overload could cause API traffic latency, rate limiting, or failures
- Scaling could become reactive rather than proactive, impacting SLAs

A proactive, architecture-aware scaling strategy ensures that Kong Gateway remains performant, resilient, and ready to meet growing traffic demands.

## Decision

Implement explicit scaling strategies for Kong Control Plane and Data Plane nodes based on traffic patterns, configuration complexity, and platform SLOs.

### Implementation Guidelines

#### 1. Control Plane (CP) Scaling Strategy

**Responsibilities:**

- Stores configuration
- Synchronizes config to DPs
- Hosts Admin API and Kong Manager (GUI)

**Scaling Characteristics:**

- Low request volume compared to DPs
- CPU-bound during heavy config churn or sync events
- Requires database (PostgreSQL) scaling separately

**Best Practices:**

- Deploy at least 2 CP nodes across availability zones for HA
- Scale vertically (CPU and memory) if configuration push frequency is high
- Monitor:
  - `kong_config_push_success`
  - Admin API latencies
  - PostgreSQL replication lag or connection saturation
- Offload read-heavy operations (e.g., audit logs) from CP DB to replicas if possible

**Common Pitfalls:**

- Overscaling CP adds unnecessary cost; monitor config churn rate first

#### 2. Data Plane (DP) Scaling Strategy

**Responsibilities:**

- Accepts and processes live API traffic
- Applies plugin policies
- Forwards requests to upstream services

**Scaling Characteristics:**

- Directly proportional to API request volume and plugin complexity
- Sensitive to CPU, memory, and network I/O resource availability
- Must be deployed close to API consumers for low-latency response

**Best Practices:**

- Scale DPs horizontally using Kubernetes HPA, cloud autoscaling groups, or service mesh scaling
- Use CPU utilization, latency, or RPS (requests per second) as HPA targets
- Use per-DP Prometheus metrics (e.g., `kong_http_request_duration_seconds`) to tune scale-out thresholds
- For edge clusters: design for burst capacity (traffic spikes)

**Common Pitfalls:**

- Latency spikes under sudden traffic surges due to slow DP scaling
- Configuration sync delays if DPs have stale control plane connections

#### 3. Tune Configuration Synchronization Settings

In DPs:

```yaml
cluster_control_plane_timeout: 60s
cluster_data_plane_purge_delay: 120s
```

Optimize to balance DP resiliency against config drift risks.

#### 4. Autoscaling Policies and Proactive Capacity Management

- Pre-scale DPs before known traffic events (e.g., Black Friday sales)
- Alert on approaching CPU/memory saturation at 70% thresholds
- Allocate reserved headroom (e.g., +20% buffer) to absorb unexpected bursts

#### 5. Disaster Recovery Considerations

- Maintain cross-region DP fleets if critical APIs must survive regional outages
- Deploy redundant CPs in standby mode in secondary regions if strict RPO/RTO targets exist

## Consequences

### Positive Outcomes

- Scalable, resilient Kong Gateway infrastructure supporting growth
- Predictable API performance under both steady and bursty traffic
- Clear isolation of control vs. data plane scaling concerns
- Supports multi-region and DR goals

### Risks and Trade-offs

- Horizontal DP scaling can add latency during warm-up periods (e.g., cold container starts)
- CP scaling requires additional PostgreSQL scaling or replication strategies
- Over-scaling incurs higher cloud costs; careful metric-based tuning is required

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0142-define-scaling-strategies-for-kong-gateway-in-hybrid-mode-deployments.md)

- [Kong Prometheus Plugin Metrics](https://docs.konghq.com/hub/kong-inc/prometheus/)
