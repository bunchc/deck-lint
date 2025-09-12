# 130. Apply Resource Limits and Requests to Kong Control and Data Planes

Date: 2025-04-25

## Tags

kong, gateway, deployment, kubernetes, resource-limits, autoscaling, performance, monitoring, sizing

## Status

Accepted

Depends on [98. Size Kong Deployment Based on Traffic and Platform Requirements](0098-size-kong-deployment-based-on-traffic-and-platform-requirements.md)

Governed by [48. Optimise Timeouts and Retries for Resilient API Traffic](0048-optimise-timeouts-and-retries-for-resilient-api-traffic.md)

## Context

Kong Gateway components—including the Control Plane (CP) and Data Planes (DP)—are typically deployed in containerized environments such as Kubernetes. Without explicit resource requests and limits, containers may:

- Starve each other for CPU or memory
- Experience throttling or OOM (Out of Memory) kills
- Create noisy neighbor conditions impacting cluster stability

Applying properly sized CPU and memory limits ensures consistent performance, protects critical components, and allows Kubernetes (or the underlying orchestrator) to make better scheduling and autoscaling decisions.

## Decision

Define and enforce resource requests and limits for all Kong CP and DP pods based on load testing and sizing guidelines appropriate for production readiness.

### Implementation Guidelines

#### 1. Set Resource Requests

Resource requests guarantee that Kong pods are scheduled onto nodes with sufficient CPU/memory.

Example for Control Plane (CP):

```yaml
resources:
  requests:
    cpu: "500m"
    memory: "1Gi"
```

Example for Data Plane (DP):

```yaml
resources:
  requests:
    cpu: "1000m"
    memory: "2Gi"
```

#### 2. Set Resource Limits

Resource limits cap how much a Kong pod can consume before being throttled or terminated.

Example:

```yaml
resources:
  limits:
    cpu: "2000m"
    memory: "4Gi"
```

Ensure limits are higher than requests to allow occasional bursts but prevent runaway consumption.

#### 3. Size Based on Load and Plugins

Consider:

- Traffic volume (requests per second)
- Plugin overhead (e.g., heavy transformations or auth plugins)
- Latency and throughput SLOs
- Rate limiting strategies (local vs Redis)

Perform load testing during staging to fine-tune resource sizing.

#### 4. Tune Horizontal Pod Autoscaling (Optional)

Enable HPA based on CPU or custom Prometheus metrics:

```yaml
targetCPUUtilizationPercentage: 70
minReplicas: 2
maxReplicas: 10
```

Use traffic shaping to scale DPs dynamically under load.

#### 5. Monitor and Alert on Resource Usage

Collect and alert on:

- CPU throttling
- Memory pressure
- Restart counts
- Pod eviction events

Use Prometheus + Grafana, Datadog, or cloud-native monitoring tools.

## Consequences

### Positive Outcomes

- Stable, predictable behavior of Kong components under load
- Improved cluster scheduling and autoscaling
- Early detection of capacity risks and bottlenecks

### Risks and Trade-offs

- Overprovisioning wastes cluster resources if sizing is too conservative
- Undersizing causes degraded performance and instability
- Requires periodic tuning as traffic patterns or plugin sets change

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0130-apply-resource-limits-and-requests-to-kong-control-and-data-planes.md)

- [Kong Gateway Kubernetes Deployment Guide](https://docs.konghq.com/gateway/latest/production/deployment-topologies/kubernetes/)
- [Kubernetes Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
