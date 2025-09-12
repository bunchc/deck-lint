# 99. Use Health Probes and Request Termination for Readiness Checks

Date: 2025-04-25

## Tags

kong, api, plugin, kubernetes, health-checks, readiness, liveness, availability, orchestration, request-termination

## Status

Accepted

Implements [107. Configure Active and Passive Health Checks for Upstream Services](0107-configure-active-and-passive-health-checks-for-upstream-services.md)

## Context

In Kubernetes or containerized environments, health probes are used to determine whether a service is alive and ready to receive traffic. Without reliable health checks, orchestrators like Kubernetes might prematurely route traffic to unready Kong nodes, causing request failures and degraded availability.

Relying solely on default TCP checks or admin API endpoints is insufficient, especially in production where plugin logic may impact readiness. A more resilient approach is to explicitly configure an HTTP route with the `request-termination` plugin that always returns a known 200 status.

## Decision

Create a dedicated `Service` and `Route` in Kong, tagged or named for health checks. Attach the `request-termination` plugin configured to return `200 OK`. Configure Kubernetes or external orchestrators to use this endpoint for liveness and readiness checks.

### Example Kong configuration

```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: health-check
config:
  status_code: 200
  message: "OK"
plugin: request-termination
---
apiVersion: configuration.konghq.com/v1
kind: KongIngress
metadata:
  name: health-path
route:
  paths:
    - /healthz
---
apiVersion: v1
kind: Service
metadata:
  name: kong-health
spec:
  selector:
    app: kong
  ports:
    - name: http
      port: 80
      targetPort: 8000
```

Use /healthz as the probe in Kubernetes:

```yaml
readinessProbe:
  httpGet:
    path: /healthz
    port: 8000
  initialDelaySeconds: 5
  periodSeconds: 10
```

## Consequences

### Positive Outcomes

- Guarantees that readiness check is isolated from business logic or backend state.
- Ensures orchestrators only route traffic to healthy Kong nodes.
- Reduces false positives from admin or proxy-level metrics during startup or reload.

### Risks and Trade-offs

- Requires additional configuration and resource tracking.
- Must ensure this route is not externally exposed unintentionally.
- Developers must avoid customizing the /healthz endpoint without coordination.

### References

- [Request Termination Plugin](https://docs.konghq.com/hub/kong-inc/request-termination/)
- [Kong Kubernetes Probes](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/high-availability/health-checks/)

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0099-use-health-probes-and-request-termination-for-readiness-checks.md)
