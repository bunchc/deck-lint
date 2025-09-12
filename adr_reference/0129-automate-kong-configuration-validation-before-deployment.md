# 129. Automate Kong Configuration Validation Before Deployment

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, deployment, validation, ci-cd, automation, deck, policy-as-code, compliance, gitops

## Status

Accepted

## Context

Manual misconfiguration of Kong services, routes, plugins, or consumers can introduce runtime errors, security vulnerabilities, and operational instability. As Kong deployments scale across multiple environments, teams, and services, relying on human validation alone becomes risky and inefficient.

Automating configuration validation before deployment helps catch errors early, ensures platform standards are consistently enforced, and improves the reliability of Kong as part of the broader CI/CD ecosystem.

## Decision

Integrate Kong configuration validation into CI/CD pipelines and enforce strict validation of all declarative or Admin API-driven changes before applying them to staging or production environments.

### Implementation Guidelines

#### 1. Use `deck gateway validate` for Syntax and Structural Checks

Before syncing declarative configuration with Kong, validate the YAML or JSON files:

```bash
deck gateway validate --workspace billing
```

This checks for:

- Syntax errors
- Unsupported fields
- Schema violations

Fail the pipeline if validation fails.

#### 2. Use `deck gateway diff` for Change Impact Review

Compare intended changes against the live Kong cluster:

```bash
deck gateway diff --workspace billing
```

Require human approval for significant diffs (e.g., service deletions, plugin disabling).

#### 3. Implement CI/CD Pipeline Enforcement

Integrate validation into pull requests or merge workflows:

- GitHub Actions
- GitLab CI
- Jenkins
- Argo CD pre-sync hooks

Example GitHub Action:

```yaml
- name: Validate Kong Configuration
  run: deck gateway validate --workspace ${{ env.WORKSPACE }}
```

#### 4. Apply Policy-as-Code for Compliance

Use tools like OPA/Gatekeeper to enforce:

- Required authentication on public routes
- Rate limits on critical APIs
- Disallow dangerous plugins (e.g., `basic-auth` without SSL)

Validate declarative configurations against custom admission rules before deployment.

#### 5. Visualize Validation Results

Surface validation errors in:

- Pull request comments
- CI job logs
- Deployment dashboards

Provide clear feedback loops to developers and platform teams.

## Consequences

### Positive Outcomes

- Catch errors and policy violations early before impacting production
- Improves platform reliability and operational confidence
- Enforces secure, compliant, and standardized API deployments
- Reduces incident frequency related to misconfiguration

### Risks and Trade-offs

- Initial pipeline setup and maintenance effort
- Potential for "false positives" requiring tuning of validation rules
- Requires developer education to interpret validation errors properly

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0129-automate-kong-configuration-validation-before-deployment.md)

- [decK Validation Command](https://docs.konghq.com/deck/gateway/validate/)
- [decK Diff Command](https://docs.konghq.com/deck/gateway/diff/)
- [GitOps and Kong Best Practices](https://docs.konghq.com/deck/apiops/)
