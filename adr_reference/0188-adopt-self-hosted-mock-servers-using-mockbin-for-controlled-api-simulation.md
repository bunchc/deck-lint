# 188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation

Date: 2025-06-12

## Tags

insomnia, mocking, mockbin, self-hosted, api-simulation, dev-environment, docker, testing, version-control

## Status

Accepted

Used by [189. Version Control and Reuse of Mock Server Configurations Across Services](0189-version-control-and-reuse-of-mock-server-configurations-across-services.md)
Used by [190. Integrate Mock Services into Docker Compose for Dependent Service Development](0190-integrate-mock-services-into-docker-compose-for-dependent-service-development.md)
Used by [191. Automate Mock Route Activation via Insomnia to Ensure Mockbin Readiness](0191-automate-mock-route-activation-via-insomnia-to-ensure-mockbin-readiness.md)
Used by [192. Version Control Mock Server Configurations in Git for Consistency](0192-version-control-mock-server-configurations-in-git-for-consistency.md)
Used by [193. Leverage Insomnia’s Mock Duplication to Share Mocks Across Dependent Services](0193-leverage-insomnia-s-mock-duplication-to-share-mocks-across-dependent-services.md)
Used by [194. Coordinate Mock and Consumer Service Versioning for Inline Testing](0194-coordinate-mock-and-consumer-service-versioning-for-inline-testing.md)

Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

API mocking enables parallel development by simulating upstream services before they are fully implemented. While Insomnia provides cloud-based mocks for convenience, enterprise environments often require enhanced control, security, and traceability.

Self-hosted mocking in Insomnia uses Kong's `Mockbin` service, deployable via Docker. This approach ensures mocks can be:

- Persisted under version control
- Reproduced across development environments
- Hosted securely within an organization’s infrastructure
- Operated offline when internet access is restricted

## Decision

We will use **self-hosted mock servers** powered by `Mockbin` to simulate upstream APIs during local and pre-integration development.

Key implementation decisions:

- The mock configuration will be stored in Insomnia projects and committed to Git.
- Docker Compose will orchestrate `Mockbin` alongside any consumer services.
- The mock’s behavior will be defined using captured live requests.
- Redis will back `Mockbin` for persistence, and port 8080 will expose the mock API.

## Consequences

### Positive Outcomes

- **Parallel development**: Backend and dependent services can proceed independently.
- **Stability**: Mocks offer predictable, replayable responses during early-stage development.
- **Security**: Avoids reliance on public mocks; supports offline development.
- **Traceability**: All mock configuration and routes are versioned with the code.

### Risks and Limitations

- **Drift risk**: Mock responses may become outdated if the live API changes.
- **Initial setup overhead**: Requires local Docker, Redis, and proper environment setup.
- **Manual activation**: Mockbin must be initialized through Insomnia’s "Test" button.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0188-adopt-self-hosted-mock-servers-using-mockbin.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
- [Mockbin GitHub Repository](https://github.com/Kong/insomnia-mockbin)
