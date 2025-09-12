# 71. Integrate Kong Gateway and Dynatrace for SLO Monitoring Using OpenTelemetry

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, monitoring, slo, service level objectives, dynatrace, opentelemetry, observability, latency, error rate, alerting

## Status

Accepted

Uses [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

Builds on [68. Automate Observability Workflows Using Dynatrace AI and Integration Capabilities](0068-automate-observability-workflows-using-dynatrace-ai-and-integration-capabilities.md)

## Context

While service level objectives (SLOs) can be implemented generically using Kong and OpenTelemetry, organizations leveraging Dynatrace can benefit from deeper integration. Dynatrace provides built-in support for SLO definition, burn rate calculation, anomaly detection, and alerting.

By integrating Kong Gateway with Dynatrace through the OpenTelemetry Collector, teams gain real-time insights into API behavior and can enforce reliability objectives based on live metrics.

## Decision

Integrate Kong Gateway with Dynatrace to monitor API performance and enforce SLOs, using the following components:

- **Kong Gateway + OpenTelemetry Plugin**:

  - Enable the OpenTelemetry plugin on Kong Gateway to emit latency, request counts, and error metrics.
  - Configure it to use the OTLP exporter format.

- **OpenTelemetry Collector**:

  - Deploy a collector to receive telemetry from Kong Gateway.
  - Use processors to enrich and batch data.
  - Export metrics and traces to Dynatrace via the Dynatrace OTLP or native exporter.

- **Dynatrace Configuration**:
  - Use Service Dashboards to visualize SLO metrics.
  - Define SLO thresholds (e.g., 99.9% of requests must complete in <300ms).
  - Create alerting conditions for SLO burn rates or error budget exhaustion.

## Consequences

### Positive

- Leverages Dynatrace’s AI-powered observability for proactive SLO enforcement.
- Provides end-to-end visibility into API performance starting from the Gateway.
- Reduces time-to-detect and time-to-resolve reliability issues.

### Risks

- Increased complexity in setting up and maintaining the OpenTelemetry pipeline.
- May introduce some latency and operational overhead from telemetry processing.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0071-integrate-kong-gateway-and-dynatrace-for-slo-monitoring-using-opentelemetry.md)

- [Kong OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Gateway Observability Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/)
- [Dynatrace OpenTelemetry Integration Guide](https://docs.dynatrace.com/docs/observe-and-explore/opentelemetry/opentelemetry-overview)
- [Kong Blog: Track Service Level Objectives with Kong and OpenTelemetry](https://konghq.com/blog/engineering/track-service-level-objectives-with-kong-and-opentelemetry)
- [OpenTelemetry Collector Configuration](https://opentelemetry.io/docs/collector/)
