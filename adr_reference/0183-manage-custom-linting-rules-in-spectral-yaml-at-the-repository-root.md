# 183. Manage Custom Linting Rules in `.spectral.yaml` at the Repository Root

Date: 2025-06-12

## Tags

spectral, linting, custom-rules, insomnia, openapi, api-governance, version-control, configuration

## Status

Accepted

Used by [185. Integrate Spectral-Based Linting into CI Workflows Using `inso lint spec`](0185-integrate-spectral-based-linting-into-ci-workflows-using-inso-lint-spec.md)

Uses [182. Adopt Spectral as the Standard Linting Engine for OpenAPI in Insomnia](0182-adopt-spectral-as-the-standard-linting-engine-for-openapi-in-insomnia.md)

## Context

While Spectral provides a useful default ruleset for OpenAPI validation, many organizations need to tailor these rules to align with internal API design standards. Examples include enforcing specific naming conventions, requiring field descriptions, or disallowing certain operations like `DELETE`.

To support these use cases, Spectral allows teams to define and version custom rules in a `.spectral.yaml` file placed in the root of the Git repository. Insomnia automatically detects and uses this configuration when present, enabling consistent, automated enforcement of these policies across contributors.

## Decision

Require that all Git-backed Insomnia API projects maintain a **`.spectral.yaml`** file in the root of the repository when custom rules are needed.

The `.spectral.yaml` file must:

- Extend the base ruleset (`spectral:oas`)
- Define, override, or disable rules to meet internal guidelines
- Be tracked in version control alongside the OpenAPI spec
- Apply only to the scope of the current project (one file per repo)

All contributors must use this file to lint and validate their specs, whether locally in Insomnia or through the Inso CLI.

## Consequences

### Positive Outcomes

- **Policy Enforcement**: Ensures internal standards are consistently applied.
- **Versioned Governance**: Rule changes are tracked and reviewed like code.
- **Developer Feedback**: Errors and warnings surface directly in the Insomnia UI.
- **Team Alignment**: Provides a shared source of truth for API review and testing.

### Risks

- **Misconfiguration**: Poorly written rules may yield false positives or break valid specs.
- **Maintenance Overhead**: Rules must evolve with project and spec complexity.
- **Inconsistency**: Projects without `.spectral.yaml` may not follow the same rules unless centrally enforced.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0183-manage-custom-linting-rules-in-spectral-yaml-at-the-repository-root.md)
- [Add custom linting rules in Insomnia](https://developer.konghq.com/how-to/add-custom-linting-rules/)
- [Spectral GitHub Repository](https://github.com/stoplightio/spectral)
