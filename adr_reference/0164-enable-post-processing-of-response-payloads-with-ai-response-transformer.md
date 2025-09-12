# 164. Enable Post-Processing of Response Payloads with AI Response Transformer

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, response-transformer, post-processing, transformation, masking, enrichment, automation

## Status

Accepted

## Context

We need a flexible, low-code mechanism to inspect and transform responses from existing upstream APIs—e.g. to mask PII or enrich payloads—without modifying those services. Building custom middleware or rewriting each service is time-consuming, error-prone, and duplicates logic.

The **AI Response Transformer** plugin lets Kong Gateway intercept any upstream response, send it as the “user” prompt to a configured LLM, apply a developer-defined transformation prompt, and return only the transformed payload to clients.

## Decision

Attach the **ai-response-transformer** plugin at the required scope (global, service, route, or consumer) for response post-processing:

- **Prompt configuration**: use `config.prompt` to define the transformation instruction (e.g., “Mask all credit card numbers in this JSON with ‘\*’”).
- **LLM block**: mirror the AI Proxy plugin’s `llm:` section to point to Azure, OpenAI, etc., including credentials, model name, and options.
- **Transformation flow**:
  1. Client requests → Kong forwards to upstream.
  2. Upstream responds → Kong captures response body as LLM “user” message.
  3. Kong sends chat payload (`llm/v1/chat`) to LLM, including `prompt`.
  4. Kong returns LLM’s output as the client response.
- **Configuration scope**: apply globally for broad transformations, or limit to individual services or routes for targeted use cases.
- **Error handling**: ensure LLM errors propagate appropriate status codes; use `transformation_extract_pattern` and parsing flags for robust JSON extraction.

Security:

- Store API keys or tokens in secure secrets (Vault, Kubernetes Secrets).
- Use network policies or mTLS to protect downstream LLM endpoint.
- Limit `log_payloads` in production to avoid sensitive data in logs.

Performance:

- Tune model options (`max_tokens`, `temperature`) to balance cost, latency, and accuracy.
- Monitor LLM latency; consider asynchronous patterns if sub-second SLAs are required.

## Consequences

### Positive

- Zero-touch transformation of existing APIs without code changes.
- Consistent masking, enrichment, or filtering logic centralized at the gateway.
- Rapid iteration of transformation logic by tweaking `config.prompt`.

### Risks

- Added latency for each response, dependent on LLM performance.
- Potential costs for LLM usage at scale.
- Reliance on external LLM availability; needs robust retry/batch settings.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0164-enable-post-processing-of-response-payloads-with-ai-response-transformer.md)

- [AI Response Transformer How-To](https://docs.konghq.com/hub/kong-inc/ai-response-transformer/how-to/)
- [AI Response Transformer Configuration Reference](https://docs.konghq.com/hub/kong-inc/ai-response-transformer/)
