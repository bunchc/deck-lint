# 179. Link Tests to API Requests to Enable Automated Validation

Date: 2025-06-12

## Tags

insomnia, testing, test-linkage, request-validation, test-coverage, api-validation

## Status

Accepted

Used by [180. Manually Add and Script Requests for Newly Introduced Endpoints](0180-manually-add-and-script-requests-for-newly-introduced-endpoints.md)
Used by [181. Create Tests for Future or Unimplemented Endpoints as Placeholders](0181-create-tests-for-future-or-unimplemented-endpoints-as-placeholders.md)

Uses [178. Use Structured Test Suites in Insomnia for API Verification](0178-use-structured-test-suites-in-insomnia-for-api-verification.md)

## Context

In Insomnia, each test case can be directly assigned to a specific API request. This linkage provides clear traceability between the test and its target, supports per-endpoint validation, and improves visibility in debugging workflows.

Without explicit assignment, test execution becomes unstructured, and it is harder to reason about failures or test gaps. Tightly coupling tests to requests reinforces test coverage and aligns with the principles of behavior-driven API design.

## Decision

Enforce the practice of assigning each Insomnia test to its corresponding API request. For each functional test:

- Select the appropriate request from the collection.
- Use `insomnia.send()` to execute the request.
- Validate response code, body structure, and critical fields.

This ensures tests are scoped and maintainable, and makes it easier to reason about which operations are covered.

## Consequences

### Positive Outcomes

- **Traceability**: Clear mapping from each test to its related request.
- **Coverage Analysis**: Gaps are easier to detect visually and logically.
- **Modularity**: Individual tests can be updated alongside their respective endpoints.

### Risks

- **Refactor Overhead**: Renaming or reorganizing requests may break test links.
- **Duplication**: Tests that span multiple endpoints may need to be duplicated or referenced carefully.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0179-link-tests-to-api-requests-to-enable-automated-validation.md)
- [Test APIs with Insomnia](https://developer.konghq.com/insomnia/test/)
