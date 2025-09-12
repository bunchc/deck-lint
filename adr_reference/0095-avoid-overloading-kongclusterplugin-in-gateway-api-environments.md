# 95. Avoid Overloading KongClusterPlugin in Gateway API Environments

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, deployment, kubernetes, kongclusterplugin, gateway-api, multitenancy, scoping, isolation

## Status

Accepted

## Context

KongClusterPlugin is a cluster-scoped resource traditionally used in Ingress-based configurations to apply global or namespace-wide plugin settings. However, in Gateway API-based deployments — especially in multitenant environments — its usage can lead to unintentional side effects:

- A single KongClusterPlugin may unintentionally affect multiple tenants if bound via a shared `IngressClass`.
- It does not cleanly map to Gateway API objects like `GatewayClass`, `Gateway`, or `HTTPRoute`.
- Plugin scoping behavior becomes difficult to reason about, especially when multiple controllers are in play.

## Decision

In Gateway API environments, avoid using KongClusterPlugin as a global configuration mechanism unless absolutely necessary.

Instead:

- Use per-tenant `IngressClass` resources and isolate plugin application by controller scope.
- Prefer using **annotations on `HTTPRoute` resources** or **delegated plugin references** supported by the Kong Ingress Controller.
- Use **unique KongClusterPlugin names** per tenant or controller if shared plugins are required and scoping cannot yet be enforced via Gateway API resources.

## Consequences

### Positive Outcomes

- Reduces risk of plugin configuration leakage across tenants.
- Encourages more explicit and localized plugin application.
- Aligns with Gateway API principles where configuration is defined at the route and gateway level.

### Risks and Trade-offs

- Adds some operational overhead for plugin reuse across tenants.
- Limited support for plugin references in Gateway API may require future controller enhancements.
- Plugin scoping support in Gateway API is still evolving and may require future ADR updates.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0095-avoid-overloading-kongclusterplugin-in-gateway-api-environments.md)

- [Kong Ingress Controller: KongClusterPlugin Docs](https://docs.konghq.com/kubernetes-ingress-controller/latest/references/custom-resources/#kongclusterplugin)
- [KIC Plugin Usage with Gateway API](https://docs.konghq.com/kubernetes-ingress-controller/latest/gateway/api-reference/)
- [GitHub Issue: KongClusterPlugin Scoping](https://github.com/Kong/kubernetes-ingress-controller/issues/4673)
