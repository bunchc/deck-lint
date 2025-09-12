# 32. Use of Control Plane Groups in Kong Konnect

Date: 2025-04-22

## Tags

control-plane, groups, konnect, governance

## Status

Accepted

Related to [33. Use of Control Planes or Workspaces and RBAC](0033-use-of-control-plane-or-workspaces-and-rbac.md)

## Context

Kong Konnect supports two models for managing Data Plane configuration:

- **Individual Control Planes**: Configuration is isolated per team, application, or environment.
- **Control Plane Groups**: Multiple Control Planes contribute configuration into a unified deployment bundle, distributed to shared Data Planes.

Control Plane Groups can simplify governance and operational scale but introduce architectural considerations that require careful planning.

## Decision

Control Plane Groups are a valid option within Kong Konnect and should be considered when they provide clear operational or governance benefits.

**Use Control Plane Groups when:**

- There is a need to **enforce shared global configuration** (e.g., mandatory plugins, headers, logging) across multiple Control Planes.
- **Data Plane scaling constraints** require minimizing the number of connections (e.g., very large fleets of Data Planes).
- Teams or applications share **closely coordinated routing** and **configuration change processes**.

**Prefer Individual Control Planes when:**

- Teams require **full isolation** of routes, plugins, and secrets.
- **Independent release cadences** are needed (e.g., development vs production pipelines).
- Risk of **configuration conflicts** (e.g., duplicate route names, credential overlaps) is high.
- Secret management requires **strict compartmentalization** (e.g., PCI or HIPAA environments).

## Considerations and Risks of Control Plane Groups

| Consideration                          | Description                                                                                                                                  |
| :------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------- |
| **Global Plugin Scope**                | Global plugins from one Control Plane apply across the entire Group. Control at the individual Control Plane level is limited.               |
| **Configuration Conflict Propagation** | A naming conflict (Service, Route, Plugin) in one Control Plane can prevent the entire Group from syncing new configurations to Data Planes. |
| **Vault and Secret Sharing**           | All Control Planes in the Group share the same Vault resources (credentials, certificates), with no native per-Control-Plane scoping.        |
| **Route Overlaps**                     | Identical route paths from different Control Planes may cause routing ambiguity or overwrite issues.                                         |
| **Change Coordination Required**       | Teams sharing a Group must carefully coordinate releases and governance changes to avoid operational conflicts.                              |

## Alternatives Considered

- **Isolated Control Planes**: no grouping, maintaining strict team/application/environment separation.
- **Shared services without grouping**: use external service meshes or routing layers to handle shared APIs instead of merging configuration in Kong.
- **Governance via Kong RBAC**: enforce consistency through organization-wide policies, not merged Control Planes.

## Consequences

### Positive Outcomes

- Streamlined enforcement of global plugins and policies across multiple teams.
- Optimized scaling for very large fleets by reducing configuration distribution overhead.
- Simplified global observability and governance across many Control Planes.

### Risks & Trade-offs

- Misconfigurations or conflicts in one Control Plane can affect all Data Planes in the Group.
- Secrets and vault items must be carefully managed to prevent leakage between Control Planes.
- Operational and change management processes must be aligned across all teams sharing the Group.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0032-use-of-control-plane-groups-in-kong-konnect.md)
- [Konnect Control Plane Groups](https://docs.konghq.com/konnect/runtime-manager/runtime-groups/control-plane-groups/)
- [Konnect Runtime Groups](https://docs.konghq.com/konnect/runtime-manager/runtime-groups/)
