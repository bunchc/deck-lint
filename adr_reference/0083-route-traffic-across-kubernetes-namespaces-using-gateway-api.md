# 83. Route Traffic Across Kubernetes Namespaces Using Gateway API

Date: 2025-04-24

## Tags

kong, api, gateway, security, kubernetes, kic, gateway-api, cross-namespace, ingress-controller, multi-tenant

## Status

Accepted

## Context

As Kubernetes environments grow in complexity, services are often distributed across multiple namespaces for security, isolation, and organizational boundaries. By default, Kubernetes ingress controllers and routing configurations are namespace-scoped, which can limit service discovery and API composition across teams.

Kong Ingress Controller (KIC) supports the Kubernetes Gateway API, which introduces cross-namespace routing capabilities. This provides a scalable and secure way to expose and manage services across namespaces while aligning with platform engineering best practices.

## Decision

Enable and configure Kong Ingress Controller with **Kubernetes Gateway API** support to route traffic across namespaces:

### Key Steps

- **Install Kong Ingress Controller (KIC)** with Gateway API CRDs enabled.
- Define a **Gateway** and associated **GatewayClass** to represent the Kong Gateway instance.
- Use **HTTPRoute** resources with **cross-namespace references** (via `ParentRefs` and `BackendRefs`) to expose services in other namespaces.
- Ensure proper **RBAC** permissions (e.g., `ReferenceGrant`) are defined to allow controlled cross-namespace communication.

### Use Cases

- API consolidation for microservices spanning multiple teams.
- Multi-tenant platforms with centralized ingress and distributed workloads.
- Exposing shared backend services (e.g., auth, logging, observability) to all namespaces.

## Consequences

### Positive

- Simplifies network topology and service exposure across environments.
- Improves modularity and separation of concerns in platform design.
- Enables multi-team ownership while maintaining centralized ingress control.

### Risks

- Misconfigured `ReferenceGrant` objects can result in unintentional exposure.
- Requires version alignment with Kubernetes Gateway API and KIC support.
- Needs operator familiarity with Gateway API conventions.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0083-route-traffic-across-kubernetes-namespaces-using-gateway-api.md)

- [Kong Gateway API Support](https://docs.konghq.com/kubernetes-ingress-controller/latest/references/gateway-api/)
- [Kubernetes Gateway API Spec](https://gateway-api.sigs.k8s.io/)
- [Kong Blog: Sending Traffic Across Namespaces with Gateway API](https://konghq.com/blog/engineering/sending-traffic-across-namespaces-with-gateway-api)
