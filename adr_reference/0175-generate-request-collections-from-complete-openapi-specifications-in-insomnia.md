# 175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia

Date: 2025-06-12

## Tags

insomnia, openapi, collections, api-design, automation, documentation, request-generation

## Status

Accepted

Used by [176. Apply After-Response Scripts to Dynamically Capture and Store Runtime Data](0176-apply-after-response-scripts-to-dynamically-capture-and-store-runtime-data.md)
Used by [177. Use Pre-Request Scripts to Automate Data Setup Across Related Requests](0177-use-pre-request-scripts-to-automate-data-setup-across-related-requests.md)
Used by [178. Use Structured Test Suites in Insomnia for API Verification](0178-use-structured-test-suites-in-insomnia-for-api-verification.md)
Used by [180. Manually Add and Script Requests for Newly Introduced Endpoints](0180-manually-add-and-script-requests-for-newly-introduced-endpoints.md)

Uses [174. Adopt Template Repositories for Standardized API Bootstrapping](0174-adopt-template-repositories-for-standardized-api-bootstrapping.md)

## Context

Insomnia supports generating a fully structured request collection directly from an OpenAPI specification. This feature is most effective when the OpenAPI spec includes:

- Proper operation tags
- Parameter and requestBody definitions
- Example values
- Response schemas and codes

When these elements are well-defined, Insomnia can produce a comprehensive, grouped set of requests that reflect the intended structure and usage of the API. This eliminates the need for manual request creation, accelerates test and exploration workflows, and ensures consistency between documentation and execution.

## Decision

Adopt the practice of generating request collections from finalized or near-complete OpenAPI specifications in Insomnia. To ensure maximum utility:

- API specs must define operation tags to group requests logically.
- Parameters, request bodies, and example payloads must be populated.
- Response schemas should be included where possible to support validation.

This step should be included in the API design workflow once the spec reaches an internally agreed draft state, prior to testing or review.

## Consequences

### Positive Outcomes

- **Speed**: Saves time compared to manual request entry.
- **Accuracy**: Generated requests mirror the actual spec structure.
- **Standardization**: Promotes consistent grouping and formatting across teams.
- **Tooling Integration**: Supports downstream automation (e.g., scripting, testing).

### Risks

- **Spec Dependency**: Low-quality or incomplete specs lead to poor collection output.
- **Overwrites**: Re-generating collections can unintentionally overwrite manual edits.
- **Misalignment**: Changes to the spec post-generation require regen or manual update.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)
- [Generate a collection from a design document](https://developer.konghq.com/how-to/generate-a-collection-from-a-design-document/)
- [Collections in Insomnia](https://developer.konghq.com/insomnia/collections/)
- [Use the Collection Runner in Insomnia](https://developer.konghq.com/how-to/use-the-collection-runner/)
