# 97. Align Upgrade Strategy Across KGO, KIC, Gateway, and Gateway API

Date: 2025-04-25

## Tags

kong, api, gateway, deployment, kubernetes, upgrade, kgo, kic, gateway-api, crd, compatibility, lifecycle, gitops

## Status

Accepted

## Context

Kong’s Kubernetes ecosystem comprises multiple components that evolve independently, including:

- **Kong Gateway Operator (KGO)**: manages the lifecycle of Kong Gateway and Kong Ingress Controller (KIC).
- **Kong Ingress Controller (KIC)**: reconciles Kubernetes resources and applies Gateway API logic.
- **Kong Gateway**: the runtime data plane receiving and processing API traffic.
- **Gateway API CRDs**: Kubernetes-native resources that define networking behavior and are versioned separately by SIG-NETWORK.

Improper sequencing of upgrades across these components can lead to:

- API deprecation issues,
- Incompatibilities between control and data planes,
- Broken traffic flows and observability gaps.

## Decision

Define a standardized, staged upgrade strategy in multi-gateway deployments:

1. **Upgrade the Gateway Operator (KGO)**

   - This ensures compatibility with upcoming CRDs and provides orchestration capabilities for future steps.

2. **Upgrade KIC Instances**

   - One by one, upgrade each tenant’s KIC deployment after validating KGO compatibility and CRD support.

3. **Upgrade Kong Gateway Versions**

   - Upgrade tenant-specific Gateway instances managed via KGO’s `DataPlane` resources.

4. **Update Gateway API CRDs**

   - After verifying controller compatibility, upgrade the cluster-scoped CRDs (e.g., `GatewayClass`, `HTTPRoute`) to newer versions.

5. **(Optional)**: Enable new Gateway API features and migrate older resources where applicable.

## Consequences

### Positive Outcomes

- Prevents controller or operator failures due to API mismatches.
- Allows safe testing of newer Gateway API features in stages.
- Aligns with GitOps or declarative deployment patterns using KGO and Helm.

### Risks and Trade-offs

- Adds procedural overhead and sequencing complexity.
- Newer features may be delayed until the final CRD upgrade step.
- Manual verification and staging per tenant may be required in shared environments.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0097-align-upgrade-strategy-across-kgo-kic-gateway-and-gateway-api.md)

- [KGO Compatibility Matrix](https://docs.konghq.com/gateway-operator/latest/reference/version-compatibility/)
- [KIC Version Compatibility Guide](https://docs.konghq.com/kubernetes-ingress-controller/latest/reference/version-compatibility/)
