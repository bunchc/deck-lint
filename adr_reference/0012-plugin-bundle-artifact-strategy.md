# 12. Plugin‑Bundle Artifact Strategy

Date: 2025-04-22

## Tags

kong, gateway, plugin, bundle, dependency-management, artifact-management, luarocks, rockspec, plugin-bundling, versioning, build-process, release-management

## Status

Accepted

Used by [10. LuaRocks Package‑Management for Kong Plugins](0010-luarocks-package-management.md)

## Context

Managing many individual plugin versions—and keeping container artifacts lean—can be challenging. A “plugin bundle” collects multiple plugin dependencies into a single rockspec.

## Decision

- Create a **bundle rockspec** (no code, only `dependencies = { … }`) that lists approved plugin versions.
- Name bundles using `<bundle-name>-<version>-<revision>.rockspec`, e.g. `kong-plugin-petstore-bundle-1.0.0-1.rockspec`.
- Install the bundle via `luarocks install <bundle>` during image build.

## Consequences

### Positive Outcomes

- One artifact version to bump instead of many.
- Simplified build scripts: `luarocks install my-bundle`.
- Centralized control of plugin sets.

### Risks

- Bundle rockspec maintenance overhead.
- If any single plugin in the bundle is updated, the entire bundle version must bump.
- Potential for hidden dependency surprises if fallback repos are enabled.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0012-plugin-bundle-artifact-strategy.md)
- [Plugin Development - Distribution](https://docs.konghq.com/gateway/latest/plugin-development/distribution/)
- [Package Management with LuaRocks](https://docs.konghq.com/gateway/latest/plugin-development/distribution/#install-the-plugin)
