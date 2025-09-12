# 143. Implement Centralized Observability for Multi-Cluster Kong Deployments

Date: 2025-04-25

## Tags

kong, gateway, observability, multi-cluster, centralized-logging, metrics, tracing, monitoring, dashboards, alerting

## Status

Accepted

## Context

In large-scale environments, Kong Gateway may be deployed across multiple Kubernetes clusters, cloud regions, or hybrid clouds. Without centralized observability, operators face challenges such as:

- Blind spots when troubleshooting API performance
- Delayed incident detection across distributed Kong fleets
- Difficulty correlating metrics, traces, and logs across clusters
- Compromised SLA/SLO enforcement

Centralizing observability enables real-time visibility, unified dashboards, alerting consistency, and faster root cause analysis across all Kong Gateway instances.

## Decision

Aggregate metrics, logs, and traces from all Kong Gateway deployments into a centralized observability platform.

### Implementation Guidelines

#### 1. Collect and Export Metrics

Use the Kong Prometheus plugin on every Kong Gateway deployment:

```bash
curl -X POST http://localhost:8001/plugins \
  --data "name=prometheus"
```

Each cluster scrapes its local metrics via:

- Cluster-local Prometheus instances
- Prometheus Federation to a central Prometheus
- Direct scrape into a cloud-native metrics platform (e.g., Datadog, AWS Managed Prometheus)

Ensure:

- Consistent labeling (`cluster_name`, `region`, `workspace`) for disambiguation
- Relabeling rules to prevent metric collisions

#### 2. Aggregate and Correlate Logs

Use structured logging plugins:

- `http-log`
- `tcp-log`
- `kafka-log`
- `syslog`

Forward Kong access logs, Admin API logs, and audit logs to a centralized log platform like:

- ELK Stack (ElasticSearch, Logstash, Kibana)
- Splunk
- Datadog Logs
- Fluentd / Fluent Bit pipelines

Tag logs with metadata:

- `cluster=us-west-1`
- `env=prod`
- `kong_workspace=billing`

Ensure log integrity and secure transmission (TLS, IAM roles, etc.).

#### 3. Enable Distributed Tracing

Deploy OpenTelemetry plugin across Kong clusters:

```bash
curl -X POST http://localhost:8001/plugins \
  --data "name=opentelemetry"
  --data "config.endpoint=http://otel-collector.your-namespace.svc:4317"
```

- Collect spans for API entry points and upstream calls.
- Export traces to a centralized backend (e.g., Jaeger, Tempo, Datadog APM, AWS X-Ray).
- Consistently label spans by cluster and region.

#### 4. Build Unified Dashboards

Visualize key indicators across clusters:

- RPS, error rates, p99 latency by region
- DP health status
- CP synchronization status
- Audit log events

Use Grafana, Datadog, New Relic, or custom dashboards.

Example dashboard breakdown:

- Per-cluster health
- Global traffic overview
- API-level SLO compliance

#### 5. Centralize Alerting and Incident Management

Configure alerting rules across clusters:

- Kong HTTP 5xx rate > 1% over 5 minutes
- Upstream health check failures
- Latency thresholds exceeded
- DP connection loss to CP

Route alerts to centralized incident platforms like PagerDuty, Opsgenie, or Slack.

#### 6. Harden and Secure Observability Pipelines

- Encrypt telemetry data in transit
- Apply authentication between agents/collectors and backends
- Protect central observability platforms with RBAC and audit trails

## Consequences

### Positive Outcomes

- End-to-end API request visibility across regions and clusters
- Faster incident detection and RCA (Root Cause Analysis)
- Unified reporting on availability, performance, and compliance
- Improved operational efficiency for global Kong fleets

### Risks and Trade-offs

- Increased telemetry volume and associated storage/ingestion costs
- Requires careful planning to avoid label explosion or metric duplication
- Central observability systems become critical dependencies themselves

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0143-implement-centralized-observability-for-multi-cluster-kong-deployments.md)

- [Kong Prometheus Plugin](https://docs.konghq.com/hub/kong-inc/prometheus/)
- [Kong OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Logging Plugins Overview](https://docs.konghq.com/hub/?category=logging)
