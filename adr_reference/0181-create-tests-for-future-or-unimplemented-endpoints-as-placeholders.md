# 181. Create Tests for Future or Unimplemented Endpoints as Placeholders

Date: 2025-06-12

## Tags

testing, placeholders, api-contracts, insomnia, test-driven-design, api-versioning, planning

## Status

Accepted

Uses [180. Manually Add and Script Requests for Newly Introduced Endpoints](0180-manually-add-and-script-requests-for-newly-introduced-endpoints.md)
Uses [179. Link Tests to API Requests to Enable Automated Validation](0179-link-tests-to-api-requests-to-enable-automated-validation.md)

## Context

In the API design lifecycle, it is common to define operations before they are implemented in the backend. Insomnia allows writing tests even for endpoints that do not yet return successful responses.

Writing such tests early serves as a form of **test-driven design**, helping document expected behavior and ensuring that backend implementation adheres to the contract. For example, creating a test that expects a `204 No Content` response for a `DELETE` operation—even if it currently fails—signals future requirements to the development team.

## Decision

Encourage teams to **define test cases for unimplemented endpoints** as placeholders. These tests should:

- Reflect the intended behavior (e.g., status code, response body).
- Be committed and versioned along with the spec.
- Include documentation or annotations to explain why the test may currently fail.

This promotes early validation, reduces ambiguity, and ensures readiness once the backend is complete.

## Consequences

### Positive Outcomes

- **Forward Planning**: Teams align on API behavior before implementation.
- **Developer Signal**: Backend teams get early visibility into expectations.
- **Spec-Test Sync**: Maintains consistency between API contract and validation logic.

### Risks

- **Test Failures**: Placeholder tests will initially fail and may be confusing if not clearly labeled.
- **Noise**: CI systems may need filtering or conditional logic to ignore known failing tests.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0181-create-tests-for-future-or-unimplemented-endpoints-as-placeholders.md)
- [Test APIs with Insomnia](https://developer.konghq.com/insomnia/test/)
