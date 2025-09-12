# 121. Manage Kong Configuration as Code Using GitOps and Declarative Deployment

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, deployment, kubernetes, gitops, configuration-as-code, deck, ci-cd, automation, declarative, version-control

## Status

Accepted

## Context

Manual configuration of Kong services, routes, plugins, and credentials introduces risk, slows down deployments, and increases the chance of human error. As platform usage scales across teams and environments, centralized, repeatable, and auditable configuration practices are essential.

Kong supports declarative configuration via YAML files, which can be managed in source control and deployed automatically through CI/CD pipelines using tools like decK, Terraform, or GitOps operators.

## Decision

Adopt a GitOps-based workflow for managing Kong Gateway configuration as code using declarative YAML files.

### Implementation Guidelines

#### 1. Define Desired State in YAML

Use decK-compatible YAML files to describe Kong resources:

```yaml
_format_version: "3.0"
services:
  - name: billing-api
    url: https://billing.internal
    routes:
      - name: billing-v1
        paths:
          - /billing
plugins:
  - name: rate-limiting
    service: billing-api
    config:
      minute: 100
      policy: local
```

Store this in a version-controlled repository, structured by:

- Environment (`dev/`, `stage/`, `prod/`)
- Workspace (if using Kong Enterprise)
- API team ownership

#### 2. Automate Sync Using decK or GitOps

Run decK or GitOps controllers to sync desired state:

```bash
deck sync --workspace billing
```

Optionally run `deck diff` in pull requests to preview config changes.

In Kubernetes, consider:

- `deck sync` in CI/CD
- GitOps tooling (e.g., Argo CD, Flux)

#### 3. Validate Declarative Config Changes

Integrate into CI pipelines:

- `deck validate` for syntax
- `deck diff` for change previews
- Linting and security checks (e.g., rate limits, auth required)

#### 4. Apply Promotion Flows Between Environments

Use branch-based or tag-based promotion:

- Merge to `main` deploys to staging
- Tag `v1.2.0` deploys to production
- Use automation to sync config across Kong workspaces/environments

#### 5. Avoid Manual Drift

Use `deck dump` to detect changes made via Admin API:

```bash
deck diff --workspace billing
```

Disallow or audit manual changes in production environments.

## Consequences

### Positive Outcomes

- Enables repeatable, auditable, and automated configuration management
- Aligns Kong with modern platform engineering and GitOps practices
- Supports separation of duties and review-based deployments

### Risks and Trade-offs

- Requires CI/CD or GitOps infrastructure
- May not capture runtime metadata (e.g., analytics, consumer activity)
- Initial learning curve for decK and Git-based workflows

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0121-manage-kong-configuration-as-code-using-gitops-and-declarative-deployment.md)

- [Kong decK CLI](https://docs.konghq.com/deck/latest/)
