# 128. Require Default Catch-All Route to Handle Unmatched Requests Safely

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, deployment, monitoring, routing, catch-all, request-termination, error-handling, best-practices, compliance

## Status

Accepted

Builds on [127. Require Explicit Service and Route Matching to Prevent Open Proxies](0127-require-explicit-service-and-route-matching-to-prevent-open-proxies.md)

## Context

If an incoming request to Kong Gateway does not match any configured route, Kong by default returns a `404 Not Found` response. However, in complex deployments — especially those involving dynamic routing, wildcard domains, or multi-tenant environments — failure to define an explicit catch-all route can create uncertainty about:

- Whether unmatched traffic is handled consistently
- How error responses are formatted for clients
- Whether misrouted or invalid traffic could still propagate into infrastructure layers

Explicitly handling unmatched traffic improves security, stability, and operational transparency.

## Decision

Define an explicit catch-all route in Kong that terminates unmatched requests safely, returning a controlled error message and preventing accidental exposure of internals.

### Implementation Guidelines

#### 1. Create a Catch-All Route

Define a low-priority fallback route that matches all traffic:

```yaml
routes:
  - name: default-catch-all
    protocols:
      - http
      - https
    paths:
      - /
    strip_path: false
    priority: 0
    service:
      name: default-catch-service
```

#### 2. Attach Request Termination Plugin

Attach the `request-termination` plugin to the default service:

```yaml
plugins:
  - name: request-termination
    config:
      status_code: 404
      message: "Resource not found."
```

This ensures the fallback route returns a controlled 404 or custom error without attempting to proxy to any upstream.

#### 3. Set Priority Properly

Ensure the catch-all route has the lowest possible priority compared to all other business-critical routes. Explicit matches (paths, hosts, methods) should always take precedence.

#### 4. Customize Error Responses if Needed

For developer experience or brand consistency:

- Customize the termination message
- Return a JSON body if serving API clients:

```json
{
  "error": "Not Found",
  "message": "The requested resource was not found."
}
```

- Set appropriate `Content-Type: application/json` headers if needed.

#### 5. Monitor and Alert on Catch-All Traffic

Track catch-all route usage via:

- Prometheus metrics (`kong_http_requests_total{route="default-catch-all"}`)
- Access logs
- Alerts if high rates of unmatched traffic occur (indicating misconfigured clients or potential attacks)

## Consequences

### Positive Outcomes

- Prevents leaking unhandled traffic deeper into the infrastructure
- Provides consistent, predictable client responses for invalid requests
- Improves security posture by denying unauthorized or misrouted requests
- Simplifies debugging and operational metrics

### Risks and Trade-offs

- May mask routing issues if alerting/monitoring is not configured
- Requires careful priority management across routes
- Minor maintenance overhead if multiple APIs evolve their routing schemes

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0128-require-default-catch-all-route-to-handle-unmatched-requests-safely.md)

- [Request Termination Plugin](https://docs.konghq.com/hub/kong-inc/request-termination/)
- [Kong Route Object Documentation](https://docs.konghq.com/gateway/latest/admin-api/#route-object)
