# 63. Implement OpenTelemetry-Based Observability at the API Gateway Layer

Date: 2025-04-23

## Tags

kong, api, gateway, plugin, opentelemetry, observability, tracing, metrics, logging, telemetry, monitoring

## Status

Updated

## Context

Modern distributed systems require observability across three pillars: tracing, logging, and metrics. Kong Gateway, as the central entry point to APIs and microservices, provides a strategic location for instrumenting and emitting telemetry data. With OpenTelemetry emerging as the industry standard for unified observability, it is essential to adopt it holistically — not only for traces, but also for structured logs and metrics.

## Decision

Adopt OpenTelemetry at the API Gateway layer to emit and propagate all three observability signals:

- **Tracing**: Use Kong’s OpenTelemetry plugin to initiate and propagate distributed trace spans.
- **Logging**: Where applicable, enrich and structure gateway logs to correlate with trace IDs using `traceparent` headers.
- **Metrics**: Emit latency, request counts, error rates, and other relevant performance indicators through OpenTelemetry or Prometheus-compatible plugins.

Best Practices:

- Enable trace context propagation using the W3C standard.
- Configure sampling, metadata tagging, and span enrichment at the plugin or collector level.
- Route all signals (logs, metrics, traces) to a unified OpenTelemetry Collector.

## Consequences

### Positive

- Provides comprehensive observability across all three telemetry pillars at the gateway.
- Simplifies correlation between metrics, traces, and logs for faster diagnosis.
- Aligns with open standards and supports integration with multiple backends.

### Risks

- Configuration complexity increases when managing multiple signals.
- Requires alignment of formats and context propagation across tools and services.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0063-implement-opentelemetry-based-observability-at-the-api-gateway-layer.md)

- [Kong OpenTelemetry Plugin Documentation](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Observability Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/)
- [OpenTelemetry Overview (Traces, Metrics, Logs)](https://opentelemetry.io/docs/)
- [Kong Blog: Tracing, Logging, Metrics – Unifying Observability with OpenTelemetry](https://konghq.com/blog/engineering/tracing-logging-metrics-unifying-observability-with-opentelemetry)
- [Kong Blog: Implementing OpenTelemetry Observability with Kong Konnect & Dynatrace](https://konghq.com/blog/engineering/opentelemetry-observability-kong-konnect-dynatrace)
