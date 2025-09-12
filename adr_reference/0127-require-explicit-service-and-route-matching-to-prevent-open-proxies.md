# 127. Require Explicit Service and Route Matching to Prevent Open Proxies

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authorization, routing, open-proxy, request-termination, best-practices, compliance, audit

## Status

Accepted

Basis for [128. Require Default Catch-All Route to Handle Unmatched Requests Safely](0128-require-default-catch-all-route-to-handle-unmatched-requests-safely.md)

## Context

In Kong Gateway, services and routes determine how incoming traffic is matched and forwarded to upstream targets. If route matching is overly permissive or left unspecified (e.g., catch-all wildcards), Kong could unintentionally expose:

- An open proxy behavior (routing arbitrary traffic to backends)
- Unauthorized access to internal APIs
- Shadow services that are not formally documented or secured

To prevent abuse and enforce security best practices, services and routes must be explicitly defined with narrow, predictable matching patterns.

## Decision

Require all Kong routes to specify explicit matching rules by host, path, or method, and avoid wildcard matching unless it is tightly controlled.

### Implementation Guidelines

#### 1. Specify Host and Path Matching

Prefer specific hostnames and API paths:

```yaml
routes:
  - name: billing-api
    protocols:
      - https
    hosts:
      - api.company.com
    paths:
      - /billing
```

Avoid routes without `hosts`, `paths`, or `snis` unless absolutely necessary.

#### 2. Avoid Wildcard Catch-All Routes

Reject or carefully scope:

- `paths: ["/"]`
- `hosts: ["*"]`
- Catch-all services without authorization plugins attached

If a wildcard route is needed (e.g., default 404 handler), apply explicit termination (e.g., `request-termination` plugin) to prevent proxy behavior.

#### 3. Protect Kong Default Route Behavior

If no route matches:

- Configure a catch-all route that terminates the request with a controlled error (e.g., `404 Not Found`).
- Alternatively, use the `request-termination` plugin to immediately reject.

Example:

```yaml
plugins:
  - name: request-termination
    config:
      status_code: 404
      message: "Route not found."
```

#### 4. Validate Routing Policies During Reviews

- Implement CI checks to flag routes without match criteria
- Audit route configurations periodically
- Use automated tools (e.g., decK validation) to enforce standards

#### 5. Document All Exposed APIs

Maintain a service registry or use an API catalog to document:

- Hostnames
- Paths
- Methods
- Ownership

Ensure documentation matches the deployed routes.

## Consequences

### Positive Outcomes

- Eliminates the risk of Kong behaving as an unintentional open proxy
- Strengthens the security model by enforcing API exposure control
- Simplifies operational audits and documentation

### Risks and Trade-offs

- Additional effort required for defining and maintaining explicit matches
- Increases complexity for dynamic routing scenarios (e.g., API gateways for multiple services)

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0127-require-explicit-service-and-route-matching-to-prevent-open-proxies.md)

- [Kong Routes Documentation](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/create-route)
- [Request Termination Plugin](https://docs.konghq.com/hub/kong-inc/request-termination/)
