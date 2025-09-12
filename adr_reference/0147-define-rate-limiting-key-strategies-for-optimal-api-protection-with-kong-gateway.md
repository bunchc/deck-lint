# 147. Define Rate Limiting Key Strategies for Optimal API Protection with Kong Gateway

Date: 2025-04-25

## Tags

kong, gateway, rate-limiting, key-strategy, api-protection, security, throttling, fairness, scalability

## Status

Accepted

## Context

Rate limiting is critical for protecting APIs against abuse, ensuring fair usage, and preserving upstream resources. In Kong Gateway, the entity by which limits are applied — the "rate limiting key" — has a significant impact on:

- How fairly quotas are enforced
- Risk of over-restricting legitimate users
- Scaling efficiency
- Operational complexity

Kong’s `rate-limiting` and `rate-limiting-advanced` plugins allow flexible keying strategies:

- Credential (e.g., API key, OAuth2 token)
- Consumer (authenticated user)
- IP address
- Header values
- Composite keys (advanced)

Choosing the right strategy is essential for balancing security, fairness, and performance.

## Decision

Define standard, scenario-driven strategies for selecting rate limiting keys in Kong Gateway, based on API sensitivity, authentication models, and operational scalability requirements.

### Implementation Guidelines

#### 1. Default to Consumer or Credential-Based Rate Limiting for Authenticated APIs

For APIs requiring authentication:

- Prefer rate limiting by `consumer`.

Example (`rate-limiting-advanced` config):

```yaml
config:
  limit_by: consumer
  identifier: consumer_id
```

Benefits:

- Fair usage per client/application
- Avoids punishing multiple users sharing the same IP (e.g., behind NAT)
- Facilitates fine-grained throttling and quota management

#### 2. Use IP-Based Rate Limiting for Public or Anonymous APIs

For public APIs without strong authentication:

- Use client IP address as the limiting key.

Example:

```yaml
config:
  limit_by: ip
```

Benefits:

- Provides basic abuse protection without user identity
- Simple to implement
- Catches bots or scraping attempts easily

Considerations:

- Beware of shared IPs (e.g., corporate proxies, mobile NAT gateways) unfairly throttling multiple users.
- Use flexible CIDR aggregation if needed for fairness.

#### 3. Use Custom Headers for Multi-Tenant Contexts

If Kong operates in multi-tenant platforms:

- Rate limit based on tenant-specific headers (e.g., `X-Tenant-ID`).

Example:

```yaml
config:
  limit_by: header
  header_name: X-Tenant-ID
```

This isolates traffic by logical tenant identifiers rather than physical network characteristics.

#### 4. Implement Composite or Tiered Keys for High Security

For sensitive APIs:

- Combine multiple fields (e.g., user ID + device ID + region) to create a composite rate limiting key.
- Supported via custom Kong plugins or advanced templates.

This minimizes abuse from compromised credentials or distributed attacks.

#### 5. Tune Limits Carefully Based on Key Strategy

Typical baselines:

- Per credential: High request quotas (1000+ RPS)
- Per IP: Stricter thresholds (10–100 RPS)
- Per tenant: Variable based on SLA tiers

Align limits with API SLAs, consumer contracts, and abuse patterns.

#### 6. Monitor Key Saturation and Adjust Dynamically

Track:

- Most throttled keys (e.g., consumers, IPs)
- Top consumers by error rate
- Quota exhaustion events

Adjust rate limits dynamically if systemic throttling becomes visible, e.g., during marketing campaigns or traffic surges.

## Consequences

### Positive Outcomes

- Fair and predictable API consumption across different user bases
- Protection against abusive traffic and bot attacks
- Flexible alignment with business models (e.g., API monetization tiers)
- Improved operational scalability and resilience under load

### Risks and Trade-offs

- Incorrect key selection can lead to over-throttling or under-throttling
- IP-based limits can unintentionally penalize large enterprise or mobile users
- Composite keys add operational complexity and require strong telemetry

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0147-define-rate-limiting-key-strategies-for-optimal-api-protection-with-kong-gateway.md)

- [Kong Rate Limiting Plugin Documentation](https://docs.konghq.com/hub/kong-inc/rate-limiting/)
- [Kong Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
