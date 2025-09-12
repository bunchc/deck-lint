# 66. Define and Monitor Service-Level Objectives (SLOs) for APIs via Kong Gateway and OpenTelemetry

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, monitoring, slo, service level objectives, reliability, latency, availability, error rate, prometheus, alerting

## Status

Proposed

## Context

APIs managed via Kong Gateway must meet reliability, latency, and availability expectations defined by business and consumer needs.  
Without explicit SLOs and ongoing observability:

- Degradation may go undetected until customers complain.
- Root Cause Analysis (RCA) for incidents becomes slower.
- SLA (Service Level Agreement) compliance risks increase.

Kong Gateway, combined with OpenTelemetry instrumentation and Prometheus metrics, enables tracking API reliability in a standardized, scalable way.

## Decision

Establish explicit Service-Level Objectives (SLOs) for critical APIs, implement monitoring using OpenTelemetry and Prometheus, and build automated alerting around SLO compliance.

### Implementation Guidelines

#### 1. Define Core Service-Level Indicators (SLIs)

Each API should define:

- **Availability**: Percentage of successful (2xx/3xx) responses.
- **Latency**: P95 or P99 request completion within a threshold (e.g., 300ms).
- **Error Rate**: Acceptable threshold of 5xx or timeout responses.

Examples:

- 99.9% of requests succeed monthly.
- 95% of API calls complete under 250ms.
- 0.1% max 5xx error rate.

#### 2. Instrument APIs via Kong Observability Plugins

Enable:

- **Prometheus Plugin** for native metrics collection.
- **OpenTelemetry Plugin** for distributed tracing of requests across Kong and backend services.

Capture:

- `kong_http_requests_total`
- `kong_http_request_duration_seconds`
- Distributed span attributes (e.g., service name, route, status code)

#### 3. Monitor and Visualize Metrics

Use dashboards to monitor:

- Per-service and per-route error rates
- Regional/cluster latency distributions
- SLO compliance trends over rolling periods

Example tools:

- Grafana dashboards
- Datadog monitors
- Cloud-native observability platforms (e.g., GCP Monitoring)

#### 4. Define Burn Rate Alerts

Configure alerts based on how quickly the API "burns" its error budget:

- Fast burn: 10% of budget used in 1 hour → critical alert
- Slow burn: 20% of budget used in 6 hours → warning

Alert engineering teams early, based on agreed thresholds.

#### 5. Communicate and Review SLOs Periodically

- Review SLO targets quarterly.
- Adjust based on traffic growth, consumer expectations, and operational capabilities.
- Include SLOs in API documentation and onboarding guidelines.

## Consequences

### Positive Outcomes

- Quantifiable understanding of API reliability and performance.
- Proactive incident response based on SLO burn rates.
- Faster MTTR (Mean Time to Recovery) and better SLA compliance.
- Increased transparency with internal and external API consumers.

### Risks and Trade-offs

- Slight overhead for metrics/tracing plugins (~1–2ms extra latency).
- Complexity in fine-tuning alerting to avoid noise.
- Requires ongoing collaboration across platform, SRE, and product teams.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0066-implement-slo-monitoring-for-apis-using-kong-gateway.md)

- [Kong Prometheus Plugin Documentation](https://docs.konghq.com/hub/kong-inc/prometheus/)
- [Kong OpenTelemetry Plugin Documentation](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Google SRE Book: Defining SLOs](https://sre.google/sre-book/service-level-objectives/)
