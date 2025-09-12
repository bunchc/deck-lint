# 138. Configure Timeouts and Retries to Prevent Resource Exhaustion in Kong Gateway

Date: 2025-04-25

## Tags

kong, gateway, timeouts, retries, resilience, resource-exhaustion, performance, reliability, best-practices

## Status

Accepted

Implements [48. Optimise Timeouts and Retries for Resilient API Traffic](0048-optimise-timeouts-and-retries-for-resilient-api-traffic.md)

## Context

Kong Gateway proxies requests to upstream services. If upstreams are slow, unstable, or unresponsive, Kong instances can accumulate waiting requests, leading to resource exhaustion, high memory usage, degraded performance, and potentially cascading failures.

To protect the Gateway and ensure system resilience, it is critical to define explicit and reasonable timeouts for connecting to and reading from upstream services, along with cautious retry strategies.

## Decision

Mandate explicit configuration of timeouts and retries for all upstream services managed by Kong Gateway to prevent unbounded waits and to control recovery behavior under failure scenarios.

### Implementation Guidelines

#### 1. Define Upstream Service Timeouts

Set these fields for every service object:

- `connect_timeout`: Time to establish TCP connection to upstream
- `read_timeout`: Time to read response from upstream
- `write_timeout`: Time to send request to upstream

Example:

```bash
curl -X POST http://localhost:8001/services \
  --data "name=payments-api" \
  --data "url=https://payments.internal" \
  --data "connect_timeout=5000" \
  --data "read_timeout=10000" \
  --data "write_timeout=5000"
```

Timeouts are in milliseconds.

Recommended defaults:

- Connect timeout: 2s to 5s
- Read timeout: 5s to 15s
- Write timeout: 2s to 5s

Adjust based on upstream API behavior and SLA requirements.

#### 2. Limit Retry Counts Carefully

Set retries for transient failures (e.g., timeouts, 5xx errors) without overwhelming upstreams:

```bash
curl -X PATCH http://localhost:8001/services/payments-api \
  --data "retries=1"
```

Best practices:

- Maximum 1-2 retries for critical paths
- Avoid high retry counts under heavy load
- Customize retries based on route sensitivity (e.g., login APIs vs. metrics ingestion)

#### 3. Configure Plugin-Specific Timeouts and Retries

Some plugins (e.g., `request-transformer`, `oauth2`, `opentelemetry`) also have their own internal timeouts or retries. Review and align them with global service behavior.

#### 4. Monitor Upstream Latency and Errors

Use Kong’s metrics (`kong_upstream_latency`, `kong_http_status`) to:

- Track slow upstreams
- Detect retry patterns
- Alert on degraded service responsiveness

Feed upstream health metrics into autoscaling or incident workflows.

#### 5. Adjust Timeouts for External Dependencies Separately

If Kong integrates with:

- Identity Providers (e.g., OAuth servers)
- Payment processors
- Third-party APIs

Define stricter timeouts and circuit-breaking behaviors (e.g., via request-termination or rate-limiting plugins) to isolate failures.

## Consequences

### Positive Outcomes

- Prevents request queuing and congestion under upstream latency
- Reduces memory footprint and improves Gateway stability
- Enables faster failure recovery for better client experience
- Supports safer scaling under high concurrency workloads

### Risks and Trade-offs

- Tight timeouts can cause more client-visible errors if upstreams are slow
- Misaligned retries can amplify transient failures
- Requires tuning timeout and retry parameters over time as systems evolve

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0138-configure-timeouts-and-retries-to-prevent-resource-exhaustion-in-kong-gateway.md)

- [Kong Service Object Timeout Fields](https://docs.konghq.com/gateway/latest/admin-api/#service-object)
- [Best Practices for Timeout and Retry Management](https://konghq.com/blog/resilient-api-gateway-design-best-practices)
- [Kong Metrics Documentation](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/metrics/)
- Kong Go-Live Hardening Checklist – Upstream Timeout Management
