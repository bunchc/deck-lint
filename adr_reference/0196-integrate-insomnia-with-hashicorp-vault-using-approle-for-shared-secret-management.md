# 196. Integrate Insomnia with HashiCorp Vault Using AppRole for Shared Secret Management

Date: 2025-06-12

## Tags

vault, hashicorp, secrets, integration, collaboration, AppRole, insomnia

## Status

Accepted

Used by [197. Standardize Credential Configuration for External Vault Providers in Insomnia](0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)
Used by [198. Reference Secrets from External Vaults in Insomnia API Environments](0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)
Used by [199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows](0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)

Uses [195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration](0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)
Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

To securely share secrets like API keys and credentials across a team, Insomnia supports external vault integration. Among supported providers, HashiCorp Vault is preferred for on-premises deployments due to its flexibility, security model, and role-based access.

This ADR focuses on using HashiCorp Vault with the `AppRole` authentication method to pull shared secrets into Insomnia without storing them in Git or exposing them in plaintext.

## Decision

Standardize the use of HashiCorp Vault (on-premises) as the shared secrets provider for Insomnia projects requiring collaborative secret management.

- Use **AppRole** authentication for secure machine-to-vault access.
- Define a reusable credential in Insomnia under `Settings > Cloud Credentials` with:
  - Vault URL (e.g., `http://localhost:8200`)
  - Auth Method: `AppRole`
  - Role ID and Secret ID generated from Vault
- Set secrets in Vault under structured paths (e.g., `secret/transactions-api/api-key`)
- Reference secrets in the Insomnia environment editor using the `External Vault → HashiCorp Vault` UI flow

## Consequences

### Positive Outcomes

- Provides a **secure, Git-safe** method for referencing shared secrets.
- Enables collaborative workflows without exposing credentials.
- Compatible with enterprise Vault setups and existing role-based access controls.

### Risks

- Requires setup and ongoing maintenance of Vault roles and secret policies.
- Developers must be onboarded to Vault access and AppRole workflows.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0196-integrate-insomnia-with-hashicorp-vault-using-approle-for-shared-secret-management.md)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
- [HashiCorp Vault AppRole Auth Method](https://developer.hashicorp.com/vault/docs/auth/approle)
