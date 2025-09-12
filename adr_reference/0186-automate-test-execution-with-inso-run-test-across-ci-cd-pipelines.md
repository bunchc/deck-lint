# 186. Automate Test Execution with `inso run test` Across CI/CD Pipelines

Date: 2025-06-12

## Tags

inso, testing, ci-cd, automation, api-quality, insomnia, test-suites, validation

## Status

Accepted

Used by [187. Use `inso export spec` for Clean OpenAPI Outputs in Automation Workflows](0187-use-inso-export-spec-for-clean-openapi-outputs-in-automation-workflows.md)

Uses [185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`](0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)
Uses [184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines](0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)

## Context

Effective API quality assurance requires not only structural validation (linting) but also functional verification across environments. While Insomnia enables local test execution via its UI, teams need **automated test suites** executed in CI to validate API behavior consistently during the delivery pipeline.

The `inso run test` command leverages Insomnia’s test suite definitions to execute functional tests directly in the terminal or CI environment, supporting environment selection, test name filtering, and fail-on-first mechanisms.

## Decision

Require use of `inso run test` in CI pipelines to execute API test suites defined in Insomnia.

Key practices include:

- Run `inso run test` after the linting step in CI jobs.
- Specify environment or suite identifiers explicitly.
- Ensure test failures cause the pipeline to fail, enforcing functional validation.
- Optionally use flags like `--testNamePattern` or `--keepFile` for targeted or debuggable runs.

Example GitHub Actions step:

```yaml
- name: Run API Tests
  run: inso run test "Accounts Test Suite" --env "OpenAPI env localhost:8081"
```

## Consequences

### Positive Outcomes

- **Functional Validation**: Ensures APIs work as designed, not just structured correctly.
- **Continuous Quality**: Detects regressions early in the delivery pipeline.
- **Traceability**: Test execution logs become part of CI history.
- **Reusable Assets**: Leveraging existing Insomnia test suites avoids duplication.

### Risks

- **Environmental Flakiness**: Tests may fail due to environment misconfiguration or backend availability.
- **Performance Overhead**: Running full test suites increases CI job duration.
- **Maintenance Burden**: Tests must be updated alongside spec or test logic changes.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0186-automate-test-execution-with-inso-run-test-across-ci-cd-pipelines.md)
- [Inso CLI](https://developer.konghq.com/inso-cli/)
- [Automate tests in Insomnia](https://developer.konghq.com/how-to/automate-tests/)
