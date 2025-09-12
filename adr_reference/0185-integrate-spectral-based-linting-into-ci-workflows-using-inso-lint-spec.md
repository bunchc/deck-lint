# 185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`

Date: 2025-06-12

## Tags

inso, spectral, linting, ci-cd, automation, openapi, insomnia, governance, compliance

## Status

Accepted

Used by [186. Automate Test Execution with `inso run test` Across CI/CD Pipelines](0186-automate-test-execution-with-inso-run-test-across-ci-cd-pipelines.md)
Used by [187. Use `inso export spec` for Clean OpenAPI Outputs in Automation Workflows](0187-use-inso-export-spec-for-clean-openapi-outputs-in-automation-workflows.md)

Uses [184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines](0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)
Uses [183. Manage Custom Linting Rules in .spectral.yaml at the Repository Root](0183-manage-custom-linting-rules-in-spectral-yaml-at-the-repository-root.md)
Uses [182. Adopt Spectral as the Standard Linting Engine for OpenAPI in Insomnia](0182-adopt-spectral-as-the-standard-linting-engine-for-openapi-in-insomnia.md)

## Context

Linting ensures that OpenAPI specifications conform to a defined structure, style, and set of standards. While Insomnia surfaces Spectral lint errors in the desktop UI, it’s critical to extend this enforcement into **CI/CD pipelines** to prevent non-compliant specs from being merged.

The `inso lint spec` command provides a CLI-based linting tool using the same Spectral engine integrated in Insomnia. It supports custom rule files (`.spectral.yaml`), project-specific enforcement, and outputs actionable errors in terminal-friendly formats.

## Decision

Require the use of `inso lint spec` in all CI pipelines that validate OpenAPI documents. The linting step must:

- Run automatically on pull requests or commits that modify OpenAPI specs or `.spectral.yaml`.
- Use the working directory (`--workingDir`) to locate specs and rule configurations.
- Fail the pipeline if errors (or optionally, warnings) are present.

Example GitHub Actions integration:

```yaml
- name: Lint API Specification
  run: inso lint spec --workingDir api/accounts-service.yaml
```

## Consequences

### Positive Outcomes

- **Policy Enforcement**: Lint rules become non-optional and consistently applied.
- **Early Feedback**: Developers receive validation errors before code review.
- **Scalability**: Easily extends across many repositories and services.
- **Governance**: Enforces API quality standards at the infrastructure level.

### Risks

- **False Failures**: Incorrect or overly strict rules can block valid changes.
- **Rule Drift**: If `.spectral.yaml` files are not maintained, inconsistencies may appear.
- **Tooling Errors**: CI failures may occur if the CLI or config path is misconfigured.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)
- [Inso CLI](https://developer.konghq.com/inso-cli/)
