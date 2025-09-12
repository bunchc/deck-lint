# 102. Enable Global Observability Plugins Across Workspaces

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, monitoring, observability, logging, tracing, prometheus, opentelemetry, correlation-id, workspaces, automation

## Status

Accepted

## Context

In Kong Gateway Enterprise, workspaces allow logical separation of APIs, services, and consumers — typically aligned with teams, business units, or environments. Without consistent observability, each workspace might configure logging, metrics, or tracing differently (or not at all), making cross-workspace monitoring unreliable or incomplete.

To provide centralized and consistent telemetry across all APIs, observability plugins should be configured globally or applied automatically to all workspaces through automation or platform governance.

## Decision

Enable key observability plugins globally to ensure uniform data collection across all traffic in Kong:

### Recommended Global Plugins

- **`prometheus`**: Collects metrics for request count, latency, upstream health.
- **`opentelemetry`**: For distributed tracing across services.
- **`http-log`**, **`file-log`**, or **`tcp-log`**: For centralized request/response logging.
- **`correlation-id`**: Propagates traceable IDs through headers.

### Implementation Options

1. **Apply at the global scope** using `plugins` API or declarative config:

```bash
curl -X POST http://<admin-api>/plugins \
  --data "name=prometheus" \
  --data "config.status_code_metrics=true"
```

2. Template into each workspace automatically using automation (e.g., Terraform, CI/CD).

## Consequences

### Positive Outcomes

- Ensures every workspace is monitored, even if developers forget to configure observability.
- Reduces time-to-detect and time-to-resolve issues.
- Enables centralized dashboards, SLIs, and security audits.

### Risks and Trade-offs

- Potential overhead if not tuned (especially for logging plugins).
- Might conflict with custom per-service overrides unless scoped properly.
- Requires governance to prevent users from disabling or modifying critical plugins.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0102-enable-global-observability-plugins-across-workspaces.md)

- [Prometheus Plugin](https://docs.konghq.com/hub/kong-inc/prometheus/)
- [OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [Kong Workspaces](https://docs.konghq.com/gateway/latest/kong-enterprise/workspaces/)
