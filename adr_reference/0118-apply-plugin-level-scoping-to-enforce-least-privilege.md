# 118. Apply Plugin-Level Scoping to Enforce Least Privilege

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, least-privilege, scoping, multi-tenant, zero-trust, best-practices, configuration

## Status

Accepted

## Context

Kong Gateway plugins offer a wide range of functionality including security, traffic control, logging, and transformation. These plugins can be applied at various scopes:

- **Global** (affecting all traffic across the gateway)
- **Service-level** (affecting a specific upstream service)
- **Route-level** (affecting a specific API path)
- **Consumer-level** (affecting a specific user or client)
- **Consumer group-level** (in Kong Enterprise)

Using overly broad scopes (e.g., global plugins for security or rate limiting) can lead to unintended consequences, such as:

- Over-applying controls to non-sensitive APIs
- Conflicts across services with different requirements
- Reduced transparency and control for application teams

## Decision

Avoid global plugin application unless absolutely necessary. Apply plugins at the most specific scope possible to follow the principle of least privilege.

### Recommended Scoping Patterns

| Use Case                      | Recommended Plugin Scope                   |
| ----------------------------- | ------------------------------------------ |
| AuthN/AuthZ per API           | Route or Service                           |
| Rate limiting for public APIs | Route                                      |
| Consumer quotas               | Consumer or Consumer Group                 |
| Logging (e.g., `file-log`)    | Service or Global (with filtering)         |
| CORS handling                 | Route                                      |
| Transformation logic          | Route or Service                           |
| Custom headers for tracing    | Global (if consistent across all services) |

### Implementation Example

```bash
# Add a rate limiting plugin on a single route
curl -X POST http://localhost:8001/routes/abc123/plugins \
  --data "name=rate-limiting" \
  --data "config.minute=30" \
  --data "config.policy=local"
```

Use `tags` and workspace separation to further isolate and organize plugin policies.

### Global Plugins: Use With Caution

Only apply plugins globally when:

- All traffic must be subject to the same rule (e.g., enforcing HTTPS or logging)
- You have clear version control over global policy changes
- You implement plugin filtering logic inside the plugin (e.g., conditional log suppression)

## Consequences

### Positive Outcomes

- Reduced risk of misconfiguration across unrelated services
- Greater control and flexibility for API teams
- Aligns with multi-tenant and zero-trust platform architectures

### Risks and Trade-offs

- Slight increase in configuration complexity
- Requires discipline and visibility across teams
- Potential for duplicate configuration unless automated

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0118-apply-plugin-level-scoping-to-enforce-least-privilege.md)
