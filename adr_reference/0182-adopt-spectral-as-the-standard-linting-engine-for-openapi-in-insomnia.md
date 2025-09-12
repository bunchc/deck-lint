# 182. Adopt Spectral as the Standard Linting Engine for OpenAPI in Insomnia

Date: 2025-06-12

## Tags

insomnia, spectral, linting, openapi, api-standards, governance, validation

## Status

Accepted

Used by [183. Manage Custom Linting Rules in .spectral.yaml at the Repository Root](0183-manage-custom-linting-rules-in-spectral-yaml-at-the-repository-root.md)
Used by [184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines](0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)
Used by [185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`](0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)

Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

Maintaining consistent, high-quality API specifications across teams requires more than just manual reviews. Automated linters provide a scalable, repeatable mechanism to enforce structural and stylistic rules for OpenAPI documents.

Insomnia natively integrates with **Spectral**, a popular linting engine designed for OpenAPI, JSON Schema, and AsyncAPI specs. Spectral offers a flexible rules engine, supports default OpenAPI rules, and allows for deep customization to reflect organizational design standards.

By adopting Spectral as the standard linter within Insomnia, teams can catch common design issues early, automate governance, and improve API consistency across services.

## Decision

Mandate the use of **Spectral** as the default linting engine for all OpenAPI specifications authored and managed within Insomnia.

This includes:

- Enabling linting in all Insomnia projects by default.
- Using the built-in Spectral OAS ruleset as a baseline.
- Supporting further enforcement through `.spectral.yaml` files where customization is needed.
- Treating Spectral warnings and errors as actionable during API review and CI workflows.

Linting must be run interactively in the Insomnia UI and can optionally be integrated into Inso CLI for CI/CD validation.

## Consequences

### Positive Outcomes

- **Consistency**: Enforces uniform API style and structural integrity across teams.
- **Early Detection**: Flags issues during design rather than at implementation or review.
- **Governance**: Allows teams to define and evolve shared API standards.
- **Tooling Integration**: Compatible with Inso CLI and CI/CD pipelines.

### Risks

- **False Positives**: Overly strict rules may block useful changes unless tuned properly.
- **Initial Learning Curve**: Teams unfamiliar with Spectral may need onboarding.
- **Customization Required**: Default rules may not fully reflect internal standards.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0182-adopt-spectral-as-the-standard-linting-engine-for-openapi-in-insomnia.md)
- [Add custom linting rules in Insomnia](https://developer.konghq.com/how-to/add-custom-linting-rules/)
- [Spectral GitHub Repository](https://github.com/stoplightio/spectral)
