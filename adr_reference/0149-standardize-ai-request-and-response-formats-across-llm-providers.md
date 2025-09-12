# 149. Standardize AI Request and Response Formats Across LLM Providers

Date: 2025-04-28

## Tags

kong, ai, llm, gateway, plugin, standardization, interoperability, api, request-format, response-format, transformation, observability

## Status

Accepted

## Context

Kong’s **AI Proxy Advanced** plugin needs to support a wide variety of backend LLMs (OpenAI, Anthropic, Cohere, Mistral, Llama2/3, Bedrock, Gemini, Hugging Face) each with its own REST API shapes. Without standardization, API consumers must write custom code per provider and models, leading to higher development effort, brittle integrations, and inconsistent telemetry.

## Decision

Adopt a unified, flatten-and-translate approach:

- Define two standard route types—`llm/v1/chat` and `llm/v1/completions`—as canonical request and response envelopes.
- For each configured **`provider`** and **`route_type`**, implement transformation layers:
  - **Input normalization**: convert the consumer’s standardized JSON into provider-specific HTTP path, method, headers, and body shape.
  - **Output normalization**: map the provider’s JSON response back into the canonical OpenAI-style envelope.
- Expose a single Kong route per plugin instance, allowing consumers to switch providers or models by varying plugin configuration only.
- Use the **`llm_format`** option to bypass transformation when proxying natively formatted SDK requests.

### Security

- Validate all incoming JSON against a lightweight schema (e.g., messages array, prompt length) to prevent malformed requests.
- Retain the standardization layer behind Kong’s TLS termination to avoid exposing provider-specific URLs in the public API.

### Observability

- Emit consistent usage and metrics in the standardized envelope (e.g., prompt_tokens, completion_tokens) regardless of the backend.

## Consequences

### Positive

- Single integration point for all LLMs, reducing client complexity.
- Consistent telemetry and billing metrics across providers.
- Simplifies adding new providers by implementing only the translation layer.

### Risks

- Transformation logic may lag behind provider API changes.
- Edge-case provider features (e.g., guardrailConfig in Bedrock) require bespoke extensions.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0149-standardize-ai-request-and-response-formats-across-llm-providers.md)

- [AI Proxy Advanced “Request and response formats”](https://docs.konghq.com/hub/kong-inc/ai-proxy-advanced/#request-and-response-formats)
