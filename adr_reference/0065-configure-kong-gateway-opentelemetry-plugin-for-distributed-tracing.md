# 65. Configure Kong Gateway OpenTelemetry Plugin for Distributed Tracing, Logging, and Metrics

Date: 2025-04-23

## Tags

kong, api, gateway, plugin, observability, tracing, monitoring, telemetry, opentelemetry, metrics, logging, distributed tracing, otel, export, correlation, unified observability

## Status

Updated

Implements [22. OpenTelemetry Trace Propagation Behavior](0022-opentelemetry-propagation-behavior.md)

Implements [23. OpenTelemetry Plugin Logging Enhancements](0023-opentelemetry-plugin-logging-enhancements.md)

Implements [24. Trace Propagation Format Standardization](0024-trace-propagation-format-standardization.md)

Implements [64. Integrate Kong Gateway with OpenTelemetry Collector for Unified Telemetry Data Export](0064-integrate-kong-gateway-with-opentelemetry-collector-for-unified-telemetry-data-export.md)

## Context

Kong Gateway supports OpenTelemetry to provide distributed tracing, but modern observability extends further to include logging and metrics. The OpenTelemetry plugin can be used as a unified telemetry signal emitter, helping teams consolidate observability data and reduce blind spots across microservices architectures.

## Decision

Enable and configure the Kong OpenTelemetry plugin to support all three telemetry signal types:

- **Traces**:
  - Emit trace spans at the start of each API request.
  - Propagate W3C trace context headers downstream.
- **Metrics**:
  - Capture request counts, durations, and error codes.
  - Use the plugin’s metric emission or supplement with the Prometheus plugin.
- **Logs**:
  - Enrich logs with trace IDs (via `traceparent`) to enable correlation.
  - Use Kong’s file-log or http-log plugin, optionally routed through the OpenTelemetry Collector.

Plugin Configuration:

- Use the OTLP exporter to forward data to the OpenTelemetry Collector.
- Tag telemetry data with relevant identifiers (e.g., route, service, consumer).

## Consequences

### Positive

- Enables holistic observability through a single, consistent plugin interface.
- Reduces the complexity of managing separate telemetry systems.
- Correlates logs, traces, and metrics via shared trace context.

### Risks

- Requires careful tuning of telemetry volume and metadata tagging.
- Unified telemetry flow may require cross-team coordination to interpret correctly.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0065-configure-kong-gateway-opentelemetry-plugin-for-distributed-tracing.md)

- [Kong OpenTelemetry Plugin Documentation](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [OpenTelemetry Collector Overview](https://opentelemetry.io/docs/collector/)
- [Kong Observability Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/)
- [Kong Blog: Tracing, Logging, Metrics – Unifying Observability with OpenTelemetry](https://konghq.com/blog/engineering/tracing-logging-metrics-unifying-observability-with-opentelemetry)
