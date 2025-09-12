# 154. Enable Transparent Proxy for Native LLM SDK Integration

Date: 2025-04-28

## Tags

kong, ai, llm, proxy, sdk, passthrough, integration, observability, compatibility

## Status

Accepted

## Context

Many consumers use official SDKs of AI providers expecting minimal changes. Forcing format translation breaks these tools. A transparent “passthrough” mode preserves native API shapes.

## Decision

Introduce **`config.llm_format`**:

- Default: `openai` translation.
- Override: set to provider-specific values (e.g., `gemini`, `bedrock`) to skip transformation.
- In passthrough mode, Kong:
  - Retains exact request body, headers, and URL.
  - Records analytics, cost, and usage but does not alter payloads.
- Maintain all AI Proxy telemetry, logging, and cost-calculation features unchanged.

## Consequences

### Positive

- Zero-touch integration for existing SDK-based clients.
- Consistent observability across custom and standardized requests.

### Risks

- Bypasses transformation may expose provider-specific headers or auth tokens.
- Reduced ability to enforce cross-provider consistency.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0154-enable-transparent-proxy-for-native-llm-sdk-integration.md)

- [AI Proxy Advanced “Passthrough mode”](https://docs.konghq.com/hub/kong-inc/ai-proxy-advanced/#use-programmatic-sdks-with-ai-proxy-advanced)
