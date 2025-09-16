# Security Rules

This folder holds rules to secure your Kong Gateway. These rules help you avoid common security mistakes.

The rules cover many security topics:

*   **Encryption**: Use TLS for all connections.
*   **Authentication**: Require login on all routes. Set up OIDC and JWT securely.
*   **Authorization**: Use proper RBAC and ACLs.
*   **Data Protection**: Stop leaks of secret data.
*   **Admin API Security**: Secure the Admin API.

## Rules

This table lists all security rules.

| Rule Name                                    | Rule File                                                                                              | Description                                                                            |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| `disallow-debug-headers-in-prod`             | [`disallow-debug-headers-in-prod.yaml`](./disallow-debug-headers-in-prod.yaml)                         | Finds production routes that use debug headers.                                        |
| `oidc-disallow-http-issuer`                  | [`disallow-http-for-oidc.yaml`](./disallow-http-for-oidc.yaml)                                         | OIDC issuer must use HTTPS.                                                            |
| `disallow-http-protocol-for-upstreams`       | [`disallow-http-protocol-for-upstreams.yaml`](./disallow-http-protocol-for-upstreams.yaml)             | Upstream services must use HTTPS.                                                      |
| `insecure-admin-api`                         | [`disallow-insecure-admin-api.yaml`](./disallow-insecure-admin-api.yaml)                               | Admin API routes must use TLS and a login plugin.                                      |
| `disallow-key-auth-insecure`                 | [`disallow-key-auth-insecure.yaml`](./disallow-key-auth-insecure.yaml)                                 | Avoids the 'key-auth' plugin, which stores keys in plain text.                         |
| `disallow-sensitive-info-in-uris`            | [`disallow-sensitive-info-in-uris.yaml`](./disallow-sensitive-info-in-uris.yaml)                       | Looks for secret patterns in route URIs.                                               |
| `disallow-unauthenticated-routes`            | [`disallow-unauthenticated-routes.yaml`](./disallow-unauthenticated-routes.yaml)                       | All routes must have a login plugin.                                                   |
| `enforce-acl-on-protected-routes`            | [`enforce-acl-on-protected-routes.yaml`](./enforce-acl-on-protected-routes.yaml)                       | Protected routes must use the ACL plugin.                                              |
| `oidc-enforce-dpop-validation`               | [`enforce-dpop-validation.yaml`](./enforce-dpop-validation.yaml)                                       | OIDC plugin must use DPoP validation.                                                  |
| `jwt-claims-validation`                      | [`enforce-jwt-claim-validation.yaml`](./enforce-jwt-claim-validation.yaml)                             | JWT plugin must check 'exp' and 'nbf' claims.                                          |
| `rbac-least-privilege`                       | [`enforce-rbac-least-privilege.yaml`](./enforce-rbac-least-privilege.yaml)                             | Warns if a consumer has a role like 'super-admin'.                                     |
| `enforce-request-size-limiting`              | [`enforce-request-size-limiting.yaml`](./enforce-request-size-limiting.yaml)                           | Public routes must have the request-size-limiter plugin.                               |
| `enforce-https-for-all-routes`               | [`enforce-tls-for-all-connections.yaml`](./enforce-tls-for-all-connections.yaml)                       | All routes must use HTTPS.                                                             |
| `enforce-upstream-tls-validation`            | [`enforce-upstream-tls-validation.yaml`](./enforce-upstream-tls-validation.yaml)                       | Upstream services using HTTPS must have TLS validation on.                             |
| `require-bot-detection-on-public-forms`      | [`require-bot-detection-on-public-forms.yaml`](./require-bot-detection-on-public-forms.yaml)           | Public forms must use the bot-detection plugin.                                        |
| `oidc-client-secret-in-vault`                | [`require-client-secret-in-vault.yaml`](./require-client-secret-in-vault.yaml)                         | OIDC 'client_secret' must be loaded from Kong Vault.                                   |
| `require-ip-restriction-on-sensitive-routes` | [`require-ip-restriction-on-sensitive-routes.yaml`](./require-ip-restriction-on-sensitive-routes.yaml) | Sensitive routes must use the ip-restriction plugin.                                   |
| `admin-api-require-ip-restriction`           | [`require-ip-restrictions-for-admin-api.yaml`](./require-ip-restrictions-for-admin-api.yaml)           | Kong Admin API must be protected by the 'ip-restriction' plugin.                       |
| `upstream-mtls-required`                     | [`require-mtls-for-upstreams.yaml`](./require-mtls-for-upstreams.yaml)                                 | Upstream services must use mutual TLS (mTLS).                                          |
| `require-response-filtering-for-pii`         | [`require-response-filtering-for-pii.yaml`](./require-response-filtering-for-pii.yaml)                 | Routes with 'pii' must use a response transformation plugin.                           |
| `require-secure-upstream-tls`                | [`require-secure-upstream-tls.yaml`](./require-secure-upstream-tls.yaml)                               | A service using HTTPS upstream must have 'tls_verify' on and a 'ca_certificates' list. |
