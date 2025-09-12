# 92. Enable Observability and Performance Tracing for MCP Workflows

Date: 2025-04-25

## Tags

kong, gateway, plugin, ai, llm, mcp, observability, tracing, monitoring

## Status

Accepted

## Context

AI-native applications that rely on MCP (Model Context Protocol) servers typically operate across multiple services, agents, gateways, and LLMs. Observability is critical to:

- Diagnose prompt or response latency,
- Detect internal failures or retries,
- Correlate input prompts with downstream outcomes,
- Track token usage or quota depletion.

Without end-to-end tracing and logs, diagnosing production issues in such distributed systems becomes extremely difficult.

## Decision

Use Kong AI Gateway to provide full observability for MCP interactions by enabling:

1. **OpenTelemetry Plugin**

   - Captures spans across request lifecycles (e.g., request received, forwarded, transformed, completed).
   - Integrates with tracing backends like Datadog, Dynatrace, Tempo, or Jaeger.
   - Allows correlation of MCP traffic with adjacent system activity (e.g., user auth, token validation).

2. **AI Gateway Logging Plugins**

   - Use **HTTP Log**, **File Log**, or **UDP Log** plugins to record structured prompt inputs and LLM responses.
   - Include custom fields (e.g., tokens used, trace IDs) for deep analytics.
   - Forward logs to observability stacks (Splunk, ELK, etc.).

3. **Correlation ID and Request Transformer**
   - Automatically inject trace headers (e.g., `x-request-id`, `traceparent`) into outbound calls to ensure downstream correlation.

## Consequences

### Positive Outcomes

- Provides full observability for debugging slow or failing AI interactions.
- Enables cost and usage analytics for token-based LLM billing.
- Improves operational visibility across complex AI-native application flows.

### Risks and Trade-offs

- Tracing and logging introduce small overhead in high-throughput scenarios.
- Requires consistent header propagation and log filtering to avoid noise.
- Improper logging of LLM responses could expose sensitive data without sanitization.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0092-enable-observability-and-performance-tracing-for-mcp-workflows.md)

- [OpenTelemetry Plugin](https://docs.konghq.com/hub/kong-inc/opentelemetry/)
- [HTTP Log Plugin](https://docs.konghq.com/hub/kong-inc/http-log/)
- [File Log Plugin](https://docs.konghq.com/hub/kong-inc/file-log/)
- [Correlation ID Plugin](https://docs.konghq.com/hub/kong-inc/correlation-id/)
- Blog: [Securing, Observing, and Governing MCP Servers](https://konghq.com/blog/product-releases/securing-observing-governing-mcp-servers-with-ai-gateway)
