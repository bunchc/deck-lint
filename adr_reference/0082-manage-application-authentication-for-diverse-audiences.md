# 82. Manage Application Authentication for Diverse Audiences

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, authorization, deployment, kubernetes, multi-tenant, audience, best-practices

## Status

Accepted

Implements [49. Enforce Object-Level Authorization with OIDC and ACL Plugins](0049-enforce-object-level-authorization-with-oidc-and-acl-plugins.md)

Implements [50. Centralize Authentication Logic Using Kong Gateway](0050-centralize-authentication-logic-using-kong-gateway.md)

Implements [54. Protect Admin APIs with Route-Level ACL Enforcement](0054-protect-admin-apis-with-route-level-acl-enforcement.md)

Depends on [26. OIDC Plugin Redirect URI & Flow Pattern Best Practices](0026-oidc-plugin-redirect-uri-and-flow-pattern-best-practices.md)

Integrates with [72. Integrate Kong Gateway with OPA for Declarative Access Control](0072-integrate-kong-gateway-with-opa-for-declarative-access-control.md)

## Context

Modern API platforms serve diverse client types: internal applications, third-party partners, and public-facing consumers. Each group requires tailored authentication mechanisms depending on trust level, compliance needs, and UX considerations.

Kong Gateway supports multiple authentication strategies that can be layered or scoped per route or service. Managing these variations effectively ensures both strong security and flexibility for developers and consumers.

## Decision

Use Kong Gateway’s plugin ecosystem to implement and manage authentication strategies across different consumer categories:

### Consumer Types & Recommendations

- **Internal Applications (trusted)**:

  - Use **mutual TLS (mTLS)** or **JWT signed by internal IdPs**.
  - Apply additional ACL or rate-limiting controls to prevent misuse.

- **Partner Integrations (semi-trusted)**:

  - Use **OAuth 2.0** with **client credentials grant** or **API key authentication** via `key-auth`.
  - Enforce scopes and quotas based on subscription plans or contracts.

- **Public Clients (untrusted)**:
  - Use **OpenID Connect (OIDC)** with **authorization code flow + PKCE**.
  - Protect with **rate limiting**, **bot detection**, and **logging** plugins.

### Implementation Guidelines

- Group consumers by type using **Consumer Groups** and apply plugin configurations accordingly.
- Use the **OIDC plugin** for standard-compliant identity federation and token validation.
- Chain plugins (e.g., auth → ACL → rate-limiting) for layered protection.
- Add metadata to logs and traces for consumer classification and troubleshooting.

## Consequences

### Positive

- Enables secure access control tailored to audience risk profiles.
- Reduces friction for onboarding while maintaining compliance and visibility.
- Makes policies auditable and testable in CI/CD pipelines.

### Risks

- Requires careful configuration of plugin chaining and scopes.
- Increased operational complexity when managing multiple auth methods across environments.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0082-manage-application-authentication-for-diverse-audiences.md)

- [Kong OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
- [Kong Key Authentication Plugin](https://docs.konghq.com/hub/kong-inc/key-auth/)
- [Kong mTLS Authentication](https://docs.konghq.com/gateway/latest/kong-enterprise/mtls-auth/)
- [Kong Consumer Groups](https://docs.konghq.com/konnect/gateway-manager/configuration/consumer-groups/)
- [Kong Blog: Managing Application Authentication](https://konghq.com/blog/engineering/managing-application-auth)
