# 167. Optimize LLM Prompt Handling with Semantic Cache

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, semantic-cache, embeddings, vector-db, caching, optimization, performance, cost-reduction

## Status

Accepted

## Context

Our platform relies increasingly on calls to large language models (LLMs) for tasks such as summarization, question-answering, and code generation. These calls incur latency and cost, especially for semantically similar or repeated prompts. Without caching at the semantic level, we re-compute embeddings and re-invoke LLM endpoints for near-duplicate inputs, wasting compute and increasing response times.

The **AI Semantic Cache** plugin for Kong Gateway provides a vector-based caching layer. It computes embeddings for incoming prompts, stores them in a vector database (e.g., Redis), and performs nearest-neighbor lookups. If a cached embedding exceeds a similarity threshold, the plugin returns the cached LLM response directly, bypassing the upstream request.

## Decision

Deploy the **ai-semantic-cache** plugin in front of our LLM routes:

- **Enable** the plugin on the LLM service or route:
  ```bash
  curl -X POST http://localhost:8001/services/llm-service/plugins \
    --data name=ai-semantic-cache \
    --data config.embeddings.model.provider=openai \
    --data config.embeddings.model.name=text-embedding-3-large \
    --data config.vectordb.strategy=redis \
    --data config.vectordb.dimensions=3072 \
    --data config.vectordb.distance_metric=cosine \
    --data config.vectordb.threshold=0.1 \
    --data config.vectordb.redis.host=redis.internal \
    --data config.vectordb.redis.port=6379
  ```
- **Configure** a similarity threshold (`threshold = 0.1`) to balance cache hits with semantic fidelity.
- **Use** Redis as both vector store and cache backend for simplicity and operational familiarity.
- **Store** embeddings with a time-to-live (TTL) aligned to our LLM usage patterns (e.g., 24 hours) to bound memory usage.
- **Scope** the plugin at the service or route level to isolate LLM-specific caching logic from other APIs.

### Security & Isolation

- Secure Redis connections with TLS and authentication.
- Apply the plugin only to trusted routes—deny public access to the embedding endpoint.
- Sanitize and validate prompt content before caching to avoid persisting sensitive data.

## Consequences

### Positive

- **Reduced latency** for semantically similar prompts by serving cached responses.
- **Lower LLM costs** through decreased upstream calls under heavy or repetitive workloads.
- **Adaptive caching** based on embedding similarity rather than exact string match.

### Risks

- **Stale or incorrect** responses if threshold or TTL misconfigured.
- **Increased memory usage** in Redis from storing high-dimensional embeddings.
- **Added operational complexity** managing vector database health and scaling.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0167-optimize-llm-prompt-handling-with-semantic-cache.md)

- [AI Semantic Cache Plugin Overview](https://docs.konghq.com/hub/kong-inc/ai-semantic-cache/)
- [Basic Configuration Examples](https://docs.konghq.com/hub/kong-inc/ai-semantic-cache/how-to/basic-example/)
- [OpenAI Embedding Models](https://platform.openai.com/docs/guides/embeddings)
