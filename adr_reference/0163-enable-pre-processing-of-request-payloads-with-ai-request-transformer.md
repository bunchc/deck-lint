# 163. Enable Pre-Processing of Request Payloads with AI Request Transformer

Date: 2025-05-01

## Tags

kong, ai, llm, plugin, request-transformer, transformation, pre-processing, centralization, automation

## Status

Accepted

## Context

Modern applications often need to reshape or enrich request payloads before reaching backend services. Embedding transformation logic in each service leads to duplicated code, inconsistent behavior, and increased maintenance overhead. Large Language Models (LLMs) can perform rich, context-aware transformations, but directly calling LLMs from many services increases operational complexity.

## Decision

Centralize request payload transformations in Kong Gateway using the **AI Request Transformer** plugin:

- Configure the `config.llm` block (same schema as AI Proxy) to point at the chosen LLM provider and model.
- Define a `prompt` under `config` that instructs the LLM on how to introspect and transform the incoming request body.
- Position the plugin to run **before** proxying:
  1. Kong sends the original HTTP request body as the `user` message to the LLM.
  2. The LLM’s `assistant` response becomes the new upstream request payload.
- Keep transformation rules in Gateway config to avoid redeploying application code for prompt updates.

### Security

- Enforce authentication and rate limiting on the LLM endpoint.
- Use TLS/mTLS for Kong → LLM communications.
- Redact or encrypt sensitive fields in logs.

### Scalability

- Enable the plugin only on routes requiring AI-driven transformations.
- Monitor LLM call latency and scale Kong data planes or LLM instances accordingly.
- Implement fallback to pass-through behavior if the LLM is unavailable.

## Consequences

### Positive

- Single, centralized location for all request transformation logic.
- Prompt updates without code redeployment.
- Consistent payload handling across all applications.

### Risks

- Added latency for each request due to LLM invocation.
- Service availability now depends on the LLM provider.
- Drift in prompt behavior may lead to unintended transformations.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0163-enable-pre-processing-of-request-payloads-with-ai-request-transformer.md)

- [AI Request Transformer Plugin](https://docs.konghq.com/hub/kong-inc/ai-request-transformer/)
- [AI Response Transformer Plugin](https://docs.konghq.com/hub/kong-inc/ai-response-transformer/)
