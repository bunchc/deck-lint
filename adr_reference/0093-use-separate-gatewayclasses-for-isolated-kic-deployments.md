# 93. Use Separate GatewayClasses for Isolated KIC Deployments

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, deployment, kubernetes, gatewayclass, multitenancy, isolation, kic, gateway-api, controller

## Status

Accepted

## Context

In multitenant Kubernetes environments, it's common to run multiple Kong Gateway instances where each tenant requires its own configuration scope and isolation. The Gateway API offers a way to route traffic using `GatewayClass` and `Gateway` resources, which the Kong Ingress Controller (KIC) can reconcile.

By default, a single KIC instance reconciles all `Gateway` resources of the `GatewayClass` it watches. If multiple tenants share the same `GatewayClass`, they risk configuration collisions and reduced operational independence.

## Decision

Each KIC deployment should use a **dedicated `GatewayClass`**, with a **unique `controllerName`**. The KIC instance must be configured via `--gateway-controller-name` to only reconcile the resources for that specific class.

This isolates each tenant's control plane logic, allowing:

- Per-tenant plugin configurations,
- Resource quota boundaries,
- Versioned deployments of KIC or Gateway.

### Example

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: tenant-a-gatewayclass
spec:
  controllerName: konghq.com/tenant-a
```

Then start KIC like:

```shell
kubectl -n tenant-a apply -f kic-deployment.yaml
# where args include:
# --gateway-controller-name=konghq.com/tenant-a
```

## Consequences

### Positive Outcomes

- Clear separation of responsibilities across tenants.
- Easier debugging and lifecycle management (e.g., upgrades).
- Aligns with Gateway API design for scalable controller behavior.

### Risks and Trade-offs

- Requires additional KIC deployments per tenant (adds resource overhead).
- Slightly more complex operational setup (e.g., Helm values, namespace isolation).
- Developers must be trained to correctly associate Gateway with its GatewayClass.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0093-use-separate-gatewayclasses-for-isolated-kic-deployments.md)

- [Kong: Gateway API and GatewayClass Usage](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/custom-class/internal-external/)
- [Gateway API Specification](https://gateway-api.sigs.k8s.io/)
- [Kong Gateway Operator Docs](https://docs.konghq.com/gateway-operator/latest/get-started/kic/create-gateway/)
