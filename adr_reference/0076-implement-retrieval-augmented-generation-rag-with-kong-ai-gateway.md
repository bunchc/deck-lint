# 76. Implement Retrieval-Augmented Generation (RAG) with Kong AI Gateway

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, deployment, ai, llm, rag, retrieval, retrieval-augmented generation, ai gateway, vector database, prompt engineering, llm orchestration, knowledge retrieval, api ai

## Status

Accepted

## Context

AI applications often need access to domain-specific knowledge that is too large or dynamic to embed in model weights. Retrieval-Augmented Generation (RAG) is a design pattern that improves the relevance and accuracy of large language model (LLM) responses by fetching external data at runtime and including it in the model's prompt.

Kong Gateway v3.8 introduced Kong AI Gateway, which enables integration of generative AI capabilities at the API layer. By combining Kong Gateway with RAG architectures, we can expose knowledge retrieval and generation APIs securely and at scale.

## Decision

Use Kong AI Gateway to enable Retrieval-Augmented Generation (RAG) applications by:

- **Deploying the Kong AI Gateway Plugin** to orchestrate LLM requests and prompt customization at the gateway level.
- **Defining a retrieval component** (e.g., vector database or full-text search) that is queried in real time using the API Gateway.
- **Augmenting LLM prompts** with retrieved knowledge dynamically using plugin configuration or upstream APIs.
- **Controlling AI exposure** with authentication, rate-limiting, logging, and observability plugins native to Kong.
- **Implementing tracing** of full RAG call flow via OpenTelemetry, from retrieval to prompt to LLM response.

Use Cases:

- AI-powered developer portals or documentation search
- Real-time knowledge augmentation in chat assistants
- Custom Q&A bots over enterprise content

## Consequences

### Positive

- Supports scalable and secure deployment of AI capabilities via APIs.
- Boosts accuracy and context of LLM outputs without retraining models.
- Leverages Kong’s native API management for fine-grained control over AI usage.

### Risks

- Introduces latency due to real-time retrieval and augmentation.
- Requires thoughtful security design for prompt injection or data leakage protection.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0076-implement-retrieval-augmented-generation-rag-with-kong-ai-gateway.md)

- [Kong AI Gateway Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/ai-gateway/)
- [Kong Blog: Implement Retrieval-Augmented Generation with Kong AI Gateway 3.8](https://konghq.com/blog/engineering/rag-application-kong-ai-gateway-3-8)
- [OpenAI on RAG Design Patterns](https://platform.openai.com/docs/guides/retrieval)
