# 68. Automate Observability Workflows Using Dynatrace AI and Integration Capabilities

Date: 2025-04-23

## Tags

kong, api, gateway, plugin, monitoring, observability, automation, dynatrace, ai, integration, incident-management, tracing

## Status

Accepted

Enhances [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

Basis for [71. Integrate Kong Gateway and Dynatrace for SLO Monitoring Using OpenTelemetry](0071-integrate-kong-gateway-and-dynatrace-for-slo-monitoring-using-opentelemetry.md)

## Context

While collecting traces, metrics, and logs is essential, the true power of observability lies in actionable insights and automated responses. Dynatrace offers advanced capabilities such as AI-based root cause analysis, anomaly detection, and integration with ITSM and remediation platforms.

By combining Kong's API Gateway observability data with Dynatrace's automation features, organizations can reduce time-to-detect (MTTD) and time-to-resolve (MTTR) during operational incidents.

## Decision

Integrate Kong Gateway observability with Dynatrace to automate detection and response:

- Use the **OpenTelemetry plugin** to emit trace and metric data from Kong Gateway.
- Export this data to Dynatrace using the **OpenTelemetry Collector** with the Dynatrace exporter.
- Leverage Dynatrace capabilities:
  - **Davis AI** to detect anomalies and determine root causes automatically.
  - **Service dashboards** to monitor API health, performance, and SLO compliance in real-time.
  - **Smart alerting** to notify teams when thresholds or patterns indicate potential failures.
- Integrate Dynatrace with incident management tools (e.g., PagerDuty, ServiceNow) to trigger workflows on alerts.

Optional Enhancements:

- Define custom tags and metadata in traces from Kong (e.g., route ID, region, customer tier) to fine-tune alerting and root cause attribution.
- Use Dynatrace’s remediation workflows (e.g., runbooks or APIs) for self-healing or throttling responses.

## Consequences

### Positive

- Accelerates detection, diagnosis, and resolution of API-related incidents.
- Reduces operational overhead through automated observability.
- Aligns platform reliability with SLOs and business impact.

### Risks

- Requires proper configuration of tagging, alert thresholds, and integrations to avoid noise.
- Over-reliance on AI suggestions may obscure understanding without sufficient context.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0068-automate-observability-workflows-using-dynatrace-ai-and-integration-capabilities.md)

- [Kong OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Observability Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/observability/)
- [Dynatrace OpenTelemetry Integration](https://docs.dynatrace.com/docs/observe-and-explore/opentelemetry/opentelemetry-overview)
- [Dynatrace Davis AI](https://www.dynatrace.com/platform/ai-and-automation/)
- [Kong Blog: Implementing OpenTelemetry Observability with Kong Konnect & Dynatrace](https://konghq.com/blog/engineering/opentelemetry-observability-kong-konnect-dynatrace)
