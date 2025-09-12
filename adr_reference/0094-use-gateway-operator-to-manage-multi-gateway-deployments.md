# 94. Use Gateway Operator to Manage Multi-Gateway Deployments

Date: 2025-04-25

## Tags

kong, api, gateway, deployment, kubernetes, gateway-operator, kgo, controlplane, dataplane, multitenancy, gitops, automation

## Status

Accepted

## Context

As organizations scale API infrastructure across teams or tenants, managing multiple Kong Gateways, each with its own data plane and control plane (KIC), becomes operationally challenging. Manually deploying and configuring each Kong Gateway and KIC instance introduces complexity, risk of misconfiguration, and drift across environments.

The Kong Gateway Operator (KGO) provides a Kubernetes-native way to manage Kong Gateways declaratively, offering orchestration for both the control plane (KIC) and the data plane (Gateway).

## Decision

Adopt the Kong Gateway Operator (KGO) to deploy and manage the lifecycle of multi-gateway configurations in a Kubernetes cluster. Each tenant or environment should be defined using:

- A dedicated `ControlPlane` resource for KIC.
- A corresponding `DataPlane` resource for Kong Gateway instances.

KGO will automate reconciliation of these resources, reducing manual effort and aligning with GitOps principles.

### Example

```yaml
apiVersion: gateway-operator.konghq.com/v1beta1
kind: ControlPlane
metadata:
  name: tenant-a-controlplane
spec:
  gatewayClass:
    controllerName: konghq.com/tenant-a
  deployment:
    replicas: 1
    image: kong/kubernetes-ingress-controller:<version>
```

```yaml
apiVersion: gateway-operator.konghq.com/v1beta1
kind: DataPlane
metadata:
  name: tenant-a-dataplane
spec:
  deployment:
    replicas: 2
    image: kong/kong-gateway:<version>
```

## Consequences

### Positive Outcomes

- Declarative, consistent management of multiple Kong Gateway environments.
- Simplifies scaling to many tenants or teams.
- Automates common tasks like version upgrades and side-by-side rollouts.
- Aligns with Kubernetes-native tooling and automation.

### Risks and Trade-offs

- Introduces an additional operator and CRDs that must be installed and maintained.
- Adds learning curve for teams unfamiliar with Gateway Operator workflows.
- Still maturing—some advanced features may require workarounds in early versions.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0094-use-gateway-operator-to-manage-multi-gateway-deployments.md)

- [Kong Gateway Operator Overview](https://docs.konghq.com/gateway-operator/latest/)
- [Blue/Green Upgrades with KGO](https://docs.konghq.com/gateway-operator/latest/guides/upgrade/data-plane/blue-green/)
