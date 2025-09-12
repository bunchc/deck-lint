# 98. Size Kong Deployment Based on Traffic and Platform Requirements

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, deployment, kubernetes, sizing, performance, autoscaling, ha, postgres, load-balancer, benchmarking, resource-management

## Status

Accepted

Required by [130. Apply Resource Limits and Requests to Kong Control and Data Planes](0130-apply-resource-limits-and-requests-to-kong-control-and-data-planes.md)

Required by [133. Require Pre-Production Performance Testing for Kong Gateway and APIs](0133-require-pre-production-performance-testing-for-kong-gateway-and-apis.md)

Required by [140. Define and Implement Disaster Recovery (DR) Planning for Kong Gateway](0140-define-and-implement-disaster-recovery-planning-for-kong-gateway.md)

Relates to [19. Non‑Functional Requirements & Redis Sizing](0019-non-functional-requirements-redis-sizing.md)

## Context

A Kong Gateway deployment’s reliability, scalability, and performance heavily depend on how the infrastructure is sized. Underprovisioning can lead to traffic drops and latency, while overprovisioning may waste resources. Ensuring the Control Plane (CP), Data Plane (DP), and backing Postgres DB are correctly dimensioned is essential before go-live.

This decision aims to provide a production-ready sizing baseline that accounts for load characteristics, high availability, and scale-out patterns.

## Decision

When planning a Kong Gateway deployment, consider the following sizing practices:

### Control Plane (CP)

- Minimum: 2 replicas for HA
- CPU: ≥ 2 vCPU per pod
- Memory: ≥ 2 GiB per pod
- Autoscaling enabled if configuration churn is high (frequent updates)

### Data Plane (DP)

- Scale based on request throughput and latency sensitivity
- CPU: ≥ 4 vCPU per pod (recommended for production)
- Memory: ≥ 4 GiB per pod
- Enable Horizontal Pod Autoscaling (HPA) based on `kong_http_requests_total` or CPU/memory

### Postgres DB

- HA setup: Use primary + read-replicas for read-heavy use
- IOPS & connection pool sizing based on number of entities and write frequency
- Use managed PostgreSQL service when possible (e.g., AWS RDS, Azure Database for PostgreSQL)

### Load Balancer

- Use Layer 7 ingress or external LB for exposing services securely
- Enable proxy protocol if forwarding client IPs

### Benchmark Targets

- For Kong OSS/Enterprise: Expect ~1.5K–3K RPS per DP with standard plugins, depending on CPU
- Adjust for heavy plugins (e.g., JWT signing, external auth, ML inferencing)

## Consequences

### Positive Outcomes

- High availability and performance under load
- Predictable behavior during bursts or autoscaling events
- Cost-efficient use of compute resources

### Risks and Trade-offs

- Requires performance testing with actual plugin/config footprint
- Static sizing can degrade if traffic patterns shift significantly
- Resource caps must be carefully tuned in Kubernetes environments

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0098-size-kong-deployment-based-on-traffic-and-platform-requirements.md)
