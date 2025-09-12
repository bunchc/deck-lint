# 112. Apply Rate Limiting to Sensitive or High-Traffic Endpoints

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, authentication, deployment, rate-limiting, ddos, throttling, security, performance, redis

## Status

Accepted

Required by [115. Protect the Admin API with Rate Limiting and DDoS Controls](0115-protect-the-admin-api-with-rate-limiting-and-ddos-controls.md)

Implemented by [53. Implement Rate Limiting and Size Limiting to Mitigate Resource Exhaustion](0053-implement-rate-limiting-and-size-limiting-to-mitigate-resource-exhaustion.md)

Depends on [17. Rate‑Limiting Algorithm Selection & Window‑Type Trade‑offs](0017-rate-limiting-algorithm-selection-and-window-type-trade-offs.md)

Depends on [55. Protect Sensitive Business Flows with Bot Detection and Rate Limiting](0055-protect-sensitive-business-flows-with-bot-detection-and-rate-limiting.md)

## Context

Public APIs, authentication endpoints, and internal services can be overwhelmed by abusive or misbehaving clients. Unrestricted access to such endpoints can lead to:

- Denial-of-service (DoS) conditions
- Credential stuffing or brute-force attacks
- Resource exhaustion (CPU, memory, database load)

Kong Gateway provides powerful plugins for rate limiting traffic based on consumers, IPs, routes, or services. Applying appropriate limits reduces the attack surface and protects upstream services from overload.

## Decision

All exposed endpoints — especially auth services, login routes, and public APIs — must be protected by rate limiting rules tailored to their sensitivity and expected traffic volume.

### Implementation Recommendations

#### Use `rate-limiting` Plugin for Simple Use Cases

Apply limits per IP or per consumer using Kong’s default plugin.

Example:

```bash
curl -X POST http://localhost:8001/services/auth-api/plugins \
  --data "name=rate-limiting" \
  --data "config.minute=100" \
  --data "config.policy=local"
```

#### Use `rate-limiting-advanced` for Redis-backed Distributed Enforcement

For multi-node deployments or precision control:

```bash
curl -X POST http://localhost:8001/services/payment-api/plugins \
  --data "name=rate-limiting-advanced" \
  --data "config.limit.name=login-limit" \
  --data "config.limit.default=30" \
  --data "config.sync_rate=10" \
  --data "config.redis.host=redis.internal"
```

This enables coordinated throttling using Redis and supports custom policies per route, service, or header.

#### Use Response Headers to Inform Clients

Optionally expose headers like `X-RateLimit-Remaining` to help well-behaved clients throttle themselves.

#### Combine with Auth and ACL Plugins

Rate limits can be scoped to different consumer groups, API plans, or clients via:

- ACL plugin
- OIDC scopes
- API key or JWT claims

## Consequences

### Positive Outcomes

- Protects critical services from overload or abuse
- Reduces infrastructure costs by shaping traffic at the edge
- Helps implement API product tiering and monetization

### Risks and Trade-offs

- Aggressive limits may block legitimate traffic or degrade UX
- Requires tuning thresholds based on realistic traffic patterns
- Needs Redis for distributed enforcement at scale

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0112-apply-rate-limiting-to-sensitive-or-high-traffic-endpoints.md)

- [rate-limiting Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting/)
- [rate-limiting-advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
