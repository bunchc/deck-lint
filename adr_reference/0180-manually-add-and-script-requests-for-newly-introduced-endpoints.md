# 180. Manually Add and Script Requests for Newly Introduced Endpoints

Date: 2025-06-12

## Tags

insomnia, request-generation, manual-entry, endpoint-extension, scripting, delete-endpoint

## Status

Accepted

Used by [181. Create Tests for Future or Unimplemented Endpoints as Placeholders](0181-create-tests-for-future-or-unimplemented-endpoints-as-placeholders.md)

Uses [179. Link Tests to API Requests to Enable Automated Validation](0179-link-tests-to-api-requests-to-enable-automated-validation.md)
Uses [175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia](0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)

## Context

Insomnia can generate requests from OpenAPI specs, but it does not automatically update the collection when new operations are added. This gap is common when evolving the API spec (e.g., adding a new `DELETE /accounts/{accountId}` endpoint). Without regeneration, newly added endpoints must be manually represented in the request collection.

To avoid waiting on regeneration and preserve existing customizations, teams should manually create these requests and include any pre/post scripts as required.

## Decision

Permit and encourage **manual creation of HTTP requests** in Insomnia for newly added or evolving endpoints. For each new endpoint not present in the current collection:

- Manually create the HTTP request.
- Add it to the appropriate group within the collection.
- Apply any relevant pre-request or after-response scripts.
- Update environments to ensure correct path and variable references.

This approach preserves progress and supports agile API iteration without disrupting existing workflows.

## Consequences

### Positive Outcomes

- **Agility**: Allows development and testing of new endpoints without waiting for full collection regeneration.
- **Customization**: Avoids loss of edits or scripts in existing requests.
- **Continuity**: Test coverage can continue even if spec implementation is incomplete.

### Risks

- **Inconsistency**: Manual additions may diverge from regenerated structure.
- **Duplication**: Re-generating later may create overlapping requests if not carefully managed.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0180-manually-add-and-script-requests-for-newly-introduced-endpoints.md)
- [Test APIs with Insomnia](https://developer.konghq.com/insomnia/test/)
