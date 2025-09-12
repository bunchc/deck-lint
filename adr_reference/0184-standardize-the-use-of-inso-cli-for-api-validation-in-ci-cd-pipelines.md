# 184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines

Date: 2025-06-12

## Tags

inso, ci-cd, api-validation, spectral, insomnia, automation, testing, linting

## Status

Accepted

Used by [185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`](0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)
Used by [186. Automate Test Execution with `inso run test` Across CI/CD Pipelines](0186-automate-test-execution-with-inso-run-test-across-ci-cd-pipelines.md)
Used by [187. Use `inso export spec` for Clean OpenAPI Outputs in Automation Workflows](0187-use-inso-export-spec-for-clean-openapi-outputs-in-automation-workflows.md)

Uses [178. Use Structured Test Suites in Insomnia for API Verification](0178-use-structured-test-suites-in-insomnia-for-api-verification.md)
Uses [182. Adopt Spectral as the Standard Linting Engine for OpenAPI in Insomnia](0182-adopt-spectral-as-the-standard-linting-engine-for-openapi-in-insomnia.md)

## Context

Local validation of API specifications and test coverage via the Insomnia desktop application is effective for development but insufficient for automated quality enforcement across teams. Organizations require consistent, repeatable validation in CI/CD pipelines to prevent non-compliant or broken specifications from being merged or released.

The **Inso CLI** — the command-line companion to Insomnia — brings the power of linting and testing into terminal workflows and CI/CD environments. It supports Spectral-based linting and execution of Insomnia-defined test suites, enabling fully automated quality gates during pull requests, merges, or releases.

## Decision

Adopt **Inso CLI** as the standard tool for automated API validation in all CI/CD pipelines that involve OpenAPI specification development.

At a minimum, the following commands must be included in relevant CI jobs:

- `inso lint spec`: Lints OpenAPI documents against Spectral rules.
- `inso run test`: Executes defined test suites from Insomnia, optionally filtered by environment or test name.

These checks must be integrated into the merge and release workflows of all Git-backed repositories containing API specs and tests.

## Consequences

### Positive Outcomes

- **Automation**: Eliminates manual QA steps and ensures consistent enforcement.
- **Early Detection**: Surfaces errors before merging, reducing regressions.
- **Developer Confidence**: Validates both structure and function across environments.
- **Toolchain Alignment**: Reuses existing Insomnia artifacts without duplication.

### Risks

- **Pipeline Overhead**: Adds steps that slightly increase CI execution time.
- **Initial Setup Effort**: Requires bootstrapping CLI environments (e.g., Node.js, Inso CLI).
- **Dependency on Inso CLI Versioning**: Inconsistencies may arise if not pinned or kept up-to-date.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)
- [Inso CLI](https://developer.konghq.com/inso-cli/)
- [Automate tests in Insomnia](https://developer.konghq.com/how-to/automate-tests/)
