# 190. Integrate Mock Services into Docker Compose for Dependent Service Development

Date: 2025‑06‑12

## Tags

insomnia, mocking, docker-compose, dev-environment, mocking-integration, transactions-service, accounts-service, mockbin

## Status

Accepted

Uses [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)

## Context

Dependent services often face delays when upstream services are unavailable or evolving. Mock servers provide contract-based interfaces that enable front-end development to proceed. However, manual startup of mocks and services can be cumbersome. Integrating mock services into Docker Compose ensures consistent, reproducible development environments.

Imagine a scenario in which the `transactions-service` is configured to connect to a mockbed instance of the `accounts-service`, along with additional infrastructure like Redis and Vault, all orchestrated via Docker Compose. This supports local development without the need to run multiple services manually.

## Decision

Include mock services in Docker Compose configurations for local development of dependent services. Key aspects include:

- Add a service (Mockbin + Redis) to `docker-compose.yaml`.
- Ensure dependent services reference the mock via environment variables.
- Include additional dependencies (like Redis or Vault) required by mocks or services.
- Update team documentation and environment templates to reflect this setup.

## Consequences

### Positive Outcomes

- **Development Efficiency**: Developers can spin up full local stacks easily.
- **Consistency**: Everyone works with the same versions and service topology.
- **Mock Reliability**: Mocks are deployed in an isolated environment with controlled state.

### Risks and Limitations

- **Complex Configures**: Compose files can grow bulky with multiple dependencies.
- **Environment Drift**: Differences between mock and real services may go unnoticed.
- **Secret Exposure**: Care must be taken when secrets (like Vault tokens) are used in local Docker setups.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0190-integrate-mock-services-into-docker-compose-for-dependent-service-development.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
- [Mockbin GitHub Repository](https://github.com/Kong/insomnia-mockbin)
