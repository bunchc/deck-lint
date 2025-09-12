# 106. Disable Debug Headers in Production Environments

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, monitoring, headers, response-transformer, observability, zero-trust, compliance, hardening

## Status

Accepted

## Context

By default, Kong Gateway may include various debug headers in its HTTP responses. These headers—such as `X-Kong-Upstream-Latency`, `X-Kong-Proxy-Latency`, `Via`, and `Server`—provide insight into Kong’s internal processing behavior and versioning.

While useful during development and testing, exposing such information in production can:

- Leak details about Kong’s internal architecture
- Aid attackers in fingerprinting or crafting targeted exploits
- Introduce compliance violations depending on data classification policies

Production systems must minimize information exposure through HTTP headers to reduce the surface area for reconnaissance and misconfiguration leakage.

## Decision

In production environments, disable or strip debug headers by default unless explicitly required for observability or monitoring purposes.

### Recommended Actions

#### 1. Disable Server and Via Headers

In `kong.conf` or Helm values:

```yaml
env:
  - name: KONG_HEADERS
    value: "off"
```

This disables the automatic injection of Server and Via headers.

2. Use response-transformer Plugin to Remove Additional Headers

If headers like X-Kong-Upstream-Latency or X-Kong-Proxy-Latency are not needed for end clients:

```shell
curl -X POST http://<admin-api>/plugins \
  --data "name=response-transformer" \
  --data "config.remove.headers[]=X-Kong-Upstream-Latency" \
  --data "config.remove.headers[]=X-Kong-Proxy-Latency"
```

Apply globally or per service/route depending on scope.

3. Mask Custom Diagnostic Headers (Optional)

For custom header logging (e.g., tracing or correlation IDs), ensure they are whitelisted and do not leak sensitive metadata.

## Consequences

### Positive Outcomes

- Reduces information leakage in production traffic
- Improves API surface security posture
- Aligns with zero-trust and minimal-disclosure design patterns

### Risks and Trade-offs

- Debugging live production issues may become harder without latency headers
- Must balance operational observability with data exposure risk
- Requires close collaboration with observability teams

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0106-disable-debug-headers-in-production-environments.md)

- [response-transformer Plugin](https://docs.konghq.com/hub/kong-inc/response-transformer/)
