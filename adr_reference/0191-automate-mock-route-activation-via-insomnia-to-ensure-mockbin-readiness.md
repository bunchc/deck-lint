# 191. Automate Mock Route Activation via Insomnia to Ensure Mockbin Readiness

Date: 2025‑06‑12

## Tags

insomnia, mocking, mockbin, automation, workflow, initialization, version-control, local-dev

## Status

Accepted

Uses [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)

## Context

After setting up a self-hosted mock server with Mockbin, routes must be explicitly activated by sending recorded requests through Insomnia’s Mock interface. This manual process can be overlooked, resulting in empty mocks and confusing failures when dependent services attempt to interact with the mock.

To ensure consistent initialization and to reduce developer friction, it's recommended to automate mock route activation through standardized workflows.

## Decision

Require all mock route configurations to include an **initial route activation step** as part of the Insomnia project setup. This can be achieved by:

1. Defining a clear step in documentation or onboarding guides (e.g. "Click ‘Test’ for each mock route").
2. Optionally scripting route activation via Inso CLI or HTTP calls to Mockbin API.
3. Ensuring a generic test request (e.g., HEAD or GET) is present post-configuration to validate active mock routes.

Mock activation steps should be:

- Included in README or setup documentation.
- Captured as part of developer checklists or scripts.
- Verified in CI, if mock activation is critical for test suites.

## Consequences

### Positive Outcomes

- **Reliability**: Mock servers consistently return expected responses without manual activation steps missed.
- **Onboarding Clarity**: New developers have clear direction during environment setup.
- **Test Readiness**: Dependent services can run against mocks confidently after startup.

### Risks and Limitations

- **Additional Steps**: May introduce complexity if not standardized properly.
- **Scripting Overhead**: Integrating mock activation into automation may require custom tooling.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0191-automate-mock-route-activation-insomnia.md)
- [Insomnia Mocking Docs](https://developer.konghq.com/insomnia/mock-servers/)
