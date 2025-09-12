# 179 Adoption of Open Telemetry for Observability in Dedicated Cloud Gateways
## Tags

konnect, dedicated-cloud-gateways, observability, opentelemetry, metrics, logging, tracing

## Status

Proposed

## Context

Dedicated Cloud Gateways are fully managed Kong Gateway data-plane nodes provisioned through Konnect. These gateways remove the operational burden of managing infrastructure and provide automatic scaling, upgrade management, and flexible networking options (public or private). However, one notable constraint is that the Prometheus plugin is **not supported** on Dedicated Cloud Gateways.

As observability remains critical, especially in production environments, Kong recommends using the OpenTelemetry plugin to collect logs, traces, and metrics. This plugin enables customers to export telemetry data to an OpenTelemetry Collector, which they must host and manage. The collector can then forward data to their preferred monitoring and observability backends.

## Decision

Use the **OpenTelemetry plugin** for collecting observability data (logs, traces, metrics) from Dedicated Cloud Gateways. Deploy and manage a customer-hosted OpenTelemetry Collector to receive this data and forward it to the appropriate observability platforms.

## Consequences

### Positive

* **Platform Compliance**: Aligns with Konnect’s supported plugin ecosystem.
* **Unified Telemetry**: Consolidates logs, metrics, and traces into a single protocol (OTel).
* **Backend Agnosticism**: Enables flexible export to systems such as Prometheus, Grafana, Datadog, or others.
* **Zero Gateway Overhead**: Delegates processing and aggregation responsibilities to the collector, preserving gateway performance.

### Risks

* **Operational Overhead**: Requires customers to deploy, scale, and monitor the OpenTelemetry Collector infrastructure.
* **Complexity**: Configuration of exporters and receivers must be maintained per observability backend requirements.
* **Plugin Limitation**: Potential feature gaps compared to Prometheus plugin integrations already established in customer environments.
* **Data Fidelity**: Misconfiguration in OTel pipelines can lead to loss or misinterpretation of observability data.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0169-adoption-of-open-telmetry-for-observability-in-dedicated-cloud-gateways.md)

* [Kong Gateway OpenTelemetry Plugin Documentation](https://developer.konghq.com/plugins/opentelemetry/)
* [Kong Gateway Prometheus Plugin Documentation](https://developer.konghq.com/plugins/prometheus/)
* [Kong Konnect Dedicated Cloud Gateways Overview](https://developer.konghq.com/dedicated-cloud-gateways/)
