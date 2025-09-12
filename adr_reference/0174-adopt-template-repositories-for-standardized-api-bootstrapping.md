# 174. Adopt Template Repositories for Standardized API Bootstrapping

Date: 2025-06-12

## Tags

template-repo, insomnia, git, onboarding, api-bootstrapping, standardization, github

## Status

Accepted

Used by [175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia](0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)

Uses [173. Use Feature Branches for Isolated API Development in Insomnia](0173-use-feature-branches-for-isolated-api-development-in-insomnia.md)
Uses [172. Standardize Git-Backed API Projects in Insomnia](0172-standardize-git-backed-api-projects-in-insomnia.md)
Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

To reduce setup friction and enforce best practices, use a Git-hosted **template repository** that includes assets like a minimal service implementation, Docker configuration, and directory structure. This template ensures that every participant starts from a consistent baseline, which helps in maintaining repeatability and reducing onboarding time.

The template may include assets like:

- A mock implementation of the API
- A `docker-compose.yaml` file to run the service locally
- Predefined naming conventions and setup instructions

Using a template repository aligns with Kong’s philosophy of specification-first design, while enabling quick prototyping with minimal infrastructure effort.

## Decision

Adopt **template repositories** as the standard approach for bootstrapping API design and development projects in Insomnia.

Each team or participant must:

- Use someting like “Use this template” feature to generate their own repository from a centrally maintained template
- Name the new repo following a standardized convention (e.g., `accounts-service-<initials>`)
- Clone and run the template service locally using Docker Compose
- Begin API spec design within Insomnia against the running local mock

## Consequences

### Positive Outcomes

- **Standardization**: All developers begin with the same structure and naming conventions.
- **Faster Onboarding**: Reduces cognitive overhead and setup time for new contributors.
- **Local Testing Support**: Docker Compose enables immediate feedback via a working API mock.
- **Alignment with Spec-First**: Developers can focus on API design in Insomnia without needing to implement the backend first.

### Risks

- **Template Drift**: If templates are not centrally maintained, they may become outdated or inconsistent.
- **Limited Flexibility**: Teams may need to customize templates, which could reintroduce inconsistency.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0174-adopt-template-repositories-for-standardized-api-bootstrapping.md)
- [Version control in Insomnia](https://developer.konghq.com/insomnia/version-control/)
