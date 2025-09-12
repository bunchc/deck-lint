# 60. Implement API Inventory Management and Versioning Control

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, api inventory, versioning, service catalog, api lifecycle, api governance, api management, zombie api, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

## Context

Without a complete and up-to-date inventory of deployed APIs, organizations are exposed to risks such as forgotten endpoints, zombie APIs, and undocumented functionality. Effective API inventory and versioning control improves visibility, governance, and security posture.

## Decision

Establish an API inventory and version management process:

- Maintain a **centralized service catalog**:
  - Track every deployed API, including metadata such as owners, environments, and versions.
  - Integrate Kong Gateway data (e.g., Services and Routes) with inventory systems where feasible.
- Implement **strict API versioning**:
  - Use semantic versioning for APIs (e.g., v1, v2) embedded in URL paths, headers, or gateway routing rules.
  - Avoid in-place breaking changes; introduce new versions instead.
- Mark deprecated APIs clearly and set retirement timelines.
- Monitor runtime exposure:
  - Regularly review active routes and services to detect stale or undocumented APIs.

Optional Enhancements:

- Integrate inventory management with Developer Portals for discoverability.
- Use tagging strategies in Kong Gateway to support logical groupings (e.g., internal-only, public-facing, legacy).

## Consequences

### Positive

- Increases control over deployed APIs and reduces security gaps from zombie endpoints.
- Improves developer experience with clear discovery and versioning guidelines.
- Supports security audits, lifecycle management, and operational compliance.

### Risks

- Requires consistent maintenance of inventory metadata over time.
- Poor versioning discipline could lead to API sprawl and consumer confusion.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0060-implement-api-inventory-management-and-versioning-control.md)

- [Kong Manager API Inventory](https://docs.konghq.com/gateway/latest/kong-enterprise/kong-manager/)
- [Kong Portal](https://docs.konghq.com/gateway/latest/kong-enterprise/dev-portal/)
