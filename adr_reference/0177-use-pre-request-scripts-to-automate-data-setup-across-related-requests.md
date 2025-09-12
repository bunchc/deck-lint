# 177. Use Pre-Request Scripts to Automate Data Setup Across Related Requests

Date: 2025-06-12

## Tags

insomnia, scripting, pre-request, automation, data-setup, test-dependencies, api-testing

## Status

Accepted

Uses [176. Apply After-Response Scripts to Dynamically Capture and Store Runtime Data](0176-apply-after-response-scripts-to-dynamically-capture-and-store-runtime-data.md)  
Uses [175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia](0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)

## Context

In many API workflows, certain requests depend on prerequisite data—such as a valid `accountId` for credit or debit operations. Insomnia supports **pre-request scripts**, which run before the main request is executed. These scripts can be used to dynamically check for required values in the environment and create missing resources on-the-fly.

This ensures that each request is self-sufficient and can be executed in isolation without prior manual setup, which is especially useful in automated test flows or dynamic environments.

## Decision

Standardize the use of **pre-request scripts** to manage dependencies by creating test data as needed. For example, before executing a credit or debit request:

- Check if `accountId` is defined in the environment.
- If not, issue a `POST /accounts` request to create a new account.
- Store the resulting `account_id` in the environment for reuse.

Example:

```javascript
if (!insomnia.environment.get("accountId")) {
  const host = insomnia.environment.get("host");
  const scheme = insomnia.environment.get("scheme");
  const baseUrl = `${scheme}://${host}`;

  const createAccountRequest = {
    url: `${baseUrl}/accounts`,
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: {
      mode: "raw",
      raw: JSON.stringify({ type: "savings", initial_balance: 5000.0 }),
    },
  };

  const response = await new Promise((resolve, reject) => {
    insomnia.sendRequest(createAccountRequest, (err, resp) => {
      if (err) reject(err);
      else resolve(resp);
    });
  });

  if (response.code !== 201) {
    throw new Error(`Account creation failed. Status code: ${response.code}`);
  }

  const responseBody = JSON.parse(response.body.toString());
  insomnia.environment.set("accountId", responseBody.account_id);
}
```

This technique should be applied to all requests that have clear test data prerequisites.

## Consequences

### Positive Outcomes

- **Self-Contained Requests**: Requests become repeatable and don’t rely on external state.
- **Improved Automation**: Enables batch and CI execution without manual preparation.
- **Error Reduction**: Minimizes failure from missing test data.
- **Consistency**: All consumers of the collection follow the same setup logic.

### Risks

- **Complexity**: Script logic must be maintained alongside request definitions.
- **Debug Overhead**: Failures may be harder to trace due to nested logic in pre-request execution.
- **Unintended Side Effects**: Scripts may create duplicate or stale data if not carefully written.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0177-use-pre-request-scripts-to-automate-data-setup-across-related-requests.md)
- [Write pre-request scripts to add dynamic behavior in Insomnia](https://developer.konghq.com/how-to/write-pre-request-scripts/)
- [Test APIs with Insomnia](https://developer.konghq.com/insomnia/test/)
