# 100. Forward Real Client IP from Load Balancer

Date: 2025-04-25

## Tags

kong, gateway, plugin, security, deployment, kubernetes, client-ip, x-forwarded-for, real-ip, trusted-ips, load-balancer, observability

## Status

Accepted

## Context

When Kong is deployed behind a load balancer or ingress controller, the actual client IP address can be masked or overwritten. Many Kong plugins, such as rate limiting, ACL, geolocation, or logging, depend on the client IP to function accurately.

Without proper IP forwarding configuration, plugins may incorrectly treat all requests as originating from the same IP (i.e., the load balancer), leading to inaccurate policy enforcement or logs.

## Decision

Ensure the load balancer is configured to **preserve and forward the real client IP address** using the appropriate header (commonly `X-Forwarded-For` or `X-Real-IP`).

Kong should then be configured to **trust the IP address forwarded by the load balancer** by setting:

```yaml
trusted_ips:
  - <load-balancer-ip>/32
real_ip_header: X-Forwarded-For
real_ip_recursive: on
```

In Kubernetes, use an environment variable in the Kong deployment:

```yaml
env:
  - name: KONG_TRUSTED_IPS
    value: "0.0.0.0/0" # or restrict to known LB IPs
  - name: KONG_REAL_IP_HEADER
    value: "X-Forwarded-For"
  - name: KONG_REAL_IP_RECURSIVE
    value: "on"
```

## Consequences

### Positive Outcomes

- Enables accurate enforcement of rate limiting, ACLs, and geo-IP plugins.
- Ensures logging and analytics tools reflect the true origin of traffic.
- Mitigates security blind spots introduced by generic IPs.

### Risks and Trade-offs

- Misconfiguration could allow spoofed headers if the LB isn’t secured.
- Requires network trust between Kong and the load balancer.
- Must keep trusted IP list up to date in case of changes to infrastructure.

### References

- [Kong Proxy Listen and IP Headers](https://docs.konghq.com/gateway/2.8.x/reference/configuration/#real_ip_header)
- [Trusted IPs Configuration](https://docs.konghq.com/gateway/2.8.x/reference/configuration/#trusted_ips)

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0100-forward-real-client-ip-from-load-balancer.md)
