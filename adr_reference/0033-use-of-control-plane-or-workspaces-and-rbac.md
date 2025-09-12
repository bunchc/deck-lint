# 33. Use of Control Planes or Workspaces and RBAC

Date: 2025-04-22

## Tags

workspaces, rbac, governance, access-control, multi-tenant

## Status

Accepted

Related to [32. Use of Control Plane Groups in Kong Konnect](0032-use-of-control-plane-groups-in-kong-konnect.md)

Extended by [72. Integrate Kong Gateway with OPA for Declarative Access Control](0072-integrate-kong-gateway-with-opa-for-declarative-access-control.md)

## Context

When multiple teams or business units manage APIs on a shared Kong platform, isolation of configuration and permissions is essential to prevent conflicts and ensure governance.

## Decision

Adopt the following practices:

- Create one **Workspace or Control Plane (Konnect)** per team, product line, or domain.
- Define **RBAC roles** specific to each Workspace (Developer, Operator, Auditor) or Control Plane (Konnect).
- Reserve a governance Workspace or Control Plane (Konnect) for global policies and shared services.

## Consequences

### Positive

- Clear separation of team responsibilities.
- Improved security through role-scoped access.
- Easier auditing, rollback, and troubleshooting.

### Risks

- Requires strong Workspace lifecycle management processes.
- Cross-Workspace dependencies (e.g., service-to-service calls) must be planned carefully.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0033-use-of-control-plane-or-workspaces-and-rbac.md)
- [Workspaces in Kong Enterprise](https://docs.konghq.com/gateway/latest/kong-enterprise/workspaces/)
- [RBAC in Kong Enterprise](https://docs.konghq.com/gateway/latest/kong-enterprise/rbac/)
- [Konnect Runtime Groups](https://docs.konghq.com/konnect/runtime-manager/runtime-groups/)
