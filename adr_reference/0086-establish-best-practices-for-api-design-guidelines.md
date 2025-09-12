# 86. Establish Best Practices for API Design Guidelines

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, authorization, api-design, standards, rest, documentation, governance, developer-experience, openapi

## Status

Accepted

## Context

As organizations grow their API portfolios, inconsistent design leads to poor developer experience, integration difficulties, and increased support burden. Standardizing API design ensures that services are discoverable, consistent, and predictable — fostering reusability, maintainability, and trust.

Kong Gateway and Konnect benefit significantly from well-designed APIs, as consistent practices simplify governance, onboarding, documentation, and security enforcement.

## Decision

Establish a set of organization-wide API design guidelines aligned with modern best practices:

### Core Design Principles

- **Naming and URI Structure**:

  - Use nouns and hierarchical resources (e.g., `/users/{userId}/orders`).
  - Favor kebab-case (`/user-profiles`) over camelCase or snake_case.

- **Versioning**:

  - Use URI-based versioning (`/v1/`) or media-type headers.
  - Avoid removing or repurposing fields in existing versions.

- **HTTP Methods & Semantics**:

  - Use standard methods (GET, POST, PUT, PATCH, DELETE).
  - Follow RESTful principles (e.g., POST to create, GET to retrieve).

- **Error Handling**:

  - Standardize error responses with consistent structure (`code`, `message`, `details`).
  - Use appropriate HTTP status codes (e.g., 400 for validation errors, 403 for auth failures).

- **Authentication & Authorization**:

  - Require secure authentication (e.g., OAuth 2.0, API key).
  - Use scopes or roles in headers or JWT claims for access control.

- **Documentation**:

  - Define and maintain OpenAPI specs for all APIs.
  - Include examples, sample requests/responses, and authentication details.
  - Use Kong Konnect’s Developer Portal or Swagger UI for discovery.

- **Schema & Data Models**:
  - Define reusable models for common entities (e.g., `User`, `Order`, `Error`).
  - Prefer explicit typing and enumeration of fields.

### Operationalizing Design Standards

- Use API linters and validators (e.g., Spectral) in CI/CD pipelines.
- Automate publication of OpenAPI specs to the Kong Developer Portal.
- Review design as part of the API onboarding workflow (e.g., ADRs or Pull Requests).

## Consequences

### Positive

- Increases consistency and predictability for API consumers.
- Simplifies enforcement of access, rate limits, and security via Kong plugins.
- Improves time-to-integrate and overall developer satisfaction.

### Risks

- May require refactoring legacy APIs to conform to standards.
- Requires cultural adoption and active review process to maintain.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0086-establish-best-practices-for-api-design-guidelines.md)

- [Kong Konnect Developer Portal](https://docs.konghq.com/konnect/dev-portal/)
- [OpenAPI Specification](https://swagger.io/specification/)
- [Kong Blog: Best Practices for API Design Guidelines](https://konghq.com/blog/engineering/best-practices-for-api-design-guidelines)
- [Spectral OpenAPI Linter](https://docs.stoplight.io/docs/spectral/)
