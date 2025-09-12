# 115. Protect the Admin API with Rate Limiting and DDoS Controls

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, authentication, kubernetes, admin-api, rate-limiting, ddos, security, ip-restriction, mtls, hardening, protection

## Status

Accepted

Builds on [108. Secure the Admin API with IP Restrictions and Authentication](0108-secure-the-admin-api-with-ip-restrictions-and-authentication.md)

Depends on [112. Apply Rate Limiting to Sensitive or High-Traffic Endpoints](0112-apply-rate-limiting-to-sensitive-or-high-traffic-endpoints.md)

## Context

The Kong Admin API provides powerful control over routing, authentication, plugins, and secrets. Without adequate protection, this API becomes a high-value target for abuse or accidental overuse, which could destabilize the platform or expose critical assets.

While access to the Admin API should already be secured (see ADR 108), additional safeguards like rate limiting, authentication throttling, and network-level protections are necessary to mitigate the impact of misbehaving clients or malicious traffic.

## Decision

Apply rate limiting and DDoS protection to the Kong Admin API in production environments.

### Protection Mechanisms

#### 1. Admin API Rate Limiting

Use a sidecar Kong instance (or a Kong route in front of the Admin API) to apply the `rate-limiting` or `rate-limiting-advanced` plugin.

Example:

```bash
curl -X POST http://localhost:8001/routes \
  --data "paths[]=/admin-api" \
  --data "service.name=admin-api"

curl -X POST http://localhost:8001/services \
  --data "name=admin-api" \
  --data "url=http://127.0.0.1:8001"

curl -X POST http://localhost:8001/services/admin-api/plugins \
  --data "name=rate-limiting" \
  --data "config.minute=10"
```

> Note: Care must be taken to avoid blocking legitimate automation or CI pipelines.

#### 2. IP Filtering and mTLS

Restrict Admin API access via:

- `ip-restriction` plugin
- mTLS using the `mtls-auth` plugin

Apply strict allowlists at both the network and Kong level.

#### 3. Infrastructure-Level Protection

For cloud-hosted Kong Gateways:

- Use API Gateway in front of Kong Admin API with built-in throttling
- Apply AWS WAF / GCP Armor / Azure DDoS protection

For Kubernetes:

- Limit ingress exposure using `NetworkPolicy`, `IngressClass`, or `admin-api` sidecar pattern

#### 4. Detection and Alerting

Forward audit logs and Admin API access logs to a SIEM (see ADR 114), and configure alerts on unusual usage patterns.

## Consequences

### Positive Outcomes

- Protects control plane against overload or abuse
- Adds resilience to critical management interfaces
- Complements authentication and audit controls with runtime protection

### Risks and Trade-offs

- May block legitimate automation if not carefully tuned
- Adds operational complexity for managing rate limits and safelists
- Requires test coverage to avoid accidental lockouts

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0115-protect-the-admin-api-with-rate-limiting-and-ddos-controls.md)

- [Kong Rate Limiting Plugins](https://docs.konghq.com/hub/kong-inc/rate-limiting/)
- [Kong IP Restriction Plugin](https://docs.konghq.com/hub/kong-inc/ip-restriction/)
- [Kong mTLS Plugin](https://docs.konghq.com/hub/kong-inc/mtls-auth/)
