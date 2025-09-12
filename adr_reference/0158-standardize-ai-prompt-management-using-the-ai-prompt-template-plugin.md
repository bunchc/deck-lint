# 158. Standardize AI Prompt Management Using the AI Prompt Template Plugin

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, prompt-template, prompt-management, governance, standardization, versioning

## Status

Accepted

## Context

Consumers of large language models (LLMs) often need to craft, tune, and maintain complex prompt strings. Allowing arbitrary prompts at runtime leads to inconsistent user experiences, version drift, and makes auditing or enforcing corporate standards difficult. Treating an LLM as just another API without prompt governance risks unstructured usage and permissions creep.

## Decision

Adopt the **AI Prompt Template** plugin to centralize, version, and enforce prompt templates:

- Configure **AI Proxy** as the underlying transport layer.
- Define named prompt templates in Kong’s configuration, using `{{variable}}` placeholders for dynamic content.
- Invoke templates via `{template://TEMPLATE_NAME}` references in request payloads (on `prompt` or `messages` fields).
- Expose each template as its own managed API, e.g. a “code-example” endpoint that always applies the same prompt scaffold.

## Consequences

### Positive

- Centralized management of prompt text ensures consistency across teams.
- Templates can be versioned, audited, and rolled back without code changes.
- Non-technical users can invoke complex prompts via simple API calls.

### Risks

- Operators must maintain and secure the template definitions.
- Over-templating can lead to proliferation of almost-duplicate prompts if not governed.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0158-standardize-ai-prompt-management-using-the-ai-prompt-template-plugin.md)

- [AI Prompt Template plugin](https://docs.konghq.com/hub/kong-inc/ai-prompt-template/)
