# 162. Implement Provider-Agnostic Prompt-Level Throttling via Request Prompt Provider

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, rate-limiting, prompt-throttling, provider-agnostic, cost-management, enforcement

## Status

Accepted

## Context

Some AI use cases require enforcing limits purely on prompt invocation count — regardless of LLM tokenization — to curb abuse or enforce business rules without tracking per-token cost.

## Decision

Use the **requestPrompt** provider within the AI Rate Limiting Advanced plugin to apply generic prompt-level limits:

- Implement a **custom function** (serverless or external) that inspects each incoming request, computes a fixed “prompt cost” (e.g., `1` unit per call), and returns it.
- Configure the plugin with `provider = requestPrompt` and reference the function endpoint to retrieve per-request costs.
- Define rate limits in terms of **prompt units** per window to cap total allowed invocations, independent of LLM usage.
- Combine with provider-specific limits or global rate limiting for layered protection.

## Consequences

### Positive

- Enables simple, uniform throttling across heterogeneous AI pipelines.
- Decouples cost logic from raw token counting, useful for scenarios like free-tier enforcement.
- Functions as a fallback or supplement to token-aware strategies.

### Risks

- Requires maintaining and securing the external “prompt cost” function.
- Cannot distinguish between lightweight and heavy prompts unless function logic evolves.
- Underlying token-based limits still needed to prevent budget overruns if prompt function misreports.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0162-implement-provider-agnostic-prompt-level-throttling-via-request-prompt-provider.md)

- [AI Rate Limiting Advanced Plugin – Request Prompt Function](https://docs.konghq.com/hub/kong-inc/ai-rate-limiting-advanced/#request-prompt-function)
