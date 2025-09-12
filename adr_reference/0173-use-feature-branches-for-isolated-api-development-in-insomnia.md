# 173. Use Feature Branches for Isolated API Development in Insomnia

Date: 2025-06-12

## Tags

insomnia, git, branching-strategy, collaboration, feature-branch, version-control, api-design

## Status

Accepted

Used by [174. Adopt Template Repositories for Standardized API Bootstrapping](0174-adopt-template-repositories-for-standardized-api-bootstrapping.md)

Uses [172. Standardize Git-Backed API Projects in Insomnia](0172-standardize-git-backed-api-projects-in-insomnia.md)
Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

Insomnia’s Git integration enables direct interaction with Git repositories, including support for multiple branches. In collaborative environments, especially when teams are designing and testing APIs simultaneously, managing work through feature branches is essential.

Using a single branch for all changes increases the likelihood of merge conflicts, unreviewed changes, or inconsistencies between contributors. Following Git best practices—such as feature branching and pull requests—ensures that changes are reviewed, isolated, and traceable.

## Decision

Require the use of **feature branches** for any design or test changes made within Insomnia. Contributors must:

- Create a new branch before starting work on a specific feature, module, or test scenario.
- Use descriptive branch names (e.g., `feature/api-spec-design` or `bugfix/fix-token-env`).
- Push branches to the remote repository and create pull requests for review.
- Avoid making changes directly to the default (`main` or `master`) branch.
- Merge only after review and validation.

This practice should be enforced regardless of whether the API design work is related to specification changes, test definitions, or environment updates.

## Consequences

### Positive Outcomes

- **Isolation**: Work is logically separated, reducing the risk of breaking changes or conflicting edits.
- **Code Review**: Pull requests allow for peer review, increasing quality and consistency.
- **Traceability**: Git history clearly reflects the purpose and scope of changes.
- **Parallel Development**: Multiple contributors can work on different aspects without blocking each other.
- **CI/CD Alignment**: Branching strategy supports automated testing and validation workflows.

### Risks

- **Workflow Complexity**: Requires contributors to understand and use Git operations properly.
- **Merge Overhead**: Changes must be merged and may require conflict resolution.
- **Enforcement Gaps**: Without process discipline, users may still push to the main branch or skip review steps.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0173-use-feature-branches-for-isolated-api-development-in-insomnia.md)
- [Version control in Insomnia](https://developer.konghq.com/insomnia/version-control/)
