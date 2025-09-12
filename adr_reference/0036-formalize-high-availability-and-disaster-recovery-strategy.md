# 36. Formalize High Availability (HA) and Disaster Recovery (DR) Strategy

Date: 2025-04-22

## Tags

kong, api, gateway, high-availability, disaster-recovery, ha, dr, business-continuity, resilience, uptime, failover, redundancy, rto, rpo, availability-zones, backup, scaling, reliability, platform-operations, recovery

## Status

Accepted

## Context

Ensuring business continuity requires well-defined High Availability (HA) and Disaster Recovery (DR) plans for API platforms.

## Decision

Implement HA and DR strategies:

- Use multiple Data Plane replicas across availability zones (AZs).
- Deploy Control Planes with database backups and failover capabilities.
- Define RTO (Recovery Time Objective) and RPO (Recovery Point Objective) targets for all platform components.

## Consequences

### Positive

- Increased API uptime and availability.
- Faster recovery from regional outages or infrastructure failures.
- Customer trust in API resilience improves.

### Risks

- Higher operational cost to maintain redundant infrastructure.
- DR drills and recovery procedures must be periodically tested.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0036-formalize-high-availability-and-disaster-recovery-strategy.md)
- [High Availability Reference](https://docs.konghq.com/gateway/latest/production/sizing-guidelines/)
- [Scaling Kong Gateway](https://docs.konghq.com/gateway/latest/production/scaling-kong-gateway/)
