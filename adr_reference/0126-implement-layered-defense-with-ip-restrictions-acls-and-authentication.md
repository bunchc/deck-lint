# 126. Implement Layered Defense with IP Restrictions, ACLs, and Authentication

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, authorization, kubernetes, defense-in-depth, ip-restriction, acl, zero-trust, access-control, multi-layer-security, mtls, oauth2, jwt, hardening, compliance

## Status

Accepted

## Context

Exposing APIs through Kong Gateway without layered access controls leaves systems vulnerable to unauthorized access, data exfiltration, and denial-of-service attacks. Relying on a single line of defense (such as IP whitelisting or authentication alone) is insufficient against modern attack vectors.

Layered security—combining network-level restrictions, application-layer access control lists (ACLs), and strong authentication—is necessary to minimize risks and meet enterprise security and compliance requirements.

## Decision

Enforce a layered defense model for all Kong-managed APIs, combining:

- IP restrictions
- ACL plugin enforcement
- API key, JWT, OAuth2, or mTLS authentication
- Optional authorization scopes at the route or consumer level

### Implementation Guidelines

#### 1. Apply IP Restrictions at Network and API Gateway Level

Use Kubernetes Network Policies, cloud-native security groups, or physical firewalls to restrict inbound sources.

Apply Kong's `ip-restriction` plugin for fine-grained per-API control:

```bash
curl -X POST http://localhost:8001/services/my-service/plugins \
  --data "name=ip-restriction" \
  --data "config.whitelist=203.0.113.0/24"
```

Allow traffic only from trusted CIDR ranges.

#### 2. Require Authentication for All APIs

Use appropriate authentication strategies:

- Public APIs: API Key (`key-auth` plugin)
- Private APIs: OAuth2 (`openid-connect` plugin) or JWT
- Internal APIs: mTLS (`mtls-auth` plugin)

Example (OAuth2 via OpenID Connect):

```bash
curl -X POST http://localhost:8001/services/private-api/plugins \
  --data "name=openid-connect" \
  --data "config.issuer=https://auth.company.com/"
```

#### 3. Enforce ACL Groups per Consumer

Use the `acl` plugin to control access by logical group:

```bash
curl -X POST http://localhost:8001/services/finance-api/plugins \
  --data "name=acl" \
  --data "config.allow=finance-team"
```

Consumers must belong to specific groups to access sensitive APIs.

#### 4. Implement Authorization with Claims or Scopes

For advanced policies, use:

- JWT claims to enforce RBAC
- OAuth2 scopes to restrict access to specific resources
- Custom plugins or PDK logic if necessary

#### 5. Secure Admin APIs Separately

Admin API access must have stricter controls (see ADRs on Admin API security).

## Consequences

### Positive Outcomes

- Strong defense against unauthorized access and lateral movement
- Fine-grained control over API exposure
- Supports regulatory and compliance requirements (e.g., GDPR, HIPAA, PCI-DSS)

### Risks and Trade-offs

- Misconfigured ACLs or IP restrictions could block legitimate traffic
- Complex rule combinations require thorough testing and review
- Risk of stale consumer group assignments if not managed properly

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0126-implement-layered-defense-with-ip-restrictions-acls-and-authentication.md)

- [IP Restriction Plugin](https://docs.konghq.com/hub/kong-inc/ip-restriction/)
- [ACL Plugin](https://docs.konghq.com/hub/kong-inc/acl/)
- [Authentication Plugins Overview](https://docs.konghq.com/hub/?category=authentication)
