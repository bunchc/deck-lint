# 195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration

Date: 2025-06-12

## Tags

insomnia, secrets, local-vault, dev-only, security, environment-management

## Status

Accepted

Used by [196. Integrate Insomnia with HashiCorp Vault Using AppRole for Shared Secret Management](0196-integrate-insomnia-with-hashicorp-vault-using-approle-for-shared-secret-management.md)
Used by [197. Standardize Credential Configuration for External Vault Providers in Insomnia](0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)
Used by [198. Reference Secrets from External Vaults in Insomnia API Environments](0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)
Used by [199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows](0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)

Uses [171. Use Insomnia Environments for Secure and Scalable API Workflows](0171-use-insomnia-environments-for-secure-and-scalable-api-workflows.md)
Uses [170. Adopt Insomnia Enterprise for Collaborative and Secure API Development](0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)

## Context

Insomnia offers two primary mechanisms for managing secrets:

- **Local Secret Environments**: Secrets are encrypted and stored locally, accessible only to the developer who defined them.
- **External Vault Integrations**: Secrets are securely fetched at runtime from enterprise-grade secret managers like HashiCorp Vault, AWS Secrets Manager, etc.

While local secret environments offer security for individual developers, they do not support collaboration and cannot be synced or shared via Git. Conversely, external vault integrations provide a scalable, secure way to manage secrets across environments and teams.

## Decision

Adopt the following strategy for secret management in Insomnia:

- **Use local secret environments** exclusively for developer-only credentials that should never leave a local workstation (e.g., personal tokens, sandbox keys).
- **Use external vault integrations** for any secret values that must be shared across team members or deployed environments.
- Document clearly in project READMEs which secrets are expected to be managed locally vs. via vault.
- Avoid mixing local and external vault strategies in the same environment to reduce ambiguity.

## Consequences

### Positive Outcomes

- Enables **secure, auditable, and shareable** secret usage across teams.
- Prevents accidental leakage of secrets in Git-based workflows.
- Supports enterprise integration with existing Vault providers and authentication mechanisms.

### Risks

- Adds setup overhead for external vault integration, particularly for developers unfamiliar with Vault tooling.
- Some secrets may be misclassified, requiring later refactoring of environments.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
