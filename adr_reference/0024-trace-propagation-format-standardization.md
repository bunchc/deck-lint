# 24. Trace Propagation Format Standardization

Date: 2025-04-22

## Tags

tracing, propagation, standardization, w3c, observability

## Status

Accepted

Standardizes [20. Datadog Integration Strategy for Kong](0020-datadog-integration-strategy.md)

Used by [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

Implemented by [65. Configure Kong Gateway OpenTelemetry Plugin for Distributed Tracing, Logging, and Metrics](0065-configure-kong-gateway-opentelemetry-plugin-for-distributed-tracing.md)

## Context

Mixed use of B3 and W3C headers upstream caused conflicting trace decisions and span drops. Standardizing on a single propagation format prevents these conflicts

## Decision

Mandate **W3C Trace Context** (`traceparent`) as the sole propagation format across all edge, ingress, and gateway components:

- Downstream services and Kong use `default_format: w3c`
- Strip any incoming B3 headers at the edge layer

## Alternatives Considered

- **Continue dual‑support** (B3 + W3C): tolerates variability but keeps complexity.
- **Switch entirely to B3**: legacy compatibility, but W3C is the emerging standard.

## Consequences

### Positive

- Predictable, unified trace context — no more dropped spans due to format mismatch.
- Simplifies configuration of both Kong and upstream components.

### Negative

- Requires coordinated changes across Cloudflare, F5, Istio, and other services.
- Transitional dual‑header period may still see some inconsistencies.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0024-trace-propagation-format-standardization.md)
- [OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Plugin Development Guide](https://docs.konghq.com/gateway/latest/plugin-development/)
