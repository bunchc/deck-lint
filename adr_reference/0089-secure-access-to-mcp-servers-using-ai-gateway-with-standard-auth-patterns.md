# 89. Secure Access to MCP Servers Using AI Gateway with Standard Auth Patterns

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, authentication, authorization, deployment, ai, llm, mcp, security, oidc, jwt, key-auth, acl, access-control, identity-provider, zero-trust

## Status

Accepted

## Context

MCP (Model Context Protocol) servers are foundational to modern AI-native applications, enabling communication between agents, tools, and backend services through large language models. Exposing MCP endpoints securely is critical due to the sensitive nature of prompts, tokens, and model outputs.

In most deployments, multiple users, services, or agents may need access to LLM context endpoints. Each may belong to different trust zones or roles. Fine-grained authentication and authorization mechanisms are necessary to ensure that only legitimate clients can access these endpoints.

## Decision

Use Kong AI Gateway to expose MCP endpoints and enforce authentication and authorization using standard plugins:

- **OpenID Connect plugin** to support federated identity, OAuth2 flows, and secure session management. Integrates with common identity providers such as Auth0, Azure AD, and Okta.
- **Key Authentication plugin** for simpler machine-to-machine integrations where an OAuth2 provider is not present.
- **ACL plugin** to restrict access to specific consumer groups (e.g., "agents", "humans", "internal-services").
- If required, use JWT claims to enforce attribute-based access control in combination with the OpenID Connect plugin.

This setup ensures that each request to an MCP endpoint is authenticated and authorized based on identity and role.

## Consequences

### Positive Outcomes

- Provides cryptographically secure identity verification for MCP access.
- Supports both human users and machine clients.
- Easy integration with enterprise identity providers using OIDC.
- Compatible with session-based auth or API token flows.

### Risks and Trade-offs

- Adds configuration complexity if integrating multiple IDPs or consumer groups.
- Session or token expiration must be handled at the client layer.
- ACL and claims-based authorization requires regular mapping review as identities evolve.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0089-secure-access-to-mcp-servers-using-ai-gateway-with-standard-auth-patterns.md)

- [Kong AI Gateway Overview](https://docs.konghq.com/gateway/latest/ai-gateway/)
- [OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
- [Key Authentication Plugin](https://docs.konghq.com/hub/kong-inc/key-auth/)
- [ACL Plugin](https://docs.konghq.com/hub/kong-inc/acl/)
- Blog: [Securing, Observing, and Governing MCP Servers](https://konghq.com/blog/product-releases/securing-observing-governing-mcp-servers-with-ai-gateway)
