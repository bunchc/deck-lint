# 198. Reference Secrets from External Vaults in Insomnia API Environments

Date: 2025-06-12

## Tags

environment, secrets, insomnia, vault-reference, api-management

## Status

Accepted

Used by [199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows](0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)

Uses [197. Standardize Credential Configuration for External Vault Providers in Insomnia](0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)
Uses [196. Integrate Insomnia with HashiCorp Vault Using AppRole for Shared Secret Management](0196-integrate-insomnia-with-hashicorp-vault-using-approle-for-shared-secret-management.md)
Uses [195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration](0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)
Uses [171. Use Insomnia Environments for Secure and Scalable API Workflows](0171-use-insomnia-environments-for-secure-and-scalable-api-workflows.md)

## Context

In Insomnia, environment variables can reference external vaults to dynamically pull secrets during runtime. This avoids hardcoding or exposing sensitive values in Git and enables secure, scalable secret usage in API testing and development.

However, referencing secrets from Vault requires consistent patterns to ensure correctness, traceability, and maintainability across environments.

## Decision

Adopt a standardized approach for referencing secrets in Insomnia environments:

- Use the **table view** in the environment editor to define secret-backed variables (e.g., `api_key`, `jwt_token`, `db_password`)
- Right-click the value field and choose `External Vault → HashiCorp Vault` (or other provider)
- Fill out the vault reference fields consistently:
  - **Credential**: Select the pre-configured credential (e.g., `local-hcv`)
  - **Secret Name**: Use consistent pathing (e.g., `transactions-api/api-key`)
  - **KV Secret Engine Version**: `v2` unless otherwise required
  - **Secret Engine Path**: Typically `secret` or as defined in Vault setup
  - **Secret Key**: Name of the field inside the Vault secret (e.g., `value`)

Document any required environment variables in the project README, including their vault paths and intended usage.

## Consequences

### Positive Outcomes

- Avoids secret exposure in code and version control
- Makes secret usage declarative and auditable
- Supports per-environment secret separation (e.g., dev, staging, prod)

### Risks

- Misconfigured vault references can lead to request failures or incorrect values
- Vault path changes may require environment updates and coordination

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
