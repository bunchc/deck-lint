# 85. Govern GraphQL APIs Through Kong Gateway

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, authorization, graphql, caching, rate-limiting, query-management

## Status

Updated

## Context

GraphQL APIs provide powerful data access flexibility, but they also pose distinct governance and security challenges. Unlike RESTful APIs, GraphQL exposes a single endpoint that clients use to send complex queries. This complicates traditional policy enforcement, rate limiting, and caching strategies.

To address these needs, Kong Gateway offers GraphQL-native plugins such as:

- **GraphQL Rate Limiting Advanced** – for query-level rate control,
- **GraphQL Proxy Caching Advanced** – for fine-grained caching of query responses,
- **DeGraphQL Plugin** – for converting GraphQL requests into REST-like service calls.

These tools allow teams to manage GraphQL APIs as first-class citizens within their API platform, applying consistent governance policies without modifying backend resolvers.

## Decision

Use Kong Gateway’s GraphQL-native plugins to govern GraphQL APIs at the API gateway layer:

### Plugin Usage

- **Authentication & Authorization**:

  - Apply OIDC, key-auth, or mTLS authentication to protect the GraphQL endpoint.
  - Use ACL and Consumer Groups to manage access per client type or use case.

- **Rate Limiting**:

  - Use **GraphQL Rate Limiting Advanced** to:
    - Limit query volume by operation name, complexity, or depth.
    - Apply rate rules per consumer, credential, or request path.
    - Prevent denial-of-service attacks via expensive or recursive queries.

- **Caching**:

  - Use **GraphQL Proxy Caching Advanced** to:
    - Cache query results based on operation, arguments, and headers.
    - Improve response time and reduce backend load for common queries.
    - Define rules for cache keys, TTLs, and bypass logic.

- **Query Management & Routing**:

  - Use the **DeGraphQL Plugin** to:
    - Split GraphQL operations into discrete RESTful calls.
    - Allow downstream services to work without GraphQL awareness.
    - Enable more granular policy enforcement and observability per operation.

- **Observability**:
  - Use Kong’s logging and tracing plugins to emit structured logs with query metadata.
  - Propagate tracing headers to trace end-to-end execution via OpenTelemetry.

## Consequences

### Positive

- Provides fine-grained policy enforcement tailored to GraphQL’s structure.
- Avoids requiring custom logic in GraphQL resolvers for governance.
- Supports advanced use cases like caching and complexity-based rate limits.

### Risks

- Requires accurate plugin configuration for operation names and query metadata.
- Some GraphQL capabilities (e.g., live queries, subscriptions) may not be supported.
- Complex rate/caching policies can add overhead to plugin processing.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0085-govern-graphql-apis-through-kong-gateway.md)

- [GraphQL Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/graphql-rate-limiting-advanced/)
- [GraphQL Proxy Caching Advanced Plugin](https://docs.konghq.com/hub/kong-inc/graphql-proxy-cache-advanced/)
- [DeGraphQL Plugin](https://docs.konghq.com/hub/kong-inc/degraphql/)
- [Kong Authentication Plugins](https://docs.konghq.com/hub/?category=authentication)
- [Kong Logging Plugins](https://docs.konghq.com/hub/?category=logging)
- [Kong Blog: Governing GraphQL APIs with Kong Gateway](https://konghq.com/blog/engineering/governing-graphql-apis-with-kong-gateway)
