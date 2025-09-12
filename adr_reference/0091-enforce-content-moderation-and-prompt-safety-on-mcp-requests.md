# 91. Enforce Content Moderation and Prompt Safety on MCP Requests

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, ai, llm, mcp, content-moderation, safety, prompt-safety

## Status

Accepted

## Context

In AI-native architectures powered by LLMs and MCP servers, clients and agents generate dynamic prompts and ingest unpredictable responses. Without proper guardrails, this can lead to:

- Injection of harmful or unsafe prompts,
- Disclosure of sensitive or offensive content,
- Violation of compliance and ethical policies.

Kong AI Gateway offers content safety and governance plugins that allow organizations to enforce checks on both inbound and outbound traffic across MCP APIs.

## Decision

Deploy prompt moderation and safety plugins on MCP-related routes in Kong AI Gateway:

1. **AI Prompt Guard plugin**

   - Uses pattern-based validation (regex or keyword matching) to block dangerous prompts or content before reaching the LLM.
   - Ideal for simple rules around profanity, PII markers, or blacklist terms.

2. **AI Semantic Prompt Guard plugin**

   - Uses embedding-based matching and ML-powered intent classification to block semantically unsafe requests.
   - Useful for detecting harmful content even when phrased differently.

3. **Azure AI Content Safety plugin** _(optional)_

   - Calls external Azure APIs for toxicity, violence, sexual, or self-harm content detection.
   - Best for teams requiring third-party moderation infrastructure.

4. **AI Sanitizer plugin** _(optional)_
   - Automatically strips or redacts specific fields in requests or responses to prevent exposure of PII or sensitive info.

## Consequences

### Positive Outcomes

- Adds robust safety and compliance enforcement at the API layer.
- Enables centralized governance of prompt input and response output.
- Reduces risk of model abuse, hallucinations, or regulatory violations.

### Risks and Trade-offs

- Semantic and third-party content safety plugins introduce slight latency.
- Requires active tuning of prompt rules, thresholds, and safety limits.
- Prompt safety is not foolproof — may still require user-side moderation or fallback logic.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0091-enforce-content-moderation-and-prompt-safety-on-mcp-requests.md)

- [AI Prompt Guard Plugin](https://docs.konghq.com/hub/kong-inc/ai-prompt-guard/)
- [AI Semantic Prompt Guard Plugin](https://docs.konghq.com/hub/kong-inc/ai-semantic-prompt-guard/)
- [Azure AI Content Safety Plugin](https://docs.konghq.com/hub/kong-inc/ai-azure-content-safety/)
- [AI Sanitizer Plugin](https://docs.konghq.com/hub/kong-inc/ai-sanitizer/)
- Blog: [Securing, Observing, and Governing MCP Servers](https://konghq.com/blog/product-releases/securing-observing-governing-mcp-servers-with-ai-gateway)
