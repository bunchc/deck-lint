# 47. Design for Failure in Distributed Systems

Date: 2025-04-22

## Tags

kong, api, gateway, deployment, monitoring, resilience, fault tolerance, distributed systems, circuit breaker, health check, idempotency

## Status

Accepted

Supported by [43. Adopt Blue-Green and Canary Deployment Strategies for APIs](0043-adopt-blue-green-and-canary-deployment-strategies-for-apis.md)

## Context

In distributed systems, failures are inevitable due to network partitions, service crashes, latency spikes, and other unpredictable conditions. Systems must be architected to tolerate and gracefully recover from such failures without impacting the overall platform.

## Decision

Implement resilience patterns across APIs and services:

- **Circuit Breakers**:

  - Use Kong’s circuit breaker and health check features to detect and isolate failing upstream services.
  - Prevent cascading failures by short-circuiting requests to unhealthy services.

- **Health Checks**:

  - Configure **active health checks** on upstream services.
  - Define reasonable thresholds for marking services as healthy or unhealthy to enable automatic rerouting.

- **API-Level Patterns**:
  - **Idempotency**: Ensure that APIs are idempotent, especially for critical operations like financial transactions, to prevent double-processing during retries.
  - **Fallback Mechanisms**: Design APIs to provide sensible default responses when dependencies are unavailable.

## Consequences

### Positive

- Improved system stability under partial failure conditions.
- Better user experience through graceful degradation.
- Prevention of service overload during outages.

### Risks

- Requires operational tuning of thresholds to avoid unnecessary failovers.
- Fallbacks must be thoughtfully designed to avoid masking critical failures.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0047-design-for-failure-in-distributed-systems.md)
- [Health Checks and Circuit Breakers](https://docs.konghq.com/gateway/latest/reference/health-checks-circuit-breakers/)
- [Kong Gateway Monitoring](https://docs.konghq.com/gateway/latest/production/monitoring/)
