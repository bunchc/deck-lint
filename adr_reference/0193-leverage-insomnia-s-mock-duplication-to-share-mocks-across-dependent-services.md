# 193. Leverage Insomnia’s Mock Duplication to Share Mocks Across Dependent Services

Date: 2025‑06‑12

## Tags

insomnia, mocking, reuse, mockbin, multi-service, dependency, duplication, best-practice

## Status

Accepted

Uses [189. Version Control and Reuse of Mock Server Configurations Across Services](0189-version-control-and-reuse-of-mock-server-configurations-across-services.md)  
Uses [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)

## Context

In microservices architectures, upstream mocks (e.g., accounts-service) are often needed by downstream consumers (e.g., transactions-service). Manually recreating mocks in each consumer project can lead to inconsistencies, errors, and wasted effort. Insomnia supports **mock duplication**—enabling a mock defined in one project to be copied into another via the UI, preserving configuration and version history.

This feature enables teams to reuse mocks as true contract artifacts rather than reimplementing them piecemeal.

## Decision

Adopt the practice of **duplicating mock definitions** between projects to ensure consistent, version-controlled mock behavior across services.

Implementation guidelines:

- After creating a mock server (e.g., `accounts-service-mock`) in its project, duplicate it into consuming service projects (e.g., `transactions-service`) using Insomnia’s “Duplicate” UI action.
- The duplication preserves mock routes and metadata under the `mocks/` folder of the target project.
- Document the duplication process in onboarding guides and README.md to ensure accessibility for all contributors.

## Consequences

### Positive Outcomes

- **Consistency**: Consumers leverage the same mock contract without manual duplication.
- **Productivity**: Development is smoother with fewer setup steps.
- **Auditability**: Each project's mock version is visible and diffable in Git.
- **Decoupling**: Services can evolve independently while relying on shared contracts.

### Risks

- **Stale Mocks**: Updates in the source project don’t automatically propagate to consumer copies.
- **Manual Effort**: Requires deliberate action for duplication, which may be forgotten.
- **Divergence**: Consumer patches may drift from source unless tracked and reconciled.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0193-leverage-insomnias-mock-duplication-to-share-mocks-across-dependent-services.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
- [Mockbin GitHub Repository](https://github.com/Kong/insomnia-mockbin)
