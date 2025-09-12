# 42. Enable Contract-First Development with Mocking and Testing

Date: 2025-04-22

## Tags

kong, api, gateway

## Status

Accepted

## Context

Waiting for APIs to be implemented delays frontend and client teams. Contract-first development and mocking accelerates collaboration.

## Decision

Adopt a contract-first approach:

- Define APIs first via OpenAPI or AsyncAPI specifications.
- Use mocking servers for early integration testing.
- Validate API contracts during CI/CD pipelines.

## Consequences

### Positive

- Parallelizes frontend/backend development.
- Catches API design issues earlier in the lifecycle.

### Risks

- Requires discipline to update contracts and mocks during iteration.
- Contract drift risk if mocks and real APIs are not aligned.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0042-enable-contract-first-development-with-mocking-and-testing.md)
- [decK Documentation](https://docs.konghq.com/deck/latest/)
- [Kong Insomnia API Development](https://docs.konghq.com/gateway/latest/kong-enterprise/inso/)
