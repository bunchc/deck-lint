# 201. Ensure Zero Downtime by Kong Gateway on Azure AKS with Standard Load Balancer

Date: 2025-06-16

## Tags

kubernetes, aks, standard-load-balancer, zero-downtime, lifecycle, probes, graceful-shutdown, azure

## Status

Accepted

## Context

When running Kong Gateway on Azure AKS behind a Standard Load Balancer, rolling updates can briefly disrupt in-flight requests unless the old pod is drained gracefully. The `kong drain` command flips readiness immediately, and the `kong quit` command gracefully shuts down in-flight connections. We need a standardized, predictable procedure to:

* Immediately remove a terminating pod from service.
* Drain existing connections without forcing errors.
* Ensure Kubernetes and NLB health checks detect the pod as unhealthy within defined windows.
* Complete shutdown within Kubernetes’ `terminationGracePeriodSeconds`.

## Decision

We will adopt a standardized pod termination lifecycle that leverages Kubernetes’ PreStop hook, tuned readiness and liveness probes, and specific AKS Load Balancer annotations. The steps are:

1. **PreStop Hook & Pod Lifecycle**

   Configure each Kong Gateway pod with:

   ```yaml
   spec:
     terminationGracePeriodSeconds: 40  # 5s readiness flip + 30s graceful quit + 5s buffer
     containers:
     - name: proxy
       image: kong:3.10
       lifecycle:
         preStop:
           exec:
             command:
               - sh
               - -c
               - |
                 # 1) Flip readiness immediately
                 kong drain
                 # 2) Wait for K8s & NLB to detect 503s
                 sleep 5
                 # 3) Begin graceful quit (in-flight drain up to 30s)
                 kong quit --wait=30
   ```

   * `kong drain` makes `/status/ready` return 503 immediately.
   * `sleep 5` allows readiness probes and Load Balancer health checks to observe failures.
   * `kong quit --wait=30` stops accepting new connections and drains existing ones for up to 30 s.

2. **Readiness & Liveness Probes**

   **Readiness Probe**:

   ```yaml
   readinessProbe:
     httpGet:
       path: /status/ready
       port: status
       scheme: HTTP
     initialDelaySeconds: 3
     periodSeconds: 2
     timeoutSeconds: 5
     failureThreshold: 3
     successThreshold: 1
   ```

   * Fails at t = 3 s, 5 s, 7 s → NotReady by \~7 s after start of checks.
   * If `kong drain` at t = 0, first failing probe at t = 3 s.

   **Liveness Probe**:

   ```yaml
   livenessProbe:
     httpGet:
       path: /status
       port: status
     initialDelaySeconds: 20
     periodSeconds: 10
     timeoutSeconds: 5
     failureThreshold: 3
   ```

   * Detects hung Kong processes and triggers restarts after \~30 s of consecutive failures.

3. **AWS NLB Health Check & Target Group**

   Annotate the Service:

   ```yaml
   annotations:
     service.beta.kubernetes.io/port_8100_health-probe_protocol:     "Http"
     service.beta.kubernetes.io/port_8100_health-probe_port:         "8100"
     service.beta.kubernetes.io/port_8100_health-probe_interval:     "5"
     service.beta.kubernetes.io/port_8100_health-probe_num-of-probe:  "2"
     service.beta.kubernetes.io/port_8100_health-probe_request-path: "/status/ready"
   externalTrafficPolicy: Local
   ```

   * Protocol & port: Explicitly set HTTP on port 8100.
   * Interval: Health probes every 5 s.
   * Unhealthy threshold (num-of-probe=2): marks backend Unhealthy after ~10 s (2 consecutive failures).
   * Request path: /status/ready returns 200 when healthy, 503 after kong drain.

> **Tip:** If you expose multiple service ports, use the same port_{port}_... pattern per port. Ensure you do not set port_{port}_no_lb_rule or port_{port}_no_probe_rule on your status port, or the LB will ignore it.

4. **Sequence Diagram**

```mermaid
sequenceDiagram
  participant K8s
  participant Kong
  participant ALB as Azure LB
  participant Client

  K8s->>Kong: preStop: kong drain at t=0s
  note right of Kong: /status/ready → 503 immediately

  loop Readiness Probes @3-7s
    K8s->>Kong: GET /status/ready
    Kong-->>K8s: 503 → NotReady at ~3s
  end

  loop Azure LB Health @0s,5s
    ALB->>Kong: HTTP Probe /status/ready
    Kong-->>ALB: 503 → Unhealthy at ~10s (2 failures)
  end

  K8s->>Kong: sleep 5s (allow detections)
  K8s->>Kong: kong quit --wait=30 at ~5s
  note right of Kong: drain in-flight connections until ~35s

  Kong->>K8s: exit at ~35s
  K8s->>Kong: SIGKILL at 40s

  Client->>ALB: new requests routed elsewhere after ~10s
```

## Consequences

### Positive Outcomes

* **Zero-Downtime Deployments**: Existing requests are drained gracefully; new clients see no errors.
* **Predictable Cutovers**: Timing windows (5 s readiness, 30 s drain) are well-defined and repeatable.
* **Clear Observability**: Probes and NLB statuses clearly reflect pod readiness and health.
* **Kubernetes-Native**: Leverages built-in hooks and probe mechanisms without external controllers.

### Risks

* **Timing Misconfiguration**: If `terminationGracePeriodSeconds` < (sleep + wait + buffer), pods may be killed before drains complete.
* **Complexity**: Multiple tuned parameters (probes, sleep, deregistration delays) increase cognitive overhead.
* **Resource Pressure**: During rolling updates, old pods linger up to 40 s after shutdown begins, requiring capacity planning.
* **Dependency on Kong 3.10**: Older versions lack `kong drain`; must upgrade all clusters.

## References

* [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0201-ensure-zero-downtime-by-kong-gateway-on-azure-aks-with-standard-load-balancer.md)
