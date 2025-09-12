# 107. Configure Active and Passive Health Checks for Upstream Services

Date: 2025-04-25

## Tags

kong, api, gateway, health-checks, upstream, load-balancing, resilience, availability, monitoring, failover

## Status

Accepted

Implemented by [99. Use Health Probes and Request Termination for Readiness Checks](0099-use-health-probes-and-request-termination-for-readiness-checks.md)

## Context

Kong Gateway routes traffic to upstream services, often through load balancing across multiple targets. In the absence of proper health checks, Kong may continue to send traffic to unhealthy or failing targets, resulting in degraded user experience or failed transactions.

Kong supports both active and passive health checks to detect and isolate unhealthy upstream targets. A production-ready configuration must leverage these capabilities to ensure resilience, reliability, and automated failover behavior.

## Decision

Enable and configure both active and passive health checks for all Kong upstream entities in production environments.

### Active Health Checks

Kong actively probes targets at configurable intervals to verify availability using either HTTP(S), TCP, or gRPC.

Example configuration:

```json
{
  "healthchecks": {
    "active": {
      "http_path": "/health",
      "timeout": 1,
      "concurrency": 10,
      "healthy": {
        "interval": 10,
        "http_statuses": [200],
        "successes": 3
      },
      "unhealthy": {
        "interval": 10,
        "http_statuses": [429, 404, 500, 502, 503],
        "http_failures": 2,
        "tcp_failures": 2,
        "timeouts": 2
      },
      "type": "http"
    }
  }
}
```

### Passive Health Checks

Passive checks monitor live traffic and mark targets as unhealthy based on real-time errors.

Example:

```json
"healthchecks": {
  "passive": {
    "unhealthy": {
      "http_failures": 5,
      "tcp_failures": 2,
      "timeouts": 3
    },
    "type": "http"
  }
}
```

Combine both checks for better fault detection and automatic recovery of healthy nodes.

## Consequences

### Positive Outcomes

- Reduces impact from failed or slow upstream services.
- Enables Kong to automatically reroute traffic away from unhealthy nodes.
- Improves availability and performance through real-time traffic shaping.

### Risks and Trade-offs

- Misconfigured thresholds may cause premature ejection of targets.
- Health check traffic adds slight load to upstream services.
- Complex upstream architectures may require custom tuning of checks.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0107-configure-active-and-passive-health-checks-for-upstream-services.md)

- [Kong Upstream and Health Checks](https://docs.konghq.com/gateway/latest/how-kong-works/health-checks/#main)
- [Load Balancing with Kong](https://docs.konghq.com/gateway/latest/how-kong-works/load-balancing/#main)
