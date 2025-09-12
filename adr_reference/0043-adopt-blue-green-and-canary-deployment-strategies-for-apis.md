# 43. Adopt Blue-Green and Canary Deployment Strategies for APIs

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, deployment, kubernetes, monitoring, blue-green, canary, rollout, traffic-splitting, release-strategy, phased-deployment, risk-mitigation, automation, ci-cd, versioning, rollback

## Status

Accepted

Supports [47. Design for Failure in Distributed Systems](0047-design-for-failure-in-distributed-systems.md)

## Context

Deploying APIs without phased rollout increases risk. Incremental rollout strategies minimize downtime and enable faster rollback.

## Decision

Adopt deployment strategies:

- Blue-Green deployments for major version upgrades.
- Canary deployments for gradual rollout of changes to subsets of users.
- Use Kong Gateway traffic-splitting plugins for routing control.

## Consequences

### Positive

- Reduced blast radius for bad deployments.
- Safer validation of new API versions before full rollout.

### Risks

- Slightly increased operational complexity in deployment pipelines.
- Requires traffic monitoring to detect canary issues.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0043-adopt-blue-green-and-canary-deployment-strategies-for-apis.md)
- [Kong Gateway with CI/CD](https://docs.konghq.com/gateway/latest/production/deployment-topologies/sync-config/)
- [Kong Ingress Controller Canary Deployments](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/using-kongingress-resource/)
