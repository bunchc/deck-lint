# 124. Enforce Secure Defaults for Kong Gateway Plugins

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, authorization, deployment, kubernetes, best-practices, policy-as-code, compliance, configuration, baseline

## Status

Accepted

Governs [109. Limit Plugin Scope to Essential Services and Routes](0109-limit-plugin-scope-to-essential-services-and-routes.md)

## Context

Kong Gateway plugins offer extensive flexibility to configure authentication, authorization, traffic control, security, and observability. However, plugins often expose configurable parameters that, if improperly set (or left at insecure defaults), could weaken the security posture of the platform.

Examples:

- Allowing overly permissive CORS headers
- Accepting unsigned JWT tokens
- Using default credentials or weak secret configurations

Without enforcing secure defaults:

- APIs are more vulnerable to unauthorized access, data leakage, and abuse
- Inconsistent policy implementations arise across teams
- It becomes harder to meet regulatory and compliance requirements

## Decision

Establish and enforce secure baseline defaults for all Kong plugins, either at provisioning time or through centralized policy-as-code automation.

### Implementation Guidelines

#### 1. Review Plugin Configuration Defaults

For each enabled plugin, ensure that defaults are reviewed and updated where necessary:

- Enable strict verification (e.g., JWT `secret_is_base64`, `anonymous` set to `false`)
- Require explicit credential validation (e.g., key-auth with encrypted keys)
- Tighten CORS rules (limit allowed origins and methods)
- Enable logging and tracing for authentication plugins where feasible

#### 2. Provide Baseline Configuration Templates

Maintain baseline YAML templates or decK configuration fragments for critical plugins:

```yaml
plugins:
  - name: jwt
    config:
      secret_is_base64: true
      run_on_preflight: false
      anonymous: null
      claims_to_verify:
        - exp
        - nbf
```

Distribute these templates across development teams to drive consistent application.

#### 3. Validate and Enforce via CI/CD or Policy Engines

Use tools like:

- decK + GitHub Actions (`deck validate`)
- OPA/Gatekeeper for Kubernetes-based Kong deployments
- Custom linters to check for dangerous configurations

Fail builds or flag PRs that violate secure plugin defaults.

#### 4. Periodic Security Reviews

- Schedule periodic audits of live Kong plugin configurations
- Dump current config (`deck dump`) and compare against secure baselines
- Remediate any deviations

#### 5. Educate Developers and Platform Teams

Train teams to understand the security impact of plugin configuration choices and encourage them to opt into stricter defaults.

## Consequences

### Positive Outcomes

- Stronger API security posture by default
- Reduces human error in plugin configuration
- Facilitates regulatory compliance and audit readiness
- Promotes consistency and predictability across environments

### Risks and Trade-offs

- Slight learning curve for teams adjusting to stricter policies
- May require handling edge cases where flexibility is needed
- Ongoing maintenance of secure baseline templates as Kong evolves

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0124-enforce-secure-defaults-for-kong-gateway-plugins.md)

- [Kong Gateway Plugin Hub](https://docs.konghq.com/hub/)
- [deck validate Command](https://docs.konghq.com/deck/gateway/validate/)
