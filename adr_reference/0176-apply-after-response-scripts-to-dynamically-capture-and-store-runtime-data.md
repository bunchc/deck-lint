# 176. Apply After-Response Scripts to Dynamically Capture and Store Runtime Data

Date: 2025-06-12

## Tags

insomnia, scripting, after-response, environment-variables, automation, chaining, api-testing

## Status

Accepted

Used by [177. Use Pre-Request Scripts to Automate Data Setup Across Related Requests](0177-use-pre-request-scripts-to-automate-data-setup-across-related-requests.md)

Uses [175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia](0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)

## Context

Insomnia supports lightweight JavaScript scripting that runs after a request has completed. These **after-response scripts** allow developers to extract values from the response body and dynamically update environment variables. This is particularly useful in scenarios where subsequent requests depend on data returned by earlier ones—such as storing an `accountId` after creating a new account.

This technique improves test automation and eliminates manual copy-paste workflows, supporting clean chaining of requests in environments such as banking APIs or microservices with resource dependencies.

## Decision

Require the use of **after-response scripts** to extract and persist runtime values needed for downstream API requests. Example use case:

- After creating a new account, extract `account_id` from the response and store it in the environment for use in credit, debit, or retrieval requests.

Example script:

```javascript
let data = insomnia.response.json();
insomnia.environment.set("accountId", data.account_id);
```

This decision applies to all workflows that depend on dynamic, response-driven variables.

## Consequences

### Positive Outcomes

- **Automation**: Reduces manual steps between related requests.
- **Accuracy**: Ensures correct and current values are reused across API operations.
- **Reusability**: Supports modular, environment-driven test suites.
- **Developer Efficiency**: Streamlines workflows and reduces human error.

### Risks

- **Runtime Dependency**: Requests that rely on prior response scripts may fail if execution order is disrupted.
- **Debugging Complexity**: Scripts introduce logic that must be tested and maintained.
- **Environment Pollution**: Poor script hygiene can lead to stale or conflicting variable values.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0176-apply-after-response-scripts-to-dynamically-capture-and-store-runtime-data.md)
- [Set a value from a response as an environment variable in Insomnia](https://developer.konghq.com/how-to/set-a-value-from-a-response-as-an-environment-variable/)
- [Test APIs with Insomnia](https://developer.konghq.com/insomnia/test/)
