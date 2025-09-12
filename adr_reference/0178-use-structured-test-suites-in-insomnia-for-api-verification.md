# 178. Use Structured Test Suites in Insomnia for API Verification

Date: 2025-06-12

## Tags

insomnia, testing, test-suites, automation, validation, api-quality, verification

## Status

Accepted

Used by [179. Link Tests to API Requests to Enable Automated Validation](0179-link-tests-to-api-requests-to-enable-automated-validation.md)
Used by [184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines](0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)

Uses [175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia](0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)

## Context

As API designs mature, it's necessary to validate not only functional behavior but also response structure and conformance. Insomnia provides built-in support for structured **Test Suites**, enabling users to write and organize JavaScript-based assertions against individual requests. This feature allows teams to create reusable, version-controlled tests that run locally or in CI environments.

Prior to test suites, users commonly relied on manual validation or ad-hoc response checks, which are error-prone and hard to scale.

## Decision

Mandate the use of **Test Suites** in Insomnia to verify API behavior and structure. Each API project must:

- Define at least one test suite (e.g., `Accounts API Test Suite`)
- Group functional and structural tests within this suite
- Use test scripts to assert status codes, response fields, and types

These test suites should evolve with the API spec and serve as a reusable contract validation mechanism during development.

## Consequences

### Positive Outcomes

- **Repeatability**: Automated tests can be run consistently across environments.
- **Validation**: Ensure that APIs meet expected behavior, schema, and status codes.
- **Governance**: Supports QA, compliance, and review workflows.
- **Documentation**: Test suites act as living examples of intended usage and response format.

### Risks

- **Maintenance**: Tests must be updated in sync with spec changes.
- **Incomplete Coverage**: Relying only on Insomnia tests may miss edge cases unless supplemented.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0178-use-structured-test-suites-in-insomnia-for-api-verification.md)
- [Test APIs with Insomnia](https://developer.konghq.com/insomnia/test/)
