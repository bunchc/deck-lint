# 192. Version Control Mock Server Configurations in Git for Consistency

Date: 2025‑06‑12

## Tags

insomnia, mocking, version-control, mockbin, git, configuration, reproducibility, collaboration

## Status

Accepted

Uses [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)
Uses [172. Standardize Git-Backed API Projects in Insomnia](0172-standardize-git-backed-api-projects-in-insomnia.md)

## Context

Self-hosted mock configurations (mock server definitions and mock routes) are critical infrastructure components, akin to API spec and tests. To maintain consistency, reproducibility, and team alignment, these configurations must be tracked alongside the code they support. In Insomnia, mock configurations can be stored in a designated directory (e.g., `mocks/`) and committed to Git.

Without version control, mocks may diverge unintentionally, lack clear history, or be lost during branch merges or refactors.

## Decision

Adopt a standard practice of keeping mock server configurations under version control:

- Store mock server files and route definitions in a consistent directory (e.g., `mocks/`).
- Treat these files as first-class citizens in the repository—commit and review them alongside code and spec changes.
- Update mocks when API behavior evolves, capturing changes in Git history.
- Use Git features (pull requests, diffs, audits) to manage mock updates and catch unintended alterations.

## Consequences

### ✅ Positive Outcomes

- **Traceability**: Every change to mock configuration is recorded and attributable.
- **Reproducibility**: Any developer can clone and recreate the mock environment exactly.
- **Collaboration**: Peer review ensures bumps and breaks are deliberate and understandable.
- **Governance**: Mock evolution aligns with API contract and versioning standards.

### ⚠️ Risks

- **Repository Growth**: Mock definitions may bloat the repo if not managed properly.
- **Merge Conflicts**: Multiple developers editing the same mocks could create conflicts, requiring resolution.
- **Outdated Mocks**: Without discipline, mocks may lag behind actual API updates.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0192-version-control-mock-server-configurations-in-git.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
- [Mockbin GitHub Repository](https://github.com/Kong/insomnia-mockbin)
