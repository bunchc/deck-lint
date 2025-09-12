# 55. Protect Sensitive Business Flows with Bot Detection and Rate Limiting

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, authentication, security, rate-limiting, bot-detection, abuse-prevention, fraud-protection, throttling, api security, abuse detection, fraud detection, business logic abuse, bot mitigation, rate limiting, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

Implements [112. Apply Rate Limiting to Sensitive or High-Traffic Endpoints](0112-apply-rate-limiting-to-sensitive-or-high-traffic-endpoints.md)

## Context

Sensitive business flows such as authentication, payment processing, or critical service endpoints are attractive targets for abuse (e.g., credential stuffing, account takeover, fraud). Preventing abuse requires both detection and throttling mechanisms.

## Decision

Implement protective measures at the API Gateway level:

- Use **Rate Limiting Advanced** plugin:
  - Apply stricter thresholds on sensitive endpoints compared to general APIs.
  - Throttle traffic on a per-consumer, per-IP, or per-endpoint basis as appropriate.
- Deploy **Bot Detection** plugin (or external service integration):
  - Detect and block or challenge requests exhibiting bot-like patterns.
  - Integrate with CAPTCHA or browser verification services when needed.

Optional Enhancements:

- Monitor usage anomalies and trigger dynamic adjustments to thresholds.
- Apply behavioral analysis techniques (e.g., request velocity patterns) to detect sophisticated attacks.

## Consequences

### Positive

- Reduces the risk of automated abuse against critical API flows.
- Preserves system availability during targeted attack attempts.
- Protects sensitive user operations and improves platform trustworthiness.

### Risks

- False positives may inadvertently block legitimate users if detection thresholds are too strict.
- Bot patterns evolve, requiring ongoing tuning and detection updates.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0055-protect-sensitive-business-flows-with-bot-detection-and-rate-limiting.md)
- [Bot Detection Plugin](https://docs.konghq.com/hub/kong-inc/bot-detection/)
- [Rate Limiting Advanced Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/)
