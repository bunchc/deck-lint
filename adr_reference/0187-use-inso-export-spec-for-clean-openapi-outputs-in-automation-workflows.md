# 187. Use `inso export spec` for Clean OpenAPI Outputs in Automation Workflows

Date: 2025‑06‑12

## Tags

inso, export, openapi, clean-spec, automation, metadata-removal, ci-cd, insomnia

## Status

Accepted

Uses [186. Automate Test Execution with `inso run test` Across CI/CD Pipelines](0186-automate-test-execution-with-inso-run-test-across-ci-cd-pipelines.md)
Uses [185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`](0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)
Uses [184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines](0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)

## Context

Insomnia stores metadata (collections, environments, tests) inline within OpenAPI specs. While beneficial for Insomnia’s Git workflows, some downstream tools—such as documentation generators, code generators, or API gateways—require clean OpenAPI files without embedded Insomnia-specific annotations.

The `inso export spec` command produces a sanitized version of the OpenAPI spec by removing Insomnia metadata, ensuring compatibility with broader toolchains. This is especially important in CI/CD workflows where a clean spec may be needed for publishing, validation, or tooling purposes.

## Decision

Adopt `inso export spec` in automation workflows when a clean, metadata-free OpenAPI specification is required. The command should be used:

- After linting and before downstream tooling.
- To generate a separate spec file without inline metadata for distribution or processing.
- Especially in CI pipelines that push specs to registries, docs sites, or API gateways.

Example usage in CI:

```yaml
- name: Export Clean OpenAPI Spec
  run: |
    inso export spec \
      -w api/accounts-service.yaml spc_accounts-service \
      -o dist/accounts-service-clean.yaml
```

## Consequences

### Positive Outcomes

- **Toolchain Compatibility**: Ensures OpenAPI specs meet the expectations of external tooling.
- **Clean Artifact Generation**: Prevents accidental inclusion of Insomnia-specific metadata.
- **Separation of Concerns**: Maintains Insomnia’s benefits for development while supporting clean downstream publishing.

### Risks

- **Metadata Discrepancy**: The exported spec may diverge from the active Insomnia spec if not regenerated consistently.
- **Added CI Step**: Requires managing additional files and workflow steps.
- **Identifier Dependence**: Requires accurate retrieval or referencing of the correct spec ID during export.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0190-use-inso-export-spec-for-clean-openapi-outputs-in-automation-workflows.md)
- [Inso CLI](https://developer.konghq.com/inso-cli/)
