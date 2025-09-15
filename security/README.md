# Security Rules

This directory contains Spectral rules focused on enforcing security best practices for Kong Gateway configurations. Examples include requiring mTLS, securing the Admin API, and enforcing least-privilege RBAC.

## Rules

| Rule File                                                                                              | Description                                                                                                                        |
| ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| [`disallow-debug-headers-in-prod.yaml`](./disallow-debug-headers-in-prod.yaml)                         | Flags routes tagged as production ('env:prod') that are configured to add or echo debug headers.                                   |
| [`disallow-http-for-oidc.yaml`](./disallow-http-for-oidc.yaml)                                         | Ensures that the OpenID Connect (OIDC) plugin is configured with an issuer endpoint that uses HTTPS.                               |
| [`disallow-http-protocol-for-upstreams.yaml`](./disallow-http-protocol-for-upstreams.yaml)             | Upstream services must use the 'https' protocol.                                                                                   |
| [`disallow-insecure-admin-api.yaml`](./disallow-insecure-admin-api.yaml)                               | Flags Admin API routes that are not secured with TLS and an authentication plugin.                                                 |
| [`disallow-key-auth-insecure.yaml`](./disallow-key-auth-insecure.yaml)                                 | Flags the use of the 'key-auth' plugin, which stores API keys in plaintext.                                                        |
| [`disallow-sensitive-info-in-uris.yaml`](./disallow-sensitive-info-in-uris.yaml)                       | Scans for common sensitive patterns (e.g., 'api_key', 'token', 'password') in the URI paths of routes.                             |
| [`disallow-unauthenticated-routes.yaml`](./disallow-unauthenticated-routes.yaml)                       | All routes must have an authentication plugin enabled.                                                                             |
| [`enforce-acl-on-protected-routes.yaml`](./enforce-acl-on-protected-routes.yaml)                       | All routes tagged as 'protected' must have the ACL plugin enabled.                                                                 |
| [`enforce-dpop-validation.yaml`](./enforce-dpop-validation.yaml)                                       | Requires that the OIDC plugin is configured to enable DPoP (Demonstration of Proof-of-Possession) validation.                      |
| [`enforce-jwt-claim-validation.yaml`](./enforce-jwt-claim-validation.yaml)                             | Ensures that any JWT plugin is configured to validate the expiration time ('exp') and 'not before' ('nbf') claims.                 |
| [`enforce-rbac-least-privilege.yaml`](./enforce-rbac-least-privilege.yaml)                             | Warns if a consumer is assigned a role that is overly permissive, such as 'super-admin'.                                           |
| [`enforce-request-size-limiting.yaml`](./enforce-request-size-limiting.yaml)                           | All public-facing routes must have the request-size-limiter plugin configured.                                                     |
| [`enforce-tls-for-all-connections.yaml`](./enforce-tls-for-all-connections.yaml)                       | Ensures that all routes are configured to use the 'https' protocol.                                                                |
| [`enforce-upstream-tls-validation.yaml`](./enforce-upstream-tls-validation.yaml)                       | Upstream services using HTTPS must have TLS validation enabled.                                                                    |
| [`require-bot-detection-on-public-forms.yaml`](./require-bot-detection-on-public-forms.yaml)           | Routes tagged as 'public-form' or 'sensitive-flow' must have the bot-detection plugin enabled.                                     |
| [`require-client-secret-in-vault.yaml`](./require-client-secret-in-vault.yaml)                         | Ensures that the OIDC plugin's 'client_secret' is loaded from Kong Vault.                                                          |
| [`require-ip-restriction-on-sensitive-routes.yaml`](./require-ip-restriction-on-sensitive-routes.yaml) | Routes tagged as 'sensitive' or 'internal' must have the ip-restriction plugin.                                                    |
| [`require-ip-restrictions-for-admin-api.yaml`](./require-ip-restrictions-for-admin-api.yaml)           | Ensures that the Kong Admin API is protected by the 'ip-restriction' plugin.                                                       |
| [`require-mtls-for-upstreams.yaml`](./require-mtls-for-upstreams.yaml)                                 | Ensures that any upstream service is configured for mutual TLS (mTLS).                                                             |
| [`require-response-filtering-for-pii.yaml`](./require-response-filtering-for-pii.yaml)                 | Routes tagged with 'pii' must use a response transformation plugin.                                                                |
| [`require-secure-upstream-tls.yaml`](./require-secure-upstream-tls.yaml)                               | Ensures that any service using HTTPS for its upstream connection has 'tls_verify' enabled and a 'ca_certificates' list configured. |
