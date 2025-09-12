# 151. Centralize LLM Usage Reporting via Kong Logging Plugins

Date: 2025-04-25

## Tags

kong, ai, llm, logging, observability, usage-reporting, analytics, monitoring, plugin, centralization

## Status

Accepted

## Context

Tracking LLM usage (tokens, requests per model) is critical for cost management and analytics. Implementing separate telemetry for each provider duplicates effort and risks inconsistent metrics.

## Decision

Delegate usage recording to the AI Proxy plugin integrated with Kong’s logging framework:

- Enable the desired log plugin (e.g., **file-log**, **HTTP-log**, **Datadog**, **Prometheus**).
- Configure the AI Proxy to emit structured usage entries (model name, tokens consumed, duration).
- Optionally capture full messages by enabling post-transformation logging.

Log entries flow through the centralized observability pipeline, enabling unified dashboards and alerts.

## Consequences

### Positive

- Single source of truth for LLM usage metrics.
- Seamless integration with existing log aggregation and monitoring tools.

### Risks

- High log volume if full message capture is enabled.
- Must ensure sensitive content is obfuscated or redacted if required by policy.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0151-centralize-llm-usage-reporting-via-kong-logging-plugins.md)

- [AI Proxy Usage Logging](https://docs.konghq.com/hub/kong-inc/ai-proxy/#how-it-works)
- [Kong Logging Plugins](https://docs.konghq.com/hub/#logging)
