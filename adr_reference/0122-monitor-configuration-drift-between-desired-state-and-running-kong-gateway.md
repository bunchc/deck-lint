# 122. Enforce Configuration Consistency and Policy-as-Code Validation for Kong Gateway

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, deployment, monitoring, gitops, configuration-as-code, policy-as-code, drift-detection, opa, conftest, automation, compliance

## Status

Proposed

Governs [103. Use Secrets Management for Sensitive Configuration](0103-use-secrets-management-for-sensitive-configuration.md)

## Context

Kong Gateway configurations — services, routes, plugins, consumers — are often managed by multiple teams, automated pipelines, and manual Admin API operations.  
Without validation and drift detection mechanisms:

- Unauthorized or accidental changes may be introduced.
- Drift between GitOps-configured desired state and live gateway state can occur.
- Security baselines (e.g., authentication requirements, rate limits) may be violated.

Implementing Configuration Drift Detection and Policy-as-Code (PaC) validation ensures consistency, security, and auditability across all Kong environments.

## Decision

Mandate GitOps-based declarative configuration enforcement, combined with Policy-as-Code validation before deployment and periodic drift detection against live Kong Gateway instances.

### Implementation Guidelines

#### 1. Adopt GitOps for Declarative Configuration Management

- Manage Kong configurations (services, routes, plugins) as code (e.g., `kong.yaml`) in version-controlled Git repositories.
- Use decK (`deck gateway sync`) to apply declarative configs to Kong.
- All changes to Kong must go through Pull Request reviews and CI validations.

#### 2. Implement Policy-as-Code Validation Pre-Deployment

Use Open Policy Agent (OPA) + Conftest to validate configurations:

- Enforce security policies (e.g., all public routes must have authentication plugins).
- Validate timeouts, retries, and error handling policies.
- Check for required tags (team ownership, environment labels).

Example validation pipeline:

```bash
deck gateway dump > kong.yaml
conftest test kong.yaml
```

Block merges if policy violations are detected.

#### 3. Periodically Detect and Report Configuration Drift

Schedule periodic checks:

- Use `deck gateway diff` to compare live Kong state against the GitOps source of truth.
- Alert if drift is detected (e.g., unauthorized manual Admin API changes).

Example:

```bash
deck gateway diff --workspace default
```

Drift detection jobs can be run daily or weekly depending on change velocity.

#### 4. Establish Drift Remediation Processes

If drift is detected:

- Investigate the source of drift (e.g., emergency manual change).
- Open PRs to reconcile drift — either accept live changes into Git, or revert to desired state.
- Implement stricter access controls if recurring drift is detected.

Document all drift findings and resolutions.

#### 5. Harden Kong Admin API to Reduce Manual Changes

- Restrict Admin API access via IP allowlists, mTLS, or strong RBAC.
- Enforce read-only Admin API access for non-platform users where possible.

Minimize the surface area for unauthorized live configuration changes.

## Consequences

### Positive Outcomes

- Strong configuration consistency across Kong clusters
- Automated enforcement of security, observability, and architectural best practices
- Faster detection and remediation of unauthorized changes
- Easier auditability and compliance reporting

### Risks and Trade-offs

- Initial setup effort for policy libraries and validation pipelines
- Possible friction during onboarding new teams to GitOps + PaC processes
- Requires monitoring to detect failures in validation or drift detection jobs

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0122-monitor-configuration-drift-between-desired-state-and-running-kong-gateway.md)

- [decK Declarative Configuration Management](https://docs.konghq.com/deck/latest/)
- [Open Policy Agent (OPA)](https://www.openpolicyagent.org/)
- [Conftest for Policy Testing](https://www.conftest.dev/)
