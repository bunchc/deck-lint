# Operational Hygiene Rules

These rules are for general configuration correctness, helping to avoid common operational pitfalls and maintain a clean, auditable setup. Mention examples like preventing wildcard routes and requiring explicit route matching.

## Rules

| Rule File                                                                          | Description                                                                                                                                  |
| ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| [`avoid-kongclusterplugin-overload.yaml`](./avoid-kongclusterplugin-overload.yaml) | Discourages the use of KongClusterPlugin as a global configuration mechanism in Gateway API environments to prevent unintended side effects. |
| [`disallow-unused-consumers.yaml`](./disallow-unused-consumers.yaml)               | Flags consumers that are not associated with any credentials or ACLs to reduce security risks and configuration clutter.                     |
| [`enforce-kic-gateway-mapping.yaml`](./enforce-kic-gateway-mapping.yaml)           | Ensures a one-to-one mapping between a KIC instance and a Gateway resource for deterministic behavior.                                       |
| [`enforce-real-ip-forwarding.yaml`](./enforce-real-ip-forwarding.yaml)             | Requires forwarding of the real client IP address from the load balancer to Kong.                                                            |
| [`enforce-resource-limits.yaml`](./enforce-resource-limits.yaml)                   | Requires that resource limits and requests are applied to Kong control and data planes.                                                      |
| [`no-wildcard-hosts.yaml`](./no-wildcard-hosts.yaml)                               | Prevents the use of wildcard hosts in routes to avoid overly broad request matching and potential security risks.                            |
| [`prevent-open-proxies.yaml`](./prevent-open-proxies.yaml)                         | Enforces explicit service and route matching to prevent Kong from acting as an open proxy.                                                   |
| [`require-catch-all-route.yaml`](./require-catch-all-route.yaml)                   | Mandates a default catch-all route to safely handle unmatched requests.                                                                      |
| [`require-dedicated-gatewayclass.yaml`](./require-dedicated-gatewayclass.yaml)     | Enforces the use of a dedicated GatewayClass for each Kong Ingress Controller (KIC) deployment to ensure tenant isolation.                   |
| [`require-explicit-route-matching.yaml`](./require-explicit-route-matching.yaml)   | Ensures that routes have specific matching criteria, such as hosts, paths, or methods, to prevent unpredictable routing behavior.            |
| [`require-readiness-probes.yaml`](./require-readiness-probes.yaml)                 | Mandates the use of readiness probes with the request-termination plugin for reliable health checks.                                         |
