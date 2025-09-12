# 2. Recommended Kong Deployment Architectures

Date: 2025-04-21

## Tags

architecture, deployment, topology, kong-enterprise, kong-konnect, ingress-controller

## Status

Accepted

Details Kong Enterprise Hybrid deployment in [3. Kong Enterprise CP/DP (Hybrid Mode) Deployment Architecture](0003-kong-enterprise-hybrid-deployment.md)

Details Kong Konnect SaaS deployment in [4. Kong Konnect (SaaS Control Plane) Deployment Architecture](0004-kong-konnect-saas-deployment.md)

Details Kong Ingress Controller deployment in [5. Kong Ingress Controller Kubernetes-native Deployment Architecture](0005-kong-ingress-controller-kubernetes-deployment.md)

Configured by [27. Control‑Plane to Data‑Plane Payload Sizing (`cluster_max_payload`)](0027-control-plane-to-data-plane-payload-sizing-cluster-max-payload.md)

See also: [168. Deploying Kong Gateway Enterprise Data Planes on AWS ECS Fargate](0168-deploying-kong-gateway-enterprise-data-planes-on-aws-ecs-fargate.md)

## Context

Kong Gateway can be deployed in multiple architectural patterns.  
This ADR documents the recommended production deployment architectures for Kong customers and highlights patterns that should be avoided to ensure reliability, scalability, and operational simplicity.

These recommendations are based on Kong Gateway 3.x and later.

## Decision

We recommend the following Kong deployment architectures for production environments:

| Deployment Model                         | Control Plane Management | Data Plane Management                                       | Key Characteristics                             |
| ---------------------------------------- | ------------------------ | ----------------------------------------------------------- | ----------------------------------------------- |
| **Kong Enterprise CP/DP**                | Customer-managed         | Customer-managed                                            | Full control, hybrid mode                       |
| **Kong Konnect (SaaS Control Plane)**    | Kong-managed (SaaS)      | Customer-managed or Kong-managed (Dedicated Cloud Gateways) | Cloud-native, SaaS CP                           |
| **Kong Ingress Controller (Kubernetes)** | Kubernetes cluster CP    | In-cluster                                                  | Kubernetes-native, optional Konnect integration |

### 1. Kong Enterprise Control Plane / Data Plane (Hybrid Mode)

- **Architecture**: Dedicated customer-managed control plane managing one or more customer-managed data planes.
- **Configuration flow**: Admin operations occur at the control plane and are synchronized to the data planes.
- **Use case**: Customers needing maximum control and flexibility in on-premises or private cloud deployments.

### 2. Kong Konnect (SaaS Control Plane)

- **Architecture**: Kong-hosted SaaS control plane managing customer-managed or Kong-managed data planes.
- **Configuration flow**: Admin operations occur in Konnect → synchronized to data planes.
- **Use case**: Customers seeking lower operational overhead with centralized configuration and telemetry.

### 3. Kong Ingress Controller for Kubernetes

- **Architecture**: Kubernetes-native Ingress Controller configuring embedded Kong data planes.
- **Configuration flow**: Kubernetes manifests → Ingress Controller → data planes.
- **Use case**: Organizations deploying Kong Gateway as part of a Kubernetes-based microservices platform.
- **Extended option**: Integration with Konnect for centralized API management and analytics.

## Options Considered

Other deployment patterns were evaluated but are not recommended for production use due to operational risks and scalability challenges.

## Consequences

### Positive Outcomes

- High availability and resilience by separating control and data planes.
- Simplified cloud operations through Kong Konnect SaaS services.
- Seamless Kubernetes-native integration for containerized application platforms.
- Future-proof architecture supporting scale, multi-region, and multi-cloud scenarios.

### Risks of Non-Recommended Patterns

The following architectures are discouraged for production deployments:

1. **Traditional Mode (DB-backed)**

   - **Problem**: Each data plane node connects directly to a shared database.
   - **Risks**: Database becomes a single point of failure; scaling and performance bottlenecks.

2. **DB-less Mode with Static File Configuration**
   - **Problem**: Each data plane node loads configuration locally.
   - **Risks**: Operational complexity managing configurations; difficult to scale and synchronize; brittle deployment processes.

Choosing non-recommended deployment patterns may result in reduced reliability, scalability limitations, and increased operational burden.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0002-recommended-kong-deployment-architectures.md)
- [Kong Deployment Options Overview](https://docs.konghq.com/gateway/latest/production/deployment-topologies/overview/)
- [Kong Deployment Topologies](https://docs.konghq.com/gateway/latest/production/deployment-topologies/)
- [About Kong Gateway](https://docs.konghq.com/gateway/latest/production/)
