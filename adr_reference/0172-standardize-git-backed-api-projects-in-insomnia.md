# 172. Standardize Git-Backed API Projects in Insomnia

Date: 2025-06-12

## Tags

insomnia, git-sync, version-control, collaboration, api-design, best-practices, metadata, spec-first

## Status

Accepted

Used by [173. Use Feature Branches for Isolated API Development in Insomnia](0173-use-feature-branches-for-isolated-api-development-in-insomnia.md)
Used by [174. Adopt Template Repositories for Standardized API Bootstrapping](0174-adopt-template-repositories-for-standardized-api-bootstrapping.md)
Used by [192. Version Control Mock Server Configurations in Git for Consistency](0192-version-control-mock-server-configurations-in-git-for-consistency.md)
Used by [189. Version Control and Reuse of Mock Server Configurations Across Services](0189-version-control-and-reuse-of-mock-server-configurations-across-services.md)

Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

Insomnia supports Git integration for managing API projects. This functionality enables teams to version control their OpenAPI specs, test scripts, environments, and collections through a Git-backed workflow.

In modern API development, especially within organizations using spec-first approaches, traceability and reproducibility are critical. Aligning API design with Git workflows ensures consistent governance and easy onboarding.

## Decision

Mandate the use of **Git-backed projects** for all API design and testing workflows in Insomnia. This includes:

- Creating new projects via the "Git Sync" flow in Insomnia.
- Storing OpenAPI specs, test definitions, environments, and metadata in a Git repository.
- Requiring a GitHub Enterprise (or equivalent) repository as the authoritative source of truth.
- Performing all API design and test changes through Git workflows (e.g., branches, pull requests, merges).

### Implementation Notes

- Use standardized repository naming conventions (e.g., `accounts-service-<initials>`).
- Insomnia metadata is stored inline within the spec file—no separate `.insomnia` directory is needed.
- Insomnia Git Sync supports commit, push, pull, and branch operations directly from the UI.
- Insomnia project setup includes automatic detection of the repository and prompt creation of a Git-backed project.

## Consequences

### Positive Outcomes

- **Version Control**: Full history of changes across the API design lifecycle.
- **Collaboration**: Multiple users can work concurrently via branches and pull requests.
- **Consistency**: All Insomnia configurations (e.g., environments, tests) are stored in Git.
- **Auditability**: Traceable commit history for compliance and governance.
- **Toolchain Integration**: Aligns API development with GitOps and CI/CD workflows.

### Risks

- **Learning Curve**: Users unfamiliar with Git or Insomnia’s Git Sync may require onboarding.
- **Access Management**: Requires proper GitHub Enterprise access and SSO setup.
- **Sync Conflicts**: Without good Git hygiene, teams may encounter merge conflicts or drift.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0172-standardize-git-backed-api-projects-in-insomnia.md)
- [Version control in Insomnia](https://developer.konghq.com/insomnia/version-control/)
