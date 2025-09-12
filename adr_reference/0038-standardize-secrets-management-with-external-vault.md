# 38. Standardize Secrets Management with External Vault

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, secrets-management, external-vault, credentials, certificate-management, hashicorp-vault, aws-secrets-manager, runtime-integration, secret-rotation, compliance, risk-management, configuration-security

## Status

Accepted

## Context

Static secrets (e.g., credentials, certificates) inside API Gateway configurations present security risks. Runtime secret management provides stronger security guarantees.

## Decision

Adopt external secret management:

- Store all sensitive credentials in an external vault (e.g., AWS Secrets Manager, HashiCorp Vault).
- Integrate Kong Gateway with external vaults at runtime using credential-fetching plugins or platform integrations.

## Consequences

### Positive

- Minimized risk of credential leakage from static configurations.
- Easier secret rotation and lifecycle management.

### Risks

- Adds external dependencies and potential vault access latencies.
- Vault failure must be mitigated with retries or local caching.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0038-standardize-secrets-management-with-external-vault.md)
- [Kong Vault Integration](https://docs.konghq.com/gateway/latest/reference/configuration/#vault-section)
- [Kong Vault Reference](https://docs.konghq.com/gateway/latest/kong-enterprise/secrets-management/)
