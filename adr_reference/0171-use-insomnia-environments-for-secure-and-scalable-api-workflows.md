# 171. Use Insomnia Environments for Secure and Scalable API Workflows

Date: 2025-06-12

## Tags

insomnia, environments, configuration-management, secrets, api-workflows, dev-staging-prod, collaboration, reuse

## Status

Accepted

Used by [195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration](0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)
Used by [197. Standardize Credential Configuration for External Vault Providers in Insomnia](0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)
Used by [198. Reference Secrets from External Vaults in Insomnia API Environments](0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)
Used by [199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows](0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)

Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

Hardcoding API configuration (such as URLs, tokens, and credentials) into individual requests introduces risks and limits flexibility. Managing API workflows across multiple stages—development, staging, and production—requires a system that supports reuse, security, and consistency.

Insomnia’s **environment** feature offers a scalable solution. It allows variables to be defined once and reused dynamically across API requests, test suites, and specifications. Insomnia environments include both **shared** (team-synced) and **private** (local-only) scopes, supporting collaboration and security needs.

## Decision

Mandate the use of **Insomnia environments** for all Kong Gateway API development and testing workflows. This includes:

- Defining environment variables for base URLs, API tokens, and common parameters.
- Structuring projects with:

  - **Base environments** for global defaults.
  - **Sub-environments** for `local-dev`, `staging`, and `production`.

- Using **shared environments** for consistent team workflows.
- Using **private environments** for sensitive data or local-only configurations.
- Customizing and renaming any environments auto-generated from OpenAPI imports.

### How Environments Are Used

Typical uses of environments in Insomnia include:

- Defining API base URLs (`{{ base_url }}`) to avoid hardcoded endpoints.
- Setting authentication tokens (`{{ api_key }}`) for secured requests.
- Managing credentials and configuration for different deployment stages.
- Parameterizing requests with values like region, version, or user roles.

Example:

```json
{
  "base_url": "http://localhost:8081",
  "api_key": "super-secret-key"
}
```

Then used in a request as:

```yaml
GET {{ base_url }}/accounts
Authorization: Bearer {{ api_key }}
```

#### Automatic Environment Generation from OpenAPI Specs

When importing an OpenAPI spec that includes a `servers` block, Insomnia automatically creates an environment based on the first server URL. For example:

```yaml
servers:
  - url: http://localhost:8081
    description: Local development server
```

Generates:

```json
{
  "scheme": "http",
  "host": "localhost:8081",
  "base_path": ""
}
```

**Best Practice**: Always review, rename, and tailor auto-generated environments to fit your project’s structure and naming conventions.

## Consequences

### Positive Outcomes

- **Configuration Reusability**: Requests become cleaner and easier to maintain.
- **Environment Switching**: Teams can test across dev/staging/prod instantly via UI.
- **Security**: Reduces accidental exposure of secrets; supports separation of sensitive values.
- **Team Collaboration**: Shared environments ensure consistency across environments and users.

### Risks

- **Misuse of Shared Environments**: Storing secrets in shared environments can pose a security risk.
- **Initial Learning Curve**: Teams unfamiliar with environments may require guidance and onboarding.
- **Environment Drift**: Without governance, sub-environments can diverge or go stale.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0171-use-insomnia-environments-for-secure-and-scalable-api-workflows.md)
- [Environment variables](https://developer.konghq.com/insomnia/environment-variables/)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
