# 53. Implement Rate Limiting and Size Limiting to Mitigate Resource Exhaustion

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, rate limiting, size limiting, resource protection, ddos, traffic management, api security, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

Implements [112. Apply Rate Limiting to Sensitive or High-Traffic Endpoints](0112-apply-rate-limiting-to-sensitive-or-high-traffic-endpoints.md)

Builds on [16. Sync‑Rate Policy for Rate‑Limiting Advanced & Service Protection Plugins](0016-sync-rate-policy-for-rate-limiting-advanced-and-service-protection-plugins.md)

## Context

APIs exposed to unthrottled traffic are vulnerable to Denial of Service (DoS) attacks or resource exhaustion from legitimate but excessive use. Implementing strong rate limiting and payload size controls protects system stability under load.

## Decision

Apply resource protection mechanisms at the API Gateway:

- Use Kong’s **Rate Limiting Advanced** plugin to:
  - Define global or per-consumer request quotas.
  - Enforce different thresholds for internal vs external clients.
- Use Kong’s **Request Size Limiting** plugin to:
  - Restrict the maximum size of incoming requests (e.g., POST bodies).
  - Prevent oversized payloads from overwhelming API gateways or upstream services.
- Configure tailored thresholds based on traffic patterns, business SLAs, and backend capabilities.

Optional Enhancements:

- Enable dynamic rate limiting adjustments during traffic spikes (e.g., burst protection).
- Differentiate limits based on API sensitivity (e.g., login APIs vs product listing APIs).

## Consequences

### Positive

- Protects the platform against abuse, DDoS attacks, and unexpected surges.
- Preserves backend service availability and responsiveness.
- Encourages efficient client application design.

### Risks

- Incorrect threshold settings can unintentionally block legitimate traffic.
- High-availability clients may require exception handling (e.g., whitelisted higher limits).

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0053-implement-rate-limiting-and-size-limiting-to-mitigate-resource-exhaustion.md)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
- [Request Size Limiting Plugin](https://docs.konghq.com/hub/kong-inc/request-size-limiting/)
