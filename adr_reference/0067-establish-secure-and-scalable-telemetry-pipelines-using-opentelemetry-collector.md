# 67. Establish Secure and Scalable Telemetry Pipelines Using OpenTelemetry Collector

Date: 2025-04-23

## Tags

kong, gateway, plugin, security, deployment, opentelemetry, collector, observability, tracing, metrics, logging, telemetry, pipeline

## Status

Accepted

Implements [64. Integrate Kong Gateway with OpenTelemetry Collector for Unified Telemetry Data Export](0064-integrate-kong-gateway-with-opentelemetry-collector-for-unified-telemetry-data-export.md)

## Context

Collecting telemetry data (traces, metrics, logs) from Kong Gateway and other services is essential for observability. However, directly connecting every service to multiple backend observability tools introduces tight coupling, operational complexity, and security risks.

The OpenTelemetry Collector provides a vendor-neutral, extensible way to receive, process, and export telemetry data. It acts as a pipeline layer between sources (like Kong Gateway) and backends (like Prometheus, Dynatrace, or Datadog).

## Decision

Deploy OpenTelemetry Collector as the central telemetry routing layer:

- Configure Kong Gateway’s **OpenTelemetry plugin** to export traces and metrics to the OpenTelemetry Collector via OTLP (HTTP/gRPC).
- Deploy the Collector close to the Gateway (same cluster or VPC) to reduce latency and simplify security.
- Use Collector processors to:
  - Add resource attributes (e.g., region, cluster, team ownership)
  - Batch and retry failed exports
  - Filter or transform spans or metrics before export
- Use multiple exporters to forward telemetry data to the appropriate backend(s):
  - e.g., Prometheus, Jaeger, Dynatrace, or S3 storage.

Security:

- Secure communications using **mTLS** between Kong and the Collector.
- Use token-based auth or network policies to prevent unauthorized exports or eavesdropping.

Scalability:

- Deploy the Collector as a sidecar, daemonset, or horizontally scaled deployment based on traffic volume.
- Consider auto-scaling rules based on CPU/memory usage or queue size.

## Consequences

### Positive

- Standardized telemetry collection decoupled from backend systems.
- Easier to change or augment observability tools without modifying source services.
- Improves security, reliability, and maintainability of observability infrastructure.

### Risks

- Adds infrastructure that needs to be deployed, scaled, and monitored.
- Misconfiguration of processors/exporters can result in telemetry loss or delivery failure.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0067-establish-secure-and-scalable-telemetry-pipelines-using-opentelemetry-collector.md)

- [Kong OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Observability Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/)
- [OpenTelemetry Collector Architecture](https://opentelemetry.io/docs/collector/)
- [OpenTelemetry Collector Configuration Examples](https://opentelemetry.io/docs/collector/configuration/)
- [Kong Blog: Implementing OpenTelemetry Observability with Kong Konnect & Dynatrace](https://konghq.com/blog/engineering/opentelemetry-observability-kong-konnect-dynatrace)
