# 20. Datadog Integration Strategy for Kong

Date: 2025-04-22

## Tags

datadog, monitoring, integration, observability, metrics

## Status

Accepted

Uses [22. OpenTelemetry Trace Propagation Behavior](0022-opentelemetry-propagation-behavior.md)

Enhanced by [23. OpenTelemetry Plugin Logging Enhancements](0023-opentelemetry-plugin-logging-enhancements.md)

Standardized by [24. Trace Propagation Format Standardization](0024-trace-propagation-format-standardization.md)

Debugged using [25. Observability Debugging Workflow for Traces](0025-observability-debugging-workflow-for-traces.md)

Implements [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

## Context

There are three approaches for integrating Kong with Datadog:

1. DD Plugin + Agent‑collected Prometheus metrics
2. File‑log Plugin + Agent‑collected logs + Agent‑collected metrics
3. Push logs to Datadog Logs API + Agent‑collected metrics (Prometheus or Datadog agent)

Each option has trade‑offs in terms of detail, performance, and flexibility.

## Decision

Adopt a **hybrid approach** using Kong’s built‑in plugins together with the Datadog Agent:

- **Logging**: use the **File‑log** plugin writing to `stdout` (or a mounted file), then have the Datadog Agent tail those logs and feed them into Datadog.
- **Metrics**: use the **Prometheus** plugin to expose Kong metrics, scraped by the Datadog Agent (or a Prometheus‐compatible scraper) and visualized via the Kong OpenMetrics dashboard in Datadog.
- **Tracing**: use the **OpenTelemetry** plugin plus a `file-log` custom_fields_by_lua block to emit Datadog trace IDs and span IDs alongside each request log, enabling “trace → log” navigation in Datadog.

### Example File‑log Plugin Configuration

```yaml
- name: file-log
  enabled: true
  config:
    path: /dev/stdout
    reopen: false
    custom_fields_by_lua:
      dd: |
        local trace_id = kong.request.get_header("x-datadog-trace-id")
        local span_id  = kong.request.get_header("x-datadog-sampling-priority")
        if trace_id and span_id then
          return { trace_id = trace_id, span_id = span_id }
        end
        return nil
```

### Alternatives Considered

1. DD Plugin + Agent Metrics
   - Pros: UDP‑based, low‑overhead metrics.
   - Cons: Limited per‑request log detail and fewer dashboard customization options.
2. File‑log + Datadog HTTP API
   - Pros: Full control over log payloads.
   - Cons: Additional development to format and push logs; bypasses Agent’s built‑in log parsing.
3. Prometheus Agent + Direct Log Push
   - Pros: Fine‑grained metric scraping; custom log formatting.
   - Cons: Complexity in maintaining two separate pipelines.

## Consequences

### Positive Outcomes

- Rich logs: full request fields (method, headers, body, custom trace/span IDs).
- Robust metrics: via Kong’s Prometheus exporter and out‑of‑the‑box OpenMetrics dashboards.
- Trace‑to‑log correlation: span and trace IDs embedded in logs for seamless navigation.

### Risks & Trade‑offs

- File I/O overhead: slight performance hit compared to direct UDP.
- Custom Lua code: requires maintenance if header names or formats change.
- Agent dependency: relies on Datadog Agent configuration for log scraping and metric collection.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0020-datadog-integration-strategy.md)
- [Datadog Plugin](https://docs.konghq.com/hub/kong-inc/datadog/)
- [Prometheus Plugin](https://docs.konghq.com/hub/kong-inc/prometheus/)
- [File Log Plugin](https://docs.konghq.com/hub/kong-inc/file-log/)
