# 110. Disable Unused Kong Ports and Protocols

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, monitoring, hardening, ports, protocols, zero-trust, compliance, network

## Status

Accepted

## Context

Kong Gateway supports multiple listener ports and protocols out-of-the-box, including HTTP/HTTPS for proxy traffic, Admin API access, and metrics exposure. However, enabling unused or unnecessary ports increases the gateway's attack surface and can violate security compliance standards.

For example:

- Exposing the Admin API on a public interface
- Running both HTTP and HTTPS proxy ports when only one is needed
- Keeping open the default status port (`:8100`) without monitoring in place

To reduce risk and align with production hardening standards, only the required listeners should be enabled.

## Decision

Disable unused Kong ports and protocols in all production environments.

### Recommended Actions

#### 1. Define Proxy Ports Explicitly

Only enable proxy ports actually in use:

```yaml
env:
  - name: KONG_PROXY_LISTEN
    value: "0.0.0.0:8443 ssl" # HTTPS only
```

If HTTP is required (e.g., for ACME challenges), restrict exposure via security groups or ingress rules.

#### 2. Limit Admin API Exposure

Only bind the Admin API to private networks or localhost:

```yaml
env:
  - name: KONG_ADMIN_LISTEN
    value: "127.0.0.1:8001"
```

If remote Admin API access is required, ensure TLS is enabled and authentication is enforced.

#### 3. Disable Status or Metrics Ports Unless Used

The status listener on port `8100` can be disabled unless needed for health checks:

```yaml
env:
  - name: KONG_STATUS_LISTEN
    value: "off"
```

Expose Prometheus metrics only if the `prometheus` plugin is configured and protected:

```yaml
plugins:
  - name: prometheus
```

## Consequences

### Positive Outcomes

- Reduces exposed ports and protocol surfaces
- Aligns with zero-trust and least privilege principles
- Helps meet security audit and compliance standards

### Risks and Trade-offs

- Disabling necessary ports without testing can break automation or tooling
- Requires inventory and validation of ports used by observability and operations

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0110-disable-unused-kong-ports-and-protocols.md)

- [Default Kong Port Configuration](https://docs.konghq.com/gateway/latest/production/networking/default-ports/#main)
