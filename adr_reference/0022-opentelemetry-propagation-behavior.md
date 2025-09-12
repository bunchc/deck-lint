# 22. OpenTelemetry Trace Propagation Behavior

Date: 2025-04-22

## Tags

opentelemetry, tracing, propagation, observability

## Status

Accepted

Used by [20. Datadog Integration Strategy for Kong](0020-datadog-integration-strategy.md)

Used by [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

Basis for [64. Integrate Kong Gateway with OpenTelemetry Collector for Unified Telemetry Data Export](0064-integrate-kong-gateway-with-opentelemetry-collector-for-unified-telemetry-data-export.md)

Implemented by [65. Configure Kong Gateway OpenTelemetry Plugin for Distributed Tracing, Logging, and Metrics](0065-configure-kong-gateway-opentelemetry-plugin-for-distributed-tracing.md)

## Context

In a Kubernetes deployment, traces are inconsistently reaching Datadog. Upstream components (Cloudflare, F5, Istio) sometimes inject `x-b3-sampled: 0`, causing Kong’s OpenTelemetry plugin to drop spans per the B3 sampling header.

## Decision

Configure Kong’s OpenTelemetry plugin to **ignore upstream sampling headers** and always initiate or continue tracing:

```yaml
propagation:
  clear: null
  default_format: w3c
  extract: []
  inject:
    - w3c
```

### Alternatives Considered

- Respect upstream headers (default): leads to lost spans when `x-b3-sampled: 0` arrives.
- Strip only B3 headers but keep W3C: partial fix, but mixed header sets still confusing.

## Consequences

### Positive

- Kong always generates and exports its own spans, improving trace completeness.
- Upstream misconfigurations no longer mute Kong’s tracing.

### Negative

- May duplicate traces if upstream also traces with W3C.
- Breaks true end‑to‑end sampling decisions from upstream systems.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0022-opentelemetry-propagation-behavior.md)
- [OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Plugin Development Guide](https://docs.konghq.com/gateway/latest/plugin-development/)
