# 10. LuaRocks Package‑Management for Kong Plugins

Date: 2025-04-22

## Tags

kong, gateway, plugin, deployment, luarocks, package-management, dependency-resolution, custom-plugins, plugin-installation, abi-compatibility, plugin-distribution, lua, packaging

## Status

Accepted

Used by [8. Custom‑Plugin Deployment Strategy](0008-custom-plugin-deployment-strategy.md)

Uses [11. LuaRocks Server Hosting Strategy](0011-luarocks-server-hosting-strategy.md)

Uses [12. Plugin‑Bundle Artifact Strategy](0012-plugin-bundle-artifact-strategy.md)

## Context

LuaRocks ships with Kong and handles dependency resolution, but must be used carefully to match Kong’s LuaJIT engine and avoid public repository hijacks.

## Decision

- Use **LuaRocks** exclusively for installing custom plugins and bundles.
- Perform all `luarocks install` steps **inside the Kong distribution** to ensure ABI compatibility.
- Host private rockspecs in a controlled repo (see ADR‑0011).
- Define a “bundle” rockspec to group plugin dependencies (see ADR‑0012).

## Consequences

### Positive Outcomes

- Robust dependency resolution.
- Consistent file placement and module paths.
- Leverages a well‑known package manager.

### Risks

- Requires maintaining rockspec manifests.
- Build time increases for dependency graph resolution.
- Must ensure rockspec syntax and version constraints are correct.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0010-luarocks-package-management.md)
- [Custom Plugins in Kong](https://docs.konghq.com/gateway/latest/plugin-development/distribution/)
- [Installing a Custom Plugin](https://docs.konghq.com/gateway/latest/plugin-development/distribution/)
