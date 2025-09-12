# 26. OIDC Plugin Redirect URI & Flow Pattern Best Practices

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, security, authentication, authorization, oidc, oauth2, redirect-uri, single-sign-on, sso, identity-provider, token-handling, authorization-code-flow

## Status

Accepted

Supports [49. Enforce Object-Level Authorization with OIDC and ACL Plugins](0049-enforce-object-level-authorization-with-oidc-and-acl-plugins.md)

Implements [50. Centralize Authentication Logic Using Kong Gateway](0050-centralize-authentication-logic-using-kong-gateway.md)

Required by [82. Manage Application Authentication for Diverse Audiences](0082-manage-application-authentication-for-diverse-audiences.md)

## Context

In the OAuth 2 authorization‑code flow using Kong’s OIDC plugin, the `redirect_uri` can point to a path (e.g. `/login`) or simply use a URL ending in `/`.  
Kong’s plugin supports both dynamically deriving the redirect URI from the incoming request and statically configuring one, but each approach has trade‑offs — especially if the Identity Provider (IdP) does not support wildcard URIs.

## Decision

1. **Dynamic redirect (no explicit `redirect_uri`):**

   - Omit `redirect_uri` in the plugin config.
   - Kong will derive it from the request URL and fallback to the IdP’s wildcard capabilities.
   - **Use when** your IdP supports wildcard or range‑based redirect URIs.

2. **Static redirect (explicit `redirect_uri` + `login_action=redirect`):**

   - Set `redirect_uri` to a fixed path (e.g. `/something-static`).
   - Include `login_action=redirect` and `preserve_query_args=true` so that on return Kong issues a 302 redirect to replay the original request (minus OIDC query params).
   - **Use when** your IdP does **not** support wildcards or when you want full control over the post‑login URL.

3. **Flow‐pattern architectures:**
   - **Centralized‑endpoints model** (recommended for complex apps):
     - `/login` plugin with `auth_methods=authorization_code` and `redirect_uri=/login/verify`
     - `/login/verify` plugin with `auth_methods=authorization_code,session` and `login_redirect_uri=/`
     - `/` plugin with `auth_methods=session` only
     - `/logout` plugin with `auth_methods=session` and `logout_redirect_uri=/login`
   - **Single‑endpoint model** (recommended for simple sites):
     - One OIDC plugin at `/` with `auth_methods=authorization_code,session`
     - Omit `redirect_uri` and `login_redirect_uri`—every path is a login page
     - Optionally set `logout_redirect_uri` to a static path (e.g. `/logout`)

## Alternatives Considered

- **Multiple cookies/session_audience:** supports multi‑login but adds complexity in cookie management and single‑logout semantics.

## Consequences

### Positive Outcomes

- **Dynamic** mode minimizes config when IdP supports wildcards.
- **Static** mode works reliably on any IdP and gives full control over redirect logic.
- **Centralized‑endpoints** model cleanly separates authorization, session setup, and logout.
- **Single‑endpoint** model is simpler to configure for small apps.

### Risks & Trade‑offs

- Relying on IdP wildcards can fail if wildcard support is removed or mis‑configured.
- Static redirects require maintaining extra config flags (`login_action=redirect`, `preserve_query_args`).
- Centralized model demands multiple plugin instances with synchronized parameters.
- Single‑endpoint model may mix authorization and session concerns on every path.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0026-oidc-plugin-redirect-uri-and-flow-pattern-best-practices.md)
- [OpenID Connect Plugin](https://docs.konghq.com/hub/kong-inc/openid-connect/)
- [Authentication Reference](https://docs.konghq.com/gateway/latest/kong-enterprise/auth/)
