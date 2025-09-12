# 153. Implement Advanced Load Balancing Strategies for AI Models

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, load-balancing, routing, optimization, performance, cost, latency, multi-model

## Status

Accepted

## Context

LLM backends vary widely in performance, cost, and response characteristics. A naive round-robin approach can lead to sub-optimal utilization, elevated costs, or poor latency. AI workloads particularly benefit from model-aware routing (e.g., cheapest, fastest, or semantically closest).

## Decision

Integrate multiple balancing algorithms in the AI Proxy Advanced plugin:

- **`lowest-usage`**: route to the model with the least cumulative usage (by token count or cost).
- **`lowest-latency`**: probe average response times and prefer the fastest model.
- **`semantic`**: compute vector similarity between the request prompt and model descriptions to surface the most contextually relevant model.
- **`priority-group`**, **`round-robin (weighted)`**, and **`consistent-hashing`** for session-sticky or group prioritization use cases.
- Expose **`config.balancer.*`** options to configure failover criteria, retry count, and individual timeout thresholds.

## Consequences

### Positive

- Dynamically optimize for cost, latency, or domain relevance.
- Provide consumers fine-grained control over SLA and budget trade-offs.
- Facilitates multi-tenant, multi-model strategies (e.g., burst to cheaper providers when load spikes).

### Risks

- Performance overhead for telemetry and semantic scoring.
- Misconfiguration risk: overly aggressive failover can mask provider outages.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0153-implement-advanced-load-balancing-strategies-for-ai-models.md)

- [AI Proxy Advanced “Load balancing”](https://docs.konghq.com/hub/kong-inc/ai-proxy-advanced/#load-balancing)
