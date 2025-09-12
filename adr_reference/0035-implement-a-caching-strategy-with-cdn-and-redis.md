# 35. Implement a Caching Strategy with CDN and Redis

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, monitoring, caching, redis, cdn, proxy-cache, performance, latency, scalability, edge-caching, response-caching, cache-invalidation, ttl, resilience, cloudfront, akamai

## Status

Accepted

## Context

APIs often serve highly cacheable responses (e.g., static metadata, pricing info). Implementing caching reduces backend load, improves latency, and enhances user experience.

## Decision

Adopt multi-tier caching:

- Use a CDN (e.g., CloudFront, Akamai) for edge caching of public APIs.
- Integrate Redis for API Gateway-level response caching for private/internal APIs.
- Use Kong’s Proxy Cache plugin for selective caching at the Gateway.

## Consequences

### Positive

- Faster response times for end users.
- Reduced backend service CPU and memory utilization.
- Resilient behavior during upstream outages (if cache-hit).

### Risks

- Cache invalidation and TTL tuning must be carefully managed.
- CDN configuration requires close monitoring for cache misses/hits.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0035-implement-a-caching-strategy-with-cdn-and-redis.md)
- [Proxy Caching Plugin](https://docs.konghq.com/hub/kong-inc/proxy-cache/)
- [Redis Configuration](https://docs.konghq.com/gateway/latest/reference/configuration/#redis-section)
