# 199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows

Date: 2025-06-12

## Tags

git, secrets, insomnia, security, workflows, version-control

## Status

Accepted

Uses [198. Reference Secrets from External Vaults in Insomnia API Environments](0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)  
Uses [197. Standardize Credential Configuration for External Vault Providers in Insomnia](0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)  
Uses [196. Integrate Insomnia with HashiCorp Vault Using AppRole for Shared Secret Management](0196-integrate-insomnia-with-hashicorp-vault-using-approle-for-shared-secret-management.md)  
Uses [195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration](0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)  
Uses [171. Use Insomnia Environments for Secure and Scalable API Workflows](0171-use-insomnia-environments-for-secure-and-scalable-api-workflows.md)

## Context

Insomnia integrates with Git to enable collaborative workflows. However, when secrets are misconfigured (e.g., stored as plaintext or embedded directly in environment variables), they risk being accidentally committed and exposed in source control.

To support secure collaboration, workflows must enforce the use of secret references (not secret values), prevent plaintext leakage, and guide developers on validating commits before pushing.

## Decision

Establish the following workflow guidelines to prevent secret leakage in Git when using Insomnia:

- **Never store secrets directly** in environment variable values — use external vault references.
- Use **vault-backed variable references** for all sensitive fields (e.g., tokens, API keys).
- Ensure developers always **preview Git commits** in Insomnia’s Git panel to verify no sensitive data is present.
- Define a Git commit hook or CI lint step (optional) to reject pushes with known secret patterns (e.g., API keys).
- Include a checklist in the project README for safe Git usage with Insomnia, especially during onboarding.

## Consequences

### Positive Outcomes

- Reduces risk of secrets being leaked via Git history or PRs
- Reinforces security best practices in developer workflows
- Improves auditability of changes involving environment configurations

### Risks

- May introduce friction in developer workflows if not automated or well-documented
- Relies on team discipline unless enforced by tooling

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
