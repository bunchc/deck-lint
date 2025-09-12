# 96. Maintain One-to-One Mapping Between KIC and Gateway

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, deployment, kubernetes, kic, gatewayclass, multitenancy, isolation, controller, gateway-api

## Status

Accepted

## Context

The Kong Ingress Controller (KIC) was designed to watch and reconcile a single `GatewayClass` and its associated `Gateway` resources. Attempting to manage multiple Gateways from a single KIC instance introduces complexity and conflicts, especially in multitenant environments.

According to upstream Gateway API guidance, controllers should ideally manage one `GatewayClass`, and be scoped to a single `Gateway` instance. This design simplifies controller logic and prevents conflicting reconciliation behaviors.

## Decision

Enforce a **1:1 relationship between a KIC instance and a `Gateway`** resource. Each `Gateway` should have its own:

- Dedicated KIC instance (control plane),
- Dedicated `GatewayClass` with a unique `controllerName`,
- Scoped configuration and plugin usage.

This practice ensures controller behavior remains deterministic and tenant-safe.

### Example

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: tenant-a-gatewayclass
spec:
  controllerName: konghq.com/tenant-a
```

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: tenant-a-gateway
spec:
  gatewayClassName: tenant-a-gatewayclass
```

Then, deploy one KIC instance with:

```yaml
args:
  - --gateway-controller-name=konghq.com/tenant-a
```

## Consequences

## Positive Outcomes

- Simplifies troubleshooting and reconciliation logic.
- Prevents cross-Gateway configuration collisions.
- Supports per-tenant isolation, lifecycle management, and observability.

## Risks and Trade-offs

- Higher resource footprint (1 KIC instance per Gateway).
- Operational overhead increases with many Gateways.
- Requires automation or Helm templating for multi-KIC deployments.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0096-maintain-one-to-one-mapping-between-kic-and-gateway.md)

- [Kong GatewayClass Isolation](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/custom-class/internal-external/)
- [Gateway API Design Principles](https://gateway-api.sigs.k8s.io/)
- [Kong GitHub Discussion](https://github.com/Kong/kubernetes-ingress-controller/issues/4673)
