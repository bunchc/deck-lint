# 34. Establish East-West Traffic Management with Service Mesh

Date: 2025-04-22

## Tags

kong, api, gateway, security, deployment, service-mesh, east-west-traffic, mtls, zero-trust, observability, traffic-management, resilience, circuit-breaking, retries, rate-limiting, tracing, metrics, internal-communication, microservices, ab-testing, gradual-rollout

## Status

Accepted

## Context

Use of Kong Gateway for service-to-service communication is not a best practice. Service-to-service communication inside a network ("East-West traffic") must be secured, observable, and controlled. Traditional perimeter security alone is insufficient in modern distributed environments.

## Decision

Adopt a Service Mesh to manage internal API traffic:

- Enforce mTLS for all East-West communication.
- Enable traffic routing, retries, circuit breakers, and rate limiting.
- Provide observability (traces, metrics) across service interactions.

## Consequences

### Positive

- Strong internal security (zero-trust networking).
- Improved application resilience and visibility.
- Fine-grained traffic control for A/B testing, failover, and gradual rollouts.

### Risks

- Increased operational complexity (sidecars, control planes).
- Requires adjustments to service deployment models and DevOps practices.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0034-establish-east-west-traffic-management-with-service-mesh.md)
- [Kong Mesh Documentation](https://docs.konghq.com/mesh/latest/)
- [Kong Mesh with Gateway](https://docs.konghq.com/mesh/latest/gateways/kong-gateway/)
