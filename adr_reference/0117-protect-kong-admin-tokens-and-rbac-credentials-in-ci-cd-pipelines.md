# 117. Protect Kong Admin Tokens and RBAC Credentials in CI/CD Pipelines

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, rbac, admin-api, ci-cd, secrets, automation, devsecops, least-privilege

## Status

Accepted

## Context

Kong’s Admin API is protected by Role-Based Access Control (RBAC), which uses RBAC tokens or credentials to authenticate users and automation systems. These credentials are highly sensitive, as they permit configuration of routes, services, plugins, consumers, and secrets within the gateway.

In CI/CD pipelines and automation scripts, these tokens are often required to perform tasks such as:

- Applying declarative configuration
- Deploying new APIs
- Managing credentials or plugin configuration

Improper storage or handling of RBAC tokens poses serious security risks, including privilege escalation, full API access, or malicious tampering.

## Decision

Use secure secrets management to store and retrieve Kong Admin tokens and RBAC credentials in all automation and CI/CD processes.

### Implementation Guidelines

#### 1. Store Credentials in Secure Vaults

Avoid hardcoding tokens in:

- Source code repositories
- CI/CD configuration files
- Plaintext environment variables

Instead, store them in secure locations such as:

- HashiCorp Vault
- AWS Secrets Manager
- Azure Key Vault
- GCP Secret Manager
- GitHub Actions secrets
- GitLab CI variables (masked/protected)

#### 2. Inject Secrets Dynamically into Build Environments

Configure your CI/CD system to securely inject tokens at runtime:

```yaml
# GitHub Actions example
env:
  KONG_ADMIN_TOKEN: ${{ secrets.KONG_ADMIN_TOKEN }}
```

Ensure the token has minimal privileges needed to perform the pipeline task.

#### 3. Rotate Tokens Periodically

- Issue short-lived tokens for automation
- Use Kong’s RBAC token API to automate rotation
- Avoid reusing personal admin tokens in automation

#### 4. Use Distinct Service Accounts per Environment

Create separate RBAC users or service accounts for:

- Dev, staging, prod environments
- Individual pipeline jobs or systems

Apply RBAC roles with the principle of least privilege:

- `read-only`, `admin`, `workspace-admin`, etc.

#### 5. Audit and Revoke Unused Tokens

Regularly review and remove:

- Tokens no longer used
- Overprivileged roles
- Automation tokens exposed in CI/CD logs or artifacts

## Consequences

### Positive Outcomes

- Prevents credential leaks and unauthorized access
- Enables secure automation across environments
- Aligns with DevSecOps and least-privilege principles
- Supports auditability of automated configuration changes

### Risks and Trade-offs

- Slight operational complexity to manage vault integration
- Potential for automation failure if secrets are unavailable or rotated without syncing

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0117-protect-kong-admin-tokens-and-rbac-credentials-in-ci-cd-pipelines.md)

- [Reset Passwords and RBAC Tokens in Kong Manager](https://docs.konghq.com/gateway/latest/kong-manager/auth/reset-password/#main)
