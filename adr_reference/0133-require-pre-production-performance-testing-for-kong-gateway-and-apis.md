# 133. Require Pre-Production Performance Testing for Kong Gateway and APIs

Date: 2025-04-25

## Tags

kong, gateway, performance-testing, load-testing, benchmarking, deployment, reliability, scalability, monitoring, ci-cd, sla

## Status

Accepted

Depends on [98. Size Kong Deployment Based on Traffic and Platform Requirements](0098-size-kong-deployment-based-on-traffic-and-platform-requirements.md)

## Context

API gateways like Kong play a critical role in API request routing, authentication, traffic control, and observability. Changes to gateway configurations, plugin usage, traffic patterns, or infrastructure sizing can have significant impact on:

- Latency and throughput
- CPU and memory consumption
- Error rates and reliability under load

Without systematic pre-production performance testing, scaling risks, hidden bottlenecks, or plugin inefficiencies may go undetected until they affect production environments.

## Decision

Implement mandatory performance testing of Kong Gateway configurations and APIs before every major deployment, upgrade, or traffic onboarding event.

### Implementation Guidelines

#### 1. Define Performance Goals and SLOs

Set clear targets for:

- Maximum acceptable request latency (P95, P99)
- Maximum sustainable throughput (requests per second)
- Error rate thresholds (<0.1% 5xx errors under load)
- Resource utilization ceilings (e.g., <80% CPU)

Align goals with user expectations and business-critical SLAs.

#### 2. Create Load Test Suites

Use tools such as:

- k6
- Locust
- Vegeta
- JMeter

Design realistic load profiles including:

- Mixed request types (e.g., auth-heavy vs. static routes)
- Concurrent users
- Burst and sustained load
- Complex plugin chains (auth + transform + rate limit)

#### 3. Test Core Gateway Components

Measure:

- Latency introduced by authentication, transformation, or security plugins
- Performance of upstream health checks and retries
- Admin API responsiveness under configuration loads

Simulate control plane config churn if applicable (for Konnect or hybrid mode).

#### 4. Test Failure Scenarios

Include:

- Upstream service failures
- Network partition simulations
- Plugin misbehavior or timeout propagation
- Rate-limiting under overload

Validate Kong's behavior in handling partial outages and retries.

#### 5. Integrate Performance Tests into CI/CD

- Run lightweight smoke tests on PRs
- Execute full load test suites before staging-to-production promotions
- Automatically fail deployments if performance regressions are detected

#### 6. Monitor Key Metrics During Testing

Use Prometheus, Datadog, or built-in Kong metrics to capture:

- `kong_http_requests_total`
- `kong_http_request_duration_seconds`
- `kong_memory_workers_lua_vms`
- `kong_http_status_5xx_total`

Visualize results via Grafana or equivalent dashboards.

## Consequences

### Positive Outcomes

- Identifies scaling risks and bottlenecks before they impact users
- Improves platform resilience and readiness for traffic growth
- Supports SLO/SLA compliance and capacity planning
- Builds organizational confidence in Kong as critical infrastructure

### Risks and Trade-offs

- Performance testing environments must be realistic to be meaningful
- Requires dedicated infrastructure and tooling setup
- Results can be noisy if tests are not controlled and reproducible

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0133-require-pre-production-performance-testing-for-kong-gateway-and-apis.md)

- [Kong Performance Testing Benchmarks](https://docs.konghq.com/gateway/latest/production/performance/performance-testing/#main)
