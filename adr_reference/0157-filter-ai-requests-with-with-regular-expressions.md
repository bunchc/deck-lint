# 157. Filter AI requests with with Regular Expressions

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, prompt-guard, security, compliance, regex, filtering, validation

## Status

Accepted

## Context

When exposing an LLM endpoint (`llm/v1/chat` or `llm/v1/completions`) through Kong Gateway, unfiltered user inputs can lead to policy violations, unsafe content generation, or misuse of the model. A mechanism is needed to enforce content compliance and block or allow specific constructs in user prompts without modifying upstream services.

## Decision

Adopt the **AI Prompt Guard** plugin to enforce prompt-level allow-list and deny-list policies:

- Configure the plugin with PCRE-compatible regular expressions for both `allow` and `deny` lists.
- On each incoming request:
  - If any `deny` pattern matches, return HTTP 400 and block the request.
  - Else if `allow` patterns exist and none match, return HTTP 400.
  - Else forward the request to the LLM.
- Deny rules take precedence over allow rules when both are defined.
- For chat models (`llm/v1/chat`), optionally scan only the trailing `user` message to reduce false positives.
- For completion models (`llm/v1/completions`), scan the single `prompt` field in its entirety.
- Require the **AI Proxy** plugin to be configured first, so the guard logic can operate on proxied LLM traffic.

### Security

- Prevent disallowed or malicious prompt content before it reaches the LLM.
- Ensure consistent enforcement of compliance policies at the API gateway layer.

### Maintainability

- Keep filtering policies declarative and separate from service logic.
- Update regex patterns centrally in Kong configuration without redeploying backend services.

## Consequences

### Positive

- Centralized, high-performance prompt validation.
- No modifications needed in LLM backends.
- Clear separation of policy enforcement and model execution.

### Risks

- Overly broad or incorrect regex patterns may block legitimate prompts.
- Complex patterns can introduce CPU overhead at high QPS.
- Requires careful testing and tuning of allow/deny lists to avoid false rejections.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0157-filter-ai-requests-with-with-regular-expressions.md)

- [AI Prompt Guard plugin overview](https://docs.konghq.com/hub/kong-inc/ai-prompt-guard/)
