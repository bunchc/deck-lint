# 113. Manage Sensitive Secrets Using Kong Vaults

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, secrets, secrets-management, vault, encryption, compliance, external-secrets

## Status

Accepted

Implemented by [103. Use Secrets Management for Sensitive Configuration](0103-use-secrets-management-for-sensitive-configuration.md)

## Context

Kong Gateway configuration often includes sensitive data such as credentials, API keys, client secrets, certificates, and tokens. Hardcoding these secrets in plain text within declarative configuration files, environment variables, or database fields presents significant security risks.

To address this, Kong Gateway Enterprise offers Vaults — a secure, extensible secret management framework that decouples secrets from configuration and supports integrations with external secret stores (e.g., HashiCorp Vault, AWS Secrets Manager, GCP Secret Manager, Azure Key Vault).

## Decision

Adopt Kong Vaults as the default method to manage sensitive values in Kong Gateway, both for security and operational flexibility.

### Implementation Guidelines

#### 1. Enable Kong Vaults

Enable Vault support via configuration:

```yaml
env:
  - name: KONG_VAULTS
    value: "env,awssecretsmanager,vault" # List only those needed
```

#### 2. Use Environment Vault (Recommended for Simplicity)

For quick wins, use `env` Vault to pull secrets from environment variables:

```yaml
vaults:
  env:
    config:
      prefix: KONG_SECRET_
```

Example usage in declarative config:

```yaml
config:
  redis:
    password: "{vault://env/redis_password}"
```

#### 3. Integrate with External Secret Stores

Configure Kong to use AWS Secrets Manager, HashiCorp Vault, or GCP:

```yaml
vaults:
  awssecretsmanager:
    config:
      region: us-east-1
      access_key: ...
      secret_key: ...
```

Reference external secrets by name:

```yaml
config:
  key: "{vault://awssecretsmanager/my-kong-secret#my-key}"
```

#### 4. Rotate Secrets Externally

Let the external Vault system handle rotation and Kong will fetch the latest version at runtime.

#### 5. Apply to Plugin Configs and Credentials

Use Vaults for:

- Database passwords
- Plugin credentials (e.g., OAuth client secrets)
- Upstream credentials (e.g., Basic Auth or mTLS keys)

## Consequences

### Positive Outcomes

- Eliminates plaintext secrets in Kong configuration files
- Enables dynamic secret rotation with zero-downtime reloads
- Enhances compliance with enterprise security standards (e.g., SOC2, ISO, NIST)

### Risks and Trade-offs

- Misconfigured Vault access may break plugin functionality
- Adds complexity to configuration management
- Requires coordination with platform/security teams

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0113-manage-sensitive-secrets-using-kong-vaults.md)

- [Kong Vaults Overview](https://docs.konghq.com/gateway/latest/kong-enterprise/secrets-management/backends/)
