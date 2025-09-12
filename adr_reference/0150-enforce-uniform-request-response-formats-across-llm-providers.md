# 150. Enforce Uniform Request/Response Formats Across LLM Providers

Date: 2025-04-25

## Tags

kong, ai, llm, plugin, standardization, interoperability, request-format, response-format, transformation, api

## Status

Accepted

## Context

Each LLM provider uses a different JSON schema for chat completions and text completions. Without normalization, API consumers must implement branching logic and multiple parsers, increasing potential for bugs.

## Decision

Standardize on two canonical formats:

- **`llm/v1/chat`** for chat-style interactions:
  ```json
  { "messages": [ { "role": "...", "content": "..." }, … ] }
  ```
- **`llm/v1/completions`** for single-prompt completions:
  ```json
  { "prompt": "..." }
  ```

Configure the AI Proxy’s `config.route_type` to map each request to the appropriate provider endpoint. The plugin will transform inbound messages into provider-specific payloads and convert responses back into the canonical schema with `choices`, `usage`, and `message` fields.

## Consequences

### Positive

- Consumer SDKs and clients rely on a single schema.
- Simplifies request validation and error handling.

### Risks

- Schema drift if providers add features not supported by the canonical formats.
- Extra transformation layer may add minimal latency.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0150-enforce-uniform-request-response-formats-across-llm-providers.md)

- [AI Proxy Request and Response Formats](https://docs.konghq.com/hub/kong-inc/ai-proxy/#request-and-response-formats)
