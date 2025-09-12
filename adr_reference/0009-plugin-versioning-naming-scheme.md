# 9. Plugin Versioning & Naming Scheme

Date: 2025-04-22

## Tags

plugins, versioning, naming, deployment, kong-gateway, custom-plugins, semantic-versioning, compatibility, plugin-management, plugin-identification, release-management

## Status

Accepted

Supports [8. Custom‑Plugin Deployment Strategy](0008-custom-plugin-deployment-strategy.md)

## Context

Kong treats the plugin **name** as its unique identifier. To support parallel major‑version upgrades (e.g., v1.0.0 → v1.1.0), we must embed version into the plugin name itself.

## Decision

- Use the pattern: `<plugin-base-name>-<major>v<minor>`, e.g. `petstore-auth-1v1`.
- Always use **major.minor.patch** in rockspecs, but **omit patch** from the name.
- Development versions remain at `0.0.0` in code; tagging and CI scripts update filenames on release.

## Consequences

### Positive Outcomes

- Multiple major‑versioned plugins coexist without conflict.
- Clear mapping from filename → version.
- Users select exact major.minor they depend on.

### Risks

- Configuration files must reference full name, increasing verbosity.
- Patch releases (x.y.z → x.y.(z+1)) invisible to end‑users; operators must ensure backward‑compatibility.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0009-plugin-versioning-naming-scheme.md)
- [Plugin Development - File Structure](https://docs.konghq.com/gateway/latest/plugin-development/file-structure/)
- [Plugin Distribution](https://docs.konghq.com/gateway/latest/plugin-development/distribution/)
