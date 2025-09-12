# 109. Limit Plugin Scope to Essential Services and Routes

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, authorization, least-privilege, scoping, performance, best-practices

## Status

Accepted

Governed by [124. Enforce Secure Defaults for Kong Gateway Plugins](0124-enforce-secure-defaults-for-kong-gateway-plugins.md)

## Context

Kong plugins are powerful components that modify, validate, or enhance traffic passing through the gateway. Plugins can be applied globally, per service, per route, or per consumer. However, enabling plugins globally or too broadly can lead to:

- Unintended performance overhead across all traffic
- Security risks from unnecessary exposure (e.g., auth plugins on public routes)
- Configuration sprawl and complexity in debugging or tuning

To adhere to the principle of least privilege and improve platform stability, plugins should be scoped as narrowly as possible—only where explicitly needed.

## Decision

Apply Kong plugins only to the specific services, routes, or consumers that require them, unless a global scope is justified and tested for performance and compatibility.

### Scoping Recommendations

#### Global Plugins

Only use global plugins for:

- Observability (e.g., `prometheus`, `opentelemetry`)
- Logging (e.g., `file-log`, `http-log`)
- Cross-cutting concerns (e.g., `correlation-id`)

Ensure global plugins are performance-tested and universally required.

#### Service/Route-Level Plugins

Apply authentication, rate limiting, transformation, and validation plugins directly at the service or route level:

```bash
curl -X POST http://localhost:8001/services/payment-api/plugins \
  --data "name=oauth2" \
  --data "config.enable_authorization_code=true"
```

#### Consumer-Level Plugins

Use consumer-level plugins only for individual identity or quota management, such as:

- rate-limiting
- acl
- key-auth

Avoid combining global and consumer plugins unless absolutely required.

## Consequences

### Positive Outcomes

- Reduces runtime overhead by limiting plugin execution to relevant traffic.
- Prevents accidental exposure of security-sensitive functionality.
- Simplifies testing, debugging, and performance tuning.

### Risks and Trade-offs

- Requires careful planning and CI automation to apply plugin configs correctly.
- Omitting necessary plugins can create security or functionality gaps.
- Increased configuration overhead for large environments without automation.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0109-limit-plugin-scope-to-essential-services-and-routes.md)

- [Best Practices for Plugin Configuration](https://docs.konghq.com/gateway/latest/key-concepts/plugins/#main)
