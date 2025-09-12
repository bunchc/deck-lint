# 194. Coordinate Mock and Consumer Service Versioning for Inline Testing

Date: 2025‑06‑12

## Tags

mocking, versioning, api-version, compatibility, testing, insomnia, mockbin, service-contract

## Status

Accepted

Uses [189. Version Control and Reuse of Mock Server Configurations Across Services](0189-version-control-and-reuse-of-mock-server-configurations-across-services.md)
Uses [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)

## Context

Mocks and dependent (consumer) services share contract dependencies: changes in mock behavior—such as endpoints, payload structures, or response codes—must align with the consumer’s expectations. Without coordination, mismatches can cause subtle test and integration failures. Treating mocks as versioned artifacts allows clear traceability between mock versions and consumer service releases.

## Decision

Establish a version alignment strategy when developing mocks alongside consumer services:

1. **Mock Versioning**

   - Tag commits in mock-providing repos (e.g., `accounts-service`) when significant mock changes occur.
   - Annotate mock configurations with semver style tags (e.g., `v1.2.0`) describing contract level changes.

2. **Consumer Integration**

   - Consumer services (e.g., `transactions-service`) reference mock configurations by version.
   - Use Git submodules, tag references, or documented hashes to ensure each consumer is tested against the intended mock version.

3. **CI and Deployment**

   - Document intended mock versions in consumer repositories.
   - Ensure CI pipelines use the correct mock version, reflecting the current contract expectations.

## Consequences

### Positive Outcomes

- **Compatibility Assurance**: Prevents mismatches between mock expectations and consumer implementations.
- **Traceability**: Each mock–consumer pairing is recorded, facilitating debugging and audits.
- **Collaboration Clarity**: Teams clearly understand which mock version is in use.

### Risks

- **Process Complexity**: Adds extra steps to tagging mock commits and updating consumer references.
- **Overhead**: Requires synchronization processes across multiple repos.
- **Staleness Risk**: Consumers might fail to update mock versions when breaking changes occur.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0196-coordinate-mock-and-consumer-service-versioning-for-inline-testing.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
- [Mockbin GitHub Repository](https://github.com/Kong/insomnia-mockbin)
