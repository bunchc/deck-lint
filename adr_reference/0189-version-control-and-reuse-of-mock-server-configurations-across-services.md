# 189. Version Control and Reuse of Mock Server Configurations Across Services

Date: 2025-06-12

## Tags

insomnia, mocking, git, reuse, version-control, multi-service, accounts-service, transactions-service, self-hosted, mockbin

## Status

Accepted

Used by [193. Leverage Insomnia’s Mock Duplication to Share Mocks Across Dependent Services](0193-leverage-insomnia-s-mock-duplication-to-share-mocks-across-dependent-services.md)
Used by [194. Coordinate Mock and Consumer Service Versioning for Inline Testing](0194-coordinate-mock-and-consumer-service-versioning-for-inline-testing.md)

Uses [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)
Uses [172. Standardize Git-Backed API Projects in Insomnia](0172-standardize-git-backed-api-projects-in-insomnia.md)

## Context

Multiple services within our architecture depend on shared upstream APIs (e.g., `transactions-service` depends on `accounts-service`). To ensure consistent mock behavior across projects, it is essential to avoid duplicating or manually recreating mock configurations.

Insomnia supports duplication and cross-project reuse of mock entities via Git-backed projects. A mock created for one service (e.g., `accounts-service-mock`) can be copied into another service (e.g., `transactions-service`) with full fidelity and commit history.

## Decision

We will maintain a **single source of truth** for mock configurations in their originating service repositories and use **Insomnia's mock duplication feature** to share mocks across dependent projects.

Key implementation details:

- Mocks are committed and versioned in the `mocks/` folder within their originating repo.
- When another service requires the mock (e.g., `transactions-service`), it will **duplicate** the mock via Insomnia’s UI and include it in its own repository.
- Each project retains control over its local copy of the mock, enabling project-specific customization if needed.

## Consequences

### Positive Outcomes

- **Consistency**: Dependent services consume the same base mock behavior.
- **Modularity**: Services retain their independence while sharing a common contract.
- **Traceability**: Mock updates are visible in Git history and tied to specific commits.

### Risks and Limitations

- **Drift**: Changes to the mock in the source project won’t automatically propagate.
- **Manual duplication**: Duplication is a manual step; teams must ensure it remains synchronized if shared behavior evolves.
- **Custom divergence**: Local overrides may lead to behavioral inconsistencies if not documented.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0189-version-control-and-reuse-of-mock-server-configurations.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
- [Mockbin GitHub Repository](https://github.com/Kong/insomnia-mockbin)
