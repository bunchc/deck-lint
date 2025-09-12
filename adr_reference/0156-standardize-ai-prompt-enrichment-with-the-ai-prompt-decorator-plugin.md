# 156. Standardize AI Prompt Enrichment with the AI Prompt Decorator Plugin

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, prompt-engineering, prompt-decorator, enrichment, standardization, governance, rbac

## Status

Accepted

## Context

When routing client requests to an AI backend (e.g., OpenAI, Anthropic) through Kong Gateway’s AI Proxy plugin, there is a recurring need to prepend or append standardized “system” or “assistant” messages (e.g., instructions, personas, or safety disclaimers) to every prompt. Embedding these static or dynamic messages in every client application leads to duplication, increased maintenance overhead, and inconsistent behavior across services.

## Decision

Adopt Kong’s **AI Prompt Decorator** plugin as the single, centralized mechanism for decorating AI prompts at the edge:

- Enable **ai-prompt-decorator** on each relevant Route or Service directly after the AI Proxy plugin.
- Declare a list of **messages**, each with a **role** (`system`, `user`, or `assistant`) and **content** fragments, to be injected.
- Choose the **position** (`before` or `after`) to control whether messages are prefixed or suffixed to the original user prompt.
- Leverage the plugin’s **tag** field to group or selectively enable decorator configurations (e.g., by workspace, environment, or use-case).

### Security & Governance

- Store sensitive or proprietary instructions in a centralized configuration repository or Vault, not in client code.
- Use Kong RBAC to restrict who can modify decorator configurations.
- Audit changes to decorator state via Kong’s audit-log feature.

### Performance

- Keep decorated messages small and avoid heavy logic in the plugin to maintain low added latency.
- Benchmark end-to-end round-trip times to the AI backend after enabling decoration.

## Consequences

### Positive

- Centralized prompt engineering, eliminating drift and duplication.
- Consistent enforcement of organizational policies (personas, instructions, safety).
- Rapid iteration on messaging strategies without deploying client-side changes.

### Risks

- Misordering of decorators may lead to confusing prompts; requires clear plugin chain ordering.
- Overly verbose decorations can hit token limits or increase costs on AI backends.
- Plugin misconfiguration could inadvertently expose internal instructions to end users.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0156-standardize-ai-prompt-enrichment-with-the-ai-prompt-decorator-plugin.md)

- [Kong AI Prompt Decorator Plugin](https://docs.konghq.com/hub/kong-inc/ai-prompt-decorator/)
