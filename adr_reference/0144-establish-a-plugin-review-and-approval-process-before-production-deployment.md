# 144. Establish a Plugin Review and Approval Process Before Production Deployment

Date: 2025-04-25

## Tags

kong, gateway, plugin, security, governance, review-process, compliance, risk-management, quality-assurance, production-readiness, plugin-approval

## Status

Accepted

## Context

Kong Gateway supports a large ecosystem of plugins, including:

- Official Kong plugins
- Partner and third-party plugins from the Kong Hub
- Custom in-house plugins developed by platform or product teams

Introducing new plugins (or modifying existing ones) without a review process can result in:

- Security vulnerabilities
- Performance degradation
- Operational instability
- Non-compliance with internal policies or external regulations

To maintain trust, security, and operational excellence, Kong deployments must adopt a structured plugin review and approval process before any plugin is deployed to production.

## Decision

Mandate a formal plugin intake, review, and approval workflow to control the adoption of new or updated Kong plugins in production environments.

### Implementation Guidelines

#### 1. Define Plugin Categories

Classify plugins into risk-based categories:

- **Tier 1**: Security-critical (e.g., authN/authZ, rate limiting)
- **Tier 2**: Performance-impacting (e.g., transformations, logging)
- **Tier 3**: Observability and non-critical (e.g., metrics, headers)

Apply stricter review criteria for Tier 1 and Tier 2 plugins.

#### 2. Establish a Review Checklist

Every new plugin proposal must include:

- Source repository and version
- License type (must be compatible with enterprise legal standards)
- Scope of functionality
- Configuration options and defaults
- Resource impact (CPU/memory consumption under load)
- Known vulnerabilities or CVEs (if public)
- Integration testing results with the current Kong version

Custom plugins must also pass:

- Static code analysis (e.g., Lua linters, secret scanning)
- Security review (e.g., untrusted input handling)
- Load and fault injection tests

#### 3. Implement a Formal Approval Workflow

Typical stages:

1. **Intake submission**: Developer or team proposes the plugin.
2. **Initial triage**: Platform team checks basic requirements.
3. **Technical review**: Platform SRE and security engineer assess code and performance.
4. **Compliance/legal review**: For licensing and third-party risks (if needed).
5. **Approval and publishing**: Add to curated plugin catalog or bundle.

Document approvals for auditability.

#### 4. Maintain a Curated Plugin Catalog

Maintain an internal, versioned plugin registry listing:

- Approved plugins
- Version compatibility with Kong
- Associated golden image builds

Use tagging (`approved`, `internal-use-only`, `deprecated`) for visibility.

#### 5. Audit and Reassess Periodically

- Re-audit plugins every 12–18 months or after major Kong upgrades.
- Remove deprecated or unsupported plugins from the catalog.
- Patch or upgrade plugins with known vulnerabilities.

#### 6. Communicate Clearly to Consumers

- Publish plugin usage guidelines and limitations
- Document fallback/migration plans for deprecated plugins
- Provide visibility into plugin SLAs (e.g., critical support windows)

## Consequences

### Positive Outcomes

- Improves platform security, stability, and reliability
- Reduces risk of introducing regressions or vulnerabilities into production
- Enhances transparency and auditability of plugin lifecycle management
- Encourages disciplined plugin development and adoption

### Risks and Trade-offs

- Adds initial friction and delay when introducing new plugins
- Requires time commitment from platform, security, and compliance teams
- Potential resistance from fast-moving development teams (needs communication and support)

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0144-establish-a-plugin-review-and-approval-process-before-production-deployment.md)

- [Developing Plugins for Kong Gateway](https://docs.konghq.com/gateway/latest/plugin-development/)
- [Kong Partner Plugins and Kong Hub](https://docs.konghq.com/hub/)
