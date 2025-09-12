# 132. Deploy Kong Gateway with Blue/Green or Canary Upgrade Strategies

Date: 2025-04-25

## Tags

kong, gateway, deployment, kubernetes, upgrade-strategy, blue-green, canary, rollout, lifecycle, reliability

## Status

Accepted

## Context

Upgrading Kong Gateway, its plugins, or its associated control and data planes involves operational risk. Without a controlled deployment strategy, changes may introduce:

- Service interruptions
- Configuration incompatibilities
- Plugin failures
- Regressions impacting user traffic

Blue/green and canary deployment strategies offer systematic approaches to upgrade Kong Gateway components safely while minimizing downtime and validating new versions incrementally.

## Decision

Adopt blue/green or canary rollout strategies for Kong Gateway upgrades in production environments.

### Implementation Guidelines

#### 1. Blue/Green Deployment

- Deploy a new "green" Kong cluster (control and data planes) alongside the existing "blue" cluster.
- Synchronize configuration and plugins to the new environment.
- Perform validation tests on green before cutover.
- Gradually shift traffic to the green cluster using:
  - DNS updates
  - Load balancer reconfiguration
  - Gateway API or Kubernetes Service annotations

Rollback involves reverting traffic back to blue if needed.

#### 2. Canary Deployment (Gradual Rollout)

- Upgrade a small percentage of Kong data planes or ingress controllers first.
- Route a small percentage of traffic (e.g., 5%-10%) to upgraded instances.
- Monitor key metrics (latency, 5xx errors, plugin behavior) during canary phase.
- Expand traffic gradually once confidence is established.

Canary is ideal for rolling upgrades across multiple Kong nodes.

#### 3. Use Gateway Operator for Automated Upgrades (Optional)

If using Kong Gateway Operator (KGO) in Kubernetes, leverage its blue/green upgrade workflows:

- Deploy new control plane and data plane versions declaratively.
- Cutover services once green environment passes health checks.

#### 4. Pre-Upgrade Testing

Before production rollout:

- Validate plugins with the new Kong version.
- Check deprecated APIs and configuration options.
- Test high-traffic services under load conditions.

#### 5. Post-Deployment Monitoring

After upgrade:

- Watch for increases in error rates, latencies, or dropped connections.
- Validate service discovery, plugin execution, mTLS handshakes, and Admin API functionality.

Alert on anomalies and establish rollback plans if thresholds are breached.

## Consequences

### Positive Outcomes

- Reduced risk of downtime or service degradation during upgrades
- Ability to validate behavior in real traffic scenarios before full rollout
- Safer Kong Gateway lifecycle management at scale

### Risks and Trade-offs

- Requires infrastructure to run parallel Kong environments
- May involve DNS caching delays or routing inconsistencies during cutovers
- Adds operational complexity compared to in-place upgrades

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0132-deploy-kong-gateway-with-blue-green-or-canary-upgrade-strategies.md)

- [Kong Canary plugin](https://docs.konghq.com/hub/kong-inc/canary/)
- [Kong Gateway Operator Upgrade Patterns](https://docs.konghq.com/gateway-operator/latest/guides/upgrade/data-plane/blue-green/)
