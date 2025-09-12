# 103. Use Secrets Management for Sensitive Configuration

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, deployment, kubernetes, secrets, secrets-management, vault, keyring, encryption, compliance

## Status

Accepted

Implements [113. Manage Sensitive Secrets Using Kong Vaults](0113-manage-sensitive-secrets-using-kong-vaults.md)

Governed by [122. Enforce Configuration Consistency and Policy-as-Code Validation for Kong Gateway](0122-monitor-configuration-drift-between-desired-state-and-running-kong-gateway.md)

## Context

Kong Gateway requires sensitive values in its configuration, such as database credentials, API keys, tokens, or certificate data. Hardcoding these values in configuration files (e.g., `kong.conf`), Helm charts, or declarative configs exposes the platform to significant security risks, including credential leakage or accidental commits to version control.

Enterprise-grade deployments should follow secure secrets management practices to ensure sensitive values are encrypted at rest, protected in transit, and rotated as needed.

## Decision

Avoid including sensitive values in plaintext. Instead, use platform-native or external secret management systems to inject sensitive configuration at runtime.

### Recommended Approaches

#### 1. Use Environment Variables

Most Kong configuration fields support resolution from environment variables:

```yaml
env:
  - name: KONG_PG_PASSWORD
    valueFrom:
      secretKeyRef:
        name: kong-db-creds
        key: password
```

2. Kubernetes Secrets

Use Kubernetes secrets to store sensitive values like database credentials, CA bundles, plugin tokens, or upstream mTLS keys. Reference these secrets using envFrom or volumeMounts.

3. Vault Integration

Kong supports Vault via the vault-auth plugin and native Vault integration in Konnect. Use this for credentials that must be rotated regularly or shared securely across environments.

4. Encrypt Keyring (Optional)

Enable Kong Keyring for at-rest encryption of secrets stored in the database (e.g., keys used by plugins like key-auth-enc or jwt-signer):

```shell
KONG_KEYRING_ENABLED=true
```

## Consequences

### Positive Outcomes

- Prevents secret leakage through logs, version control, or misconfigured APIs.
- Facilitates secure injection of secrets at deployment time.
- Enables periodic rotation policies aligned with compliance standards.

## Risks and Trade-offs

- Requires coordination with external systems (Vault, Kubernetes secrets, etc.).
- Improper access control to secret stores could become a new attack surface.
- Misconfiguration may lead to service startup failure if secrets are missing or malformed.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0103-use-secrets-management-for-sensitive-configuration.md)

- [Kong Keyring Encryption](https://docs.konghq.com/gateway/latest/kong-enterprise/db-encryption/#main)
