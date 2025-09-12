# 6. Golden‑Image Standardization

Date: 2025-04-22

## Tags

image, docker, standardization, build, golden-image, security, containerization, kong-gateway, base-image, reproducibility, compliance, hardening, immutable-infrastructure

## Status

Accepted

Used in [7. Kong Image Build Process](0007-kong-image-build-process.md)

## Context

Golden images are pre‑configured, versioned Docker base images used to enforce consistency, security, and reliability across development, test, and production environments. In Kong Gateway projects, we need a single “approved” base image that all team members can build upon.

## Decision

Mandate a single, versioned golden base image for all Kong Gateway containers. This image will include:

- Minimal OS layer hardened and patched.
- Kong Gateway installed but no custom plugins.
- Standard security settings, monitoring agents, and configuration defaults.

All downstream images (with custom plugins, integrations, etc.) must extend from this golden base.

## Consequences

### Positive Outcomes

- **Standardization**: Every container starts from the same known good baseline.
- **Security**: Patches and hardening applied once at the base level.
- **Reproducibility**: Environments (dev/test/prod) use identical foundations.
- **Maintainability**: One place to roll forward OS or Kong version updates.

### Risks

- Single maintenance point: if the golden image build breaks, all pipelines fail until fixed.
- Potential image bloat if too many components are shoe‑horned into the base.
- Requires discipline to keep the golden image up‑to‑date with security patches.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0006-golden-image-standardization.md)
- [Kong Docker Installation](https://docs.konghq.com/gateway/latest/install/docker/)
- [Kong Container Image Reference](https://docs.konghq.com/gateway/latest/reference/configuration/)
