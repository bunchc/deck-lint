# 159. Enforce AI Prompt Input Sanitization to Prevent Injection

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, prompt-template, sanitization, security, injection-prevention, input-validation

## Status

Accepted

## Context

LLM prompting semantics are often represented in JSON payloads. Unescaped control characters (e.g. `\n`, `\"`) can enable malicious users to break out of intended templates and inject arbitrary instructions (prompt injection attacks), causing LLMs to behave unpredictably or leak data.

## Decision

Leverage the built-in sanitization feature of the **AI Prompt Template** plugin to escape JSON control characters on all variable inputs:

- Enable the plugin’s default sanitization logic.
- Reject or safely escape any control characters in `{{variable}}` placeholders.
- Audit logged prompts for evidence of attempted injections.

## Consequences

### Positive

- Prevents arbitrary prompt injection via unescaped JSON.
- Maintains the integrity of template structure.
- Reduces risk of malicious manipulation of LLM instructions.

### Risks

- Over-sanitization could strip benign user content (e.g. code snippets).
- Template authors must test edge-case characters thoroughly.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0159-enforce-ai-prompt-input-sanitization-to-prevent-injection.md)

- [AI Prompt Template plugin — sanitization](https://docs.konghq.com/hub/kong-inc/ai-prompt-template/#how-it-works)
