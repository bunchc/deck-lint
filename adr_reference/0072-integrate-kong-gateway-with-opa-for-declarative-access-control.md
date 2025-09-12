# 72. Integrate Kong Gateway with OPA for Declarative Access Control

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, authentication, authorization, monitoring, opa, open policy agent, access control, rego, policy enforcement, declarative authorization, centralized authorization, owasp

## Status

Accepted

Implements [41. Strengthen OWASP API Risk Mitigation with Kong Plugins and WAF](0041-strengthen-owasp-api-risk-mitigation-with-kong-plugins-and-waf.md)

Integrates with [49. Enforce Object-Level Authorization with OIDC and ACL Plugins](0049-enforce-object-level-authorization-with-oidc-and-acl-plugins.md)

Integrates with [50. Centralize Authentication Logic Using Kong Gateway](0050-centralize-authentication-logic-using-kong-gateway.md)

Required by [72. Implement Fine-Grained Access Policies Using Kong and OPA](0073-implement-fine-grained-access-policies-using-kong-and-opa.md)

Extends [33. Use of Control Planes or Workspaces and RBAC](0033-use-of-control-plane-or-workspaces-and-rbac.md)

Integrated by [82. Manage Application Authentication for Diverse Audiences](0082-manage-application-authentication-for-diverse-audiences.md)

## Context

As organizations adopt microservices architectures, managing access control across services becomes complex. Embedding authorization logic within each service leads to inconsistency and maintenance challenges. Open Policy Agent (OPA) offers a centralized, declarative approach to policy enforcement, allowing for consistent and flexible access control.

Kong Gateway, acting as the entry point for API traffic, provides an ideal integration point for OPA. By delegating authorization decisions to OPA, Kong can enforce fine-grained access policies without embedding logic into individual services.

## Decision

Integrate Kong Gateway with OPA to centralize and standardize access control policies:

- **Deploy OPA**: Set up OPA as a standalone service or sidecar to evaluate access policies written in Rego.
- **Configure Kong OPA Plugin**: Utilize Kong's OPA plugin to forward incoming API requests to OPA for policy evaluation.
- **Define Rego Policies**: Write Rego policies that consider request attributes (e.g., method, path, headers) and external data (e.g., user roles) to make authorization decisions.
- **Policy Enforcement**: Based on OPA's response, Kong will allow or deny the API request accordingly.

## Consequences

### Positive

- Centralized policy management enhances consistency and maintainability.
- Decouples authorization logic from application code.
- Enables dynamic, context-aware access control decisions.

### Risks

- Introduces additional latency due to external policy evaluation.
- Requires robust monitoring to ensure OPA availability and performance.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0072-integrate-kong-gateway-with-opa-for-declarative-access-control.md)

- [Kong OPA Plugin Documentation](https://docs.konghq.com/hub/kong-inc/opa/)
- [Open Policy Agent Documentation](https://www.openpolicyagent.org/docs/latest/)
- [Kong Blog: How to Implement Secure Access Control with OPA and Kong](https://konghq.com/blog/engineering/secure-access-control-with-opa-and-kong)
