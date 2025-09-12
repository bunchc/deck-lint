# 161. Employ AI Rate Limiting Advanced Plugin for Cost-Based Throttling

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, rate-limiting, cost-based, throttling, token-limits, multi-provider, enforcement

## Status

Accepted

## Context

Traditional rate-limiting approaches (fixed request counts per window) do not account for the variable cost of AI calls, where some requests may consume far more LLM tokens — and incur greater expense — than others. Without cost-aware throttling, applications can unexpectedly exhaust budgets or overload downstream LLM services.

## Decision

Adopt Kong’s **AI Rate Limiting Advanced** plugin to enforce token-aware and cost-based limits:

- Configure one or more rate limits keyed by **provider** (e.g., `azure`, `openai`, `cohere`) and **time window** (in seconds or minutes).
- Choose a **token count strategy**:
  - `total_tokens` for combined prompt + completion usage.
  - `prompt_tokens` for user-provided context only.
  - `completion_tokens` for generated output only.
  - `cost` for weighted financial cost:
    ```
    cost = prompt_tokens * input_cost + completion_tokens * output_cost
    ```
- Supply `input_cost` and `output_cost` per provider to calculate real-time request costs.
- Use the **cluster** strategy with PostgreSQL 9.5+ as the backing datastore for distributed, multi-node enforcement.
- Opt for **sliding** or **fixed** windows to balance strictness and burst capacity.
- Map rate limits per **consumer**, **service**, **route**, or **global**, depending on the deployment.
- Optionally **hide_client_headers** to prevent exposing internal quota metrics externally.

## Consequences

### Positive

- Throttles based on actual resource consumption, aligning with cost budgets.
- Supports multi-provider deployments with separate limits per LLM.
- Leverages Kong’s scalable, cluster-wide enforcement for large API fleets.

### Risks

- Configuration complexity increases with multiple providers and cost parameters.
- Token costs are only reflected on the **next** request due to measurement timing.
- Disabled penalty behavior is limited to the `requestPrompt` provider.
- Requires PostgreSQL 9.5+ when using the `cluster` strategy.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0161-employ-ai-rate-limiting-advanced-plugin-for-cost-based-throttling.md)

- [AI Rate Limiting Advanced Plugin Overview](https://docs.konghq.com/hub/kong-inc/ai-rate-limiting-advanced/)
- [Rate Limit Header Fields for HTTP Internet-Draft](https://datatracker.ietf.org/doc/html/draft-polli-ratelimit-headers-03)
- [Kong Rate Limiting Advanced](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
