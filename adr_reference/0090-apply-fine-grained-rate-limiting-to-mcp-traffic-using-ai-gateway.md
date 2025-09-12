# 90. Apply Fine-Grained Rate Limiting to MCP Traffic Using AI Gateway

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, ai, llm, mcp, rate-limiting

## Status

Accepted

## Context

MCP (Model Context Protocol) servers expose powerful LLM-backed APIs that often incur variable cost depending on usage. Without proper controls, client applications or agents may unintentionally or maliciously overconsume these endpoints, leading to service disruption or increased operational costs.

Rate limiting provides a mechanism to enforce usage quotas and protect upstream LLM services from overload or abuse. When working with the Kong AI Gateway, standard and AI-specific rate limiting strategies can be applied to balance reliability, cost, and fairness across different types of clients (e.g., agents, users, tools).

## Decision

Enforce per-consumer or per-usage rate limits for MCP endpoints using the following plugins:

- **AI Rate Limiting Advanced plugin**: Use this when integrating with token-based LLMs (e.g., OpenAI, Anthropic, etc.) to apply limits based on token consumption rather than just request volume.
- **Rate Limiting Advanced plugin**: Use this for traditional rate limiting based on the number of requests (per IP, consumer, or API key).

Each plugin should be configured with:

- **Sliding window** or **leaky bucket** algorithm, depending on predictability requirements.
- **Consumer-scoped** limits to enable differentiated service tiers.
- **Redis strategy** for distributed, consistent rate limit tracking across data planes.

## Consequences

### Positive Outcomes

- Prevents accidental overuse or malicious abuse of MCP-backed APIs.
- Supports metering and billing use cases by tying usage to consumers.
- Improves platform stability and fairness under high load.

### Risks and Trade-offs

- Rate limit enforcement requires state tracking (e.g., Redis), adding operational complexity.
- Aggressive limits may cause service degradation for valid users if misconfigured.
- Token-based limits depend on accurate measurement and reporting by the AI Gateway plugins.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0090-apply-fine-grained-rate-limiting-to-mcp-traffic-using-ai-gateway.md)

- [AI Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/ai-rate-limiting-advanced/)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
- Blog: [Securing, Observing, and Governing MCP Servers](https://konghq.com/blog/product-releases/securing-observing-governing-mcp-servers-with-ai-gateway)
