# 197. Standardize Credential Configuration for External Vault Providers in Insomnia

Date: 2025-06-12

## Tags

insomnia, cloud-credentials, secrets, vault, configuration

## Status

Accepted

Used by [198. Reference Secrets from External Vaults in Insomnia API Environments](0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)
Used by [199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows](0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)

Uses [196. Integrate Insomnia with HashiCorp Vault Using AppRole for Shared Secret Management](0196-integrate-insomnia-with-hashicorp-vault-using-approle-for-shared-secret-management.md)
Uses [195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration](0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)
Uses [171. Use Insomnia Environments for Secure and Scalable API Workflows](0171-use-insomnia-environments-for-secure-and-scalable-api-workflows.md)

## Context

Insomnia allows the creation of secure credentials for external vault providers under `Settings > Cloud Credentials`. These credentials are used to authenticate with Vault services and access secret values securely.

To reduce inconsistencies and avoid misconfiguration across teams, a standardized method for setting up these credentials is required. This ensures that all projects using secret management follow a uniform pattern, which supports traceability, reuse, and easier onboarding.

## Decision

Establish a consistent convention for configuring credentials in Insomnia for external vault access:

- **Naming Convention**: Use lowercase identifiers with dashes, matching the Vault deployment and scope (e.g., `local-hcv`, `prod-hcv`, `aws-dev-secrets`)
- **Credential Scope**:
  - For **on-premise HashiCorp Vault**, use `AppRole` with environment-specific Role ID and Secret ID
  - For **cloud vaults** (e.g., AWS, GCP, Azure), use the respective authentication flows (IAM roles, tokens, or service principals)
- **Usage Scope**: Credentials should be scoped to environment-specific use and **never embedded directly** in requests or environment variables
- Document all active credentials and their purpose in a central README or vault access manifest

## Consequences

### Positive Outcomes

- Promotes reuse of secrets access patterns across teams
- Prevents naming collisions or untraceable credentials in shared environments
- Simplifies onboarding and reduces setup errors

### Risks

- Requires coordination for shared credential naming and rotation
- Improper documentation may lead to misused or abandoned credentials

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
- [HashiCorp Vault AppRole Auth Method](https://developer.hashicorp.com/vault/docs/auth/approle)
