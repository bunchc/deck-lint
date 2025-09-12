# 160. Standardize Retrieval-Augmented Generation RAG Pipelines

Date: 2025-04-28

## Tags

kong, ai, llm, plugin, rag, retrieval-augmented-generation, vector-db, prompt-augmentation, centralization, scalability

## Status

Accepted

## Context

Building RAG pipelines requires each client application to generate semantic embeddings, query a vector database, and stitch retrieved content into prompts. Rolling your own solution in every service leads to duplicated code, inconsistent behavior, and a high operational burden.

## Decision

Adopt Kong’s **AI RAG Injector** plugin at the API gateway layer to centralize RAG logic:

- Configure the plugin once via the Kong Admin API (or decK) with parameters for your vector database endpoint, credentials, and top-k settings.
- On each incoming AI request:
  - Generate embeddings for the prompt using the configured embedding model.
  - Query the vector database for the top-k most similar vectors.
  - Inject the returned content pieces into the request body before forwarding to the upstream AI service.
- Let Kong handle retries, timeouts, and error mapping from the vector database.

### Security

- Store vector DB credentials in a secure vault and reference them in plugin configuration—never in application code.
- Restrict network access so only the Kong gateway can reach the vector database endpoint.

### Scalability

- Kong handles connection pooling to the vector database, allowing efficient parallel queries across high-TPS AI workloads.
- Tune concurrency and timeout settings in the plugin to match your DB cluster capacity.

## Consequences

### Positive

- Eliminates per-service RAG boilerplate; one plugin powers all RAG integrations.
- Ensures consistent prompt augmentation logic across teams.
- Simplifies credential management—only Kong needs DB access.

### Risks

- A misconfigured plugin can impact the performance of all downstream AI calls.
- Vector database becomes a centralized dependency; its availability directly impacts AI services.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0160-standardize-retrieval-augmented-generation-rag-pipelines.md)

- [AI RAG Injector Plugin Overview](https://docs.konghq.com/hub/kong-inc/ai-rag-injector/)
