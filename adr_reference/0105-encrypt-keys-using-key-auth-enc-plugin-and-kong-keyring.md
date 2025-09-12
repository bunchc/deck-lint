# 105. Encrypt Keys Using key-auth-enc Plugin and Kong Keyring

Date: 2025-04-25

## Tags

auth, kong, api, gateway, plugin, security, encryption, keyring, key-auth-enc, compliance, secrets-management

## Status

Accepted

## Context

The `key-auth` plugin is commonly used in Kong Gateway to authenticate API consumers using static API keys. By default, these keys are stored in plaintext in the Kong database, which can expose sensitive credentials to database administrators or attackers in case of a data breach.

Kong provides the `key-auth-enc` plugin to address this issue by encrypting API keys before storage. Combined with the Kong Keyring feature, it ensures secrets are encrypted at rest with support for key rotation and protection from unauthorized disclosure.

## Decision

In production environments, use the `key-auth-enc` plugin instead of `key-auth`, and enable Kong Keyring to encrypt stored secrets.

### Implementation Steps

#### 1. Enable Kong Keyring

Set the following in the configuration:

```yaml
env:
  - name: KONG_KEYRING_ENABLED
    value: "on"
```

This enables symmetric encryption for plugin secrets stored in the database (e.g., API keys, HMAC secrets).

2. Use key-auth-enc Plugin

Configure the plugin on routes/services or globally:

```shell
curl -X POST http://localhost:8001/plugins \
  --data "name=key-auth-enc" \
  --data "config.hide_credentials=true"
```

When consumers are created with an API key, it will be encrypted using the keyring and only decrypted in memory during runtime.

3. Key Rotation (Optional)

Kong supports keyring rotation for stronger security posture. Follow best practices for:

- Creating new encryption keys
- Decrypting existing secrets
- Promoting new keys as active

## Consequences

### Positive Outcomes

- API keys are encrypted at rest, reducing risk of leakage.
- Complies with data protection regulations (e.g., GDPR, PCI-DSS).
- Supports future-proof encryption and rotation strategies.

### Risks and Trade-offs

- Adds complexity in plugin configuration and lifecycle operations.
- Mismanagement of keys may lead to data loss or decryption failures.
- Requires periodic review of keyring material and policies.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0105-encrypt-keys-using-key-auth-enc-plugin-and-kong-keyring.md)

- [key-auth-enc Plugin](https://docs.konghq.com/hub/kong-inc/key-auth-enc/)
- [Kong Keyring Encryption](https://docs.konghq.com/gateway/latest/kong-enterprise/db-encryption/#main)
