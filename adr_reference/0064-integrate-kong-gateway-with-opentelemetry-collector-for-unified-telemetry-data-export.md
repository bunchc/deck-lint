# 64. Integrate Kong Gateway with OpenTelemetry Collector for Unified Telemetry Data Export

Date: 2025-04-23

## Tags

kong, api, gateway, plugin, deployment, monitoring, opentelemetry, collector, observability, tracing, metrics, logging, telemetry, export

## Status

Accepted

Builds on [22. OpenTelemetry Trace Propagation Behavior](0022-opentelemetry-propagation-behavior.md)

Implemented by [65. Configure Kong Gateway OpenTelemetry Plugin for Distributed Tracing, Logging, and Metrics](0065-configure-kong-gateway-opentelemetry-plugin-for-distributed-tracing.md)

Implemented by [67. Establish Secure and Scalable Telemetry Pipelines Using OpenTelemetry Collector](0067-establish-secure-and-scalable-telemetry-pipelines-using-opentelemetry-collector.md)

## Context

Organizations often use different observability backends (e.g., Dynatrace, Datadog, Prometheus) for logs, metrics, and traces. OpenTelemetry Collector provides a unified, vendor-agnostic way to receive, process, and export telemetry data.

Integrating Kong Gateway with the OpenTelemetry Collector ensures that observability data emitted by the API layer can be enriched, filtered, and routed consistently to any chosen backend.

## Decision

Use the **OpenTelemetry Collector** as an intermediary between Kong Gateway and the observability backend:

- Configure the **OpenTelemetry plugin** on Kong Gateway to export trace data in OTLP format to a collector instance.
- Deploy the OpenTelemetry Collector with exporters for desired backends (e.g., Dynatrace, Jaeger, OTLP HTTP).
- Optionally enrich trace data in the collector using processors (e.g., resource injection, batch processing).
- Ensure secure communication between Kong and the Collector via mTLS or trusted internal networking.

## Consequences

### Positive

- Decouples Kong Gateway from specific observability backends.
- Simplifies the migration or extension of monitoring systems.
- Allows centralized management of telemetry pipelines and configurations.

### Risks

- Adds infrastructure and operational overhead (Collector deployment and scaling).
- Misconfiguration in the Collector can impact trace delivery or performance.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0064-integrate-kong-gateway-with-opentelemetry-collector-for-unified-telemetry-data-export.md)

- [Kong OpenTelemetry Plugin Documentation](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Gateway OpenTelemetry Configuration Guide](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/opentelemetry/)
- [OpenTelemetry Collector Architecture](https://opentelemetry.io/docs/collector/)
- [Dynatrace Exporter for OpenTelemetry](https://docs.dynatrace.com/docs/observe-and-explore/opentelemetry/opentelemetry-overview)
- [Kong Blog: Implementing OpenTelemetry Observability with Kong Konnect & Dynatrace](https://konghq.com/blog/engineering/opentelemetry-observability-kong-konnect-dynatrace)
