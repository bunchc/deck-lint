# 152. Support Self-Hosted LLMs and Override Capabilities via upstream_url

Date: 2025-04-25

## Tags

kong, ai, llm, plugin, self-hosted, upstream-url, flexibility, deployment, integration

## Status

Accepted

## Context

Organizations may deploy self-hosted LLMs (e.g., Llama2, Mistral) or require traffic redirection to private endpoints for testing. Hardcoding provider URLs in plugin code prevents flexibility.

## Decision

Utilize the AI Proxy plugin’s `config.model.options.upstream_url` parameter:

- Default to the provider’s managed URL (e.g., `https://api.openai.com`).
- Allow customers to override `upstream_url` to point to self-hosted or private LLM gateways.
- Ensure that `route_type` mappings continue to apply without code changes.

## Consequences

### Positive

- Flexibility to integrate private or on-prem LLM instances.
- Streamlined testing and blue/green deployments of new model endpoints.

### Risks

- Customers must secure and maintain overridden endpoints.
- Overrides may bypass provider-specific authentication flows unless reconfigured.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0152-support-self-hosted-llms-and-override-capabilities-via-upstream-url.md)

- [AI Proxy Self-Hosted Models](https://docs.konghq.com/hub/kong-inc/ai-proxy/#how-it-works)
- [AI Proxy Configuration Reference](https://docs.konghq.com/hub/kong-inc/ai-proxy/configuration/)
