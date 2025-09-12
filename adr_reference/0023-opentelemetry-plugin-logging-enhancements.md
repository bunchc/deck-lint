# 23. OpenTelemetry Plugin Logging Enhancements

Date: 2025-04-22

## Tags

opentelemetry, logging, tracing, observability, troubleshooting

## Status

Accepted

Enhances [20. Datadog Integration Strategy for Kong](0020-datadog-integration-strategy.md)

Used by [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

Implemented by [65. Configure Kong Gateway OpenTelemetry Plugin for Distributed Tracing, Logging, and Metrics](0065-configure-kong-gateway-opentelemetry-plugin-for-distributed-tracing.md)

## Context

Missing exporter logs makes it impossible to tell whether spans are dropped by Kong or by upstream. Clear, actionable logs in the OpenTelemetry plugin would greatly reduce debugging time.

## Decision

Enhance the plugin’s log output to record **every span drop event** with explicit reason codes:

- “Dropped due to upstream sampling header”
- “Dropped by plugin sampling settings”
- “Dropped: internal error”

## Alternatives Considered

- **Increase overall log level** (e.g. DEBUG): floods logs with too much detail unrelated to span drops.
- **Rely on external tracing tools** for diagnostics: adds complexity and tooling dependencies.

## Consequences

### Positive

- Engineers immediately see why spans vanish, cutting troubleshooting from hours to minutes.
- Provides a foundation for automated alerts when unexpected span drops occur.

### Negative

- Slight increase in log volume; may require log‑level filtering in production.
- Plugin code complexity grows slightly to categorize drop reasons.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0023-opentelemetry-plugin-logging-enhancements.md)
- [OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Plugin Development Guide](https://docs.konghq.com/gateway/latest/plugin-development/)
