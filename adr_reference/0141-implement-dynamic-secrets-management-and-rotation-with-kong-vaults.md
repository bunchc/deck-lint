# 141. Implement Dynamic Secrets Management and Rotation with Kong Vaults

Date: 2025-04-25

## Tags

kong, gateway, secrets-management, vault, dynamic-secrets, rotation, security, compliance, automation

## Status

Accepted

## Context

Kong Gateway requires access to sensitive credentials, such as database passwords, OAuth client secrets, API keys, and TLS certificates. Traditionally, these secrets are static and manually rotated, increasing the risk of:

- Credential leaks and misuse
- Stale secrets persisting after user or system changes
- Non-compliance with regulatory frameworks (e.g., PCI-DSS, SOC 2)

Kong Vaults allow secrets to be externalized and retrieved securely at runtime. Integrating dynamic secrets management ensures that secrets are automatically rotated, reducing operational risk and improving security posture.

## Decision

Adopt dynamic secret management strategies using Kong Vault integrations with secret stores like HashiCorp Vault, AWS Secrets Manager, GCP Secret Manager, or Azure Key Vault.

### Implementation Guidelines

#### 1. Enable and Configure Kong Vaults

Enable Vault backends in Kong:

```yaml
env:
  - name: KONG_VAULTS
    value: "env,awssecretsmanager,vault,gcpsecretsmanager"
```

Configure Vault-specific parameters (endpoint URLs, credentials) in Kong’s configuration or environment variables.

#### 2. Store Secrets in Dynamic Secret Engines

Use dynamic secrets where possible:

- Database credentials from Vault's dynamic DB secrets engine
- OAuth client secrets issued with TTLs
- TLS certificates managed by ACME or Vault PKI engine

Benefits of dynamic secrets:

- Short-lived
- Automatically expire
- Minimize blast radius of leaks

#### 3. Reference Secrets in Kong Configurations

Instead of embedding secrets directly, reference them using vault syntax:

```yaml
config:
  redis:
    password: "{vault://awssecretsmanager/redis-creds#password}"
```

Or for DB credentials:

```yaml
pg_password: "{vault://vault/postgres-creds#password}"
```

Kong will fetch and cache secrets securely at runtime.

#### 4. Rotate Secrets Regularly

For static secrets:

- Rotate them automatically using secret manager rotation policies.
- Update secrets in Vaults without requiring Kong reloads if dynamic fetching is enabled.

For dynamic secrets:

- TTL expiration handles automatic revocation and renewal.

Integrate rotation events into CI/CD pipelines when necessary.

#### 5. Protect Vault Credentials and API Access

- Restrict who/what can read or write to the Vault backends
- Enable audit logging on Vaults
- Use mTLS or IAM roles for Kong-to-Vault authentication
- Set minimal secret scope for Kong service accounts

#### 6. Monitor Secret Fetch Failures

- Alert if Vault access fails (e.g., due to expired Kong Vault credentials)
- Watch for metrics like fetch timeouts, permission errors
- Implement fallback behaviors where appropriate (e.g., degraded read-only modes)

## Consequences

### Positive Outcomes

- Stronger security by removing static secrets from Kong configurations
- Automatic, safer secret rotation practices
- Reduced operational overhead and manual error risks
- Easier compliance with security and audit standards

### Risks and Trade-offs

- Adds dependency on external secret managers
- Risk of API request failures if Vault backends are unavailable
- Additional complexity in Kong Vault configuration and operational monitoring

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0141-implement-dynamic-secrets-management-and-rotation-with-kong-vaults.md)

- [Kong Secrets Management](https://docs.konghq.com/gateway/latest/kong-enterprise/secrets-management/)
- [HashiCorp Vault Dynamic Secrets](https://developer.hashicorp.com/vault/docs/secrets/databases)
- [AWS Secrets Manager Rotation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html)
