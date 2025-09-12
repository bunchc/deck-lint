# 170. Adopt Insomnia Enterprise for Collaborative and Secure API Development

Date: 2025-06-12

## Tags

insomnia, api-development, tooling, enterprise, rbac, secrets-management, git, mocking, spectral, linting, oidc, saml

## Status

Accepted

Used by [171. Use Insomnia Environments for Secure and Scalable API Workflows](0171-use-insomnia-environments-for-secure-and-scalable-api-workflows.md)
Used by [172. Standardize Git-Backed API Projects in Insomnia](0172-standardize-git-backed-api-projects-in-insomnia.md)
Used by [173. Use Feature Branches for Isolated API Development in Insomnia](0173-use-feature-branches-for-isolated-api-development-in-insomnia.md)
Used by [174. Adopt Template Repositories for Standardized API Bootstrapping](0174-adopt-template-repositories-for-standardized-api-bootstrapping.md)
Used by [175. Generate Request Collections from Complete OpenAPI Specifications in Insomnia](0175-generate-request-collections-from-complete-openapi-specifications-in-insomnia.md)
Used by [176. Apply After-Response Scripts to Dynamically Capture and Store Runtime Data](0176-apply-after-response-scripts-to-dynamically-capture-and-store-runtime-data.md)
Used by [177. Use Pre-Request Scripts to Automate Data Setup Across Related Requests](0177-use-pre-request-scripts-to-automate-data-setup-across-related-requests.md)
Used by [178. Use Structured Test Suites in Insomnia for API Verification](0178-use-structured-test-suites-in-insomnia-for-api-verification.md)
Used by [179. Link Tests to API Requests to Enable Automated Validation](0179-link-tests-to-api-requests-to-enable-automated-validation.md)
Used by [180. Manually Add and Script Requests for Newly Introduced Endpoints](0180-manually-add-and-script-requests-for-newly-introduced-endpoints.md)
Used by [181. Create Tests for Future or Unimplemented Endpoints as Placeholders](0181-create-tests-for-future-or-unimplemented-endpoints-as-placeholders.md)
Used by [182. Adopt Spectral as the Standard Linting Engine for OpenAPI in Insomnia](0182-adopt-spectral-as-the-standard-linting-engine-for-openapi-in-insomnia.md)
Used by [183. Manage Custom Linting Rules in .spectral.yaml at the Repository Root](0183-manage-custom-linting-rules-in-spectral-yaml-at-the-repository-root.md)
Used by [184. Standardize the Use of Inso CLI for API Validation in CI/CD Pipelines](0184-standardize-the-use-of-inso-cli-for-api-validation-in-ci-cd-pipelines.md)
Used by [185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`](0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)
Used by [186. Automate Test Execution with `inso run test` Across CI/CD Pipelines](0186-automate-test-execution-with-inso-run-test-across-ci-cd-pipelines.md)
Used by [187. Use `inso export spec` for Clean OpenAPI Outputs in Automation Workflows](0187-use-inso-export-spec-for-clean-openapi-outputs-in-automation-workflows.md)
Used by [188. Adopt Self-Hosted Mock Servers Using Mockbin for Controlled API Simulation](0188-adopt-self-hosted-mock-servers-using-mockbin-for-controlled-api-simulation.md)
Used by [189. Version Control and Reuse of Mock Server Configurations Across Services](0189-version-control-and-reuse-of-mock-server-configurations-across-services.md)
Used by [190. Integrate Mock Services into Docker Compose for Dependent Service Development](0190-integrate-mock-services-into-docker-compose-for-dependent-service-development.md)
Used by [191. Automate Mock Route Activation via Insomnia to Ensure Mockbin Readiness](0191-automate-mock-route-activation-via-insomnia-to-ensure-mockbin-readiness.md)
Used by [192. Version Control Mock Server Configurations in Git for Consistency](0192-version-control-mock-server-configurations-in-git-for-consistency.md)
Used by [193. Leverage Insomnia’s Mock Duplication to Share Mocks Across Dependent Services](0193-leverage-insomnia-s-mock-duplication-to-share-mocks-across-dependent-services.md)
Used by [194. Coordinate Mock and Consumer Service Versioning for Inline Testing](0194-coordinate-mock-and-consumer-service-versioning-for-inline-testing.md)
Used by [195. Use Local Secrets for Developer-Only Needs and Vaults for Team Collaboration](0195-use-local-secrets-for-developer-only-needs-and-vaults-for-team-collaboration.md)
Used by [196. Integrate Insomnia with HashiCorp Vault Using AppRole for Shared Secret Management](0196-integrate-insomnia-with-hashicorp-vault-using-approle-for-shared-secret-management.md)
Used by [197. Standardize Credential Configuration for External Vault Providers in Insomnia](0197-standardize-credential-configuration-for-external-vault-providers-in-insomnia.md)
Used by [198. Reference Secrets from External Vaults in Insomnia API Environments](0198-reference-secrets-from-external-vaults-in-insomnia-api-environments.md)
Used by [199. Prevent Secret Leakage in Git by Enforcing Secure Insomnia Workflows](0199-prevent-secret-leakage-in-git-by-enforcing-secure-insomnia-workflows.md)

## Context

Insomnia is widely used for API design, testing, and collaboration. While the tool offers a basic local or scratchpad mode, these modes lack robust collaboration, security, and governance features required in enterprise environments. As API development scales across teams, managing access, version control, and secure integration becomes essential.

## Decision

Adopt **Insomnia Enterprise** and mandate account-based login for all team members to unlock advanced collaboration and security features. Key benefits include:

### Collaboration and Version Control

- **Git Sync**: Enables full version control and team collaboration on shared API projects.
- **Project Switching**: Seamlessly manage and switch between multiple API design and testing projects.

### Security and Access Control

- **Single Sign-On (SSO)**: Support for OIDC and SAML ensures secure, centralized authentication.
- **Role-Based Access Control (RBAC)**: Fine-grained permissions for different user roles within organizations.

### Enterprise-Only Features

- **Organizations**: Logical grouping of related teams and projects.
- **Custom Spectral Linting**: Define and enforce API standards using Spectral rulesets.
- **Mocking Services**: Generate and deploy mocks via both cloud and self-hosted infrastructure.
- **Secrets Management**: Secure integration with enterprise-grade secret stores, including:

  - HashiCorp Vault (HCV)
  - AWS Secrets Manager
  - Azure Key Vault
  - GCP Secret Manager

## Consequences

### Positive Outcomes

- **Standardized Workflows**: Enables a unified approach to API design, testing, and collaboration.
- **Security Compliance**: Aligns with enterprise security policies for authentication and secret management.
- **Auditability and Governance**: Git Sync and RBAC ensure traceable and controlled changes across teams.
- **Improved Developer Productivity**: Tools and workflows are optimized for team use, reducing friction.

### Risks

- **Licensing Costs**: Enterprise licensing may increase operational costs.
- **Onboarding Curve**: Teams accustomed to local mode may require training on enterprise features.
- **Dependency on External Services**: Git Sync and secrets management rely on external services being available and correctly configured.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0170-adopt-insomnia-enterprise-for-collaborative-and-secure-api-development.md)
- [Insomnia Documentation](https://developer.konghq.com/index/insomnia/)
- [Version control in Insomnia](https://developer.konghq.com/insomnia/version-control/)
- [Add custom linting rules in Insomnia](https://developer.konghq.com/how-to/add-custom-linting-rules/)
- [External vault integration](https://developer.konghq.com/insomnia/external-vault/)
