# Operational Hygiene Rules

These rules help you keep your API gateway configuration clean, secure, and reliable. They prevent common problems, lower security risks, and make the gateway easier to manage and audit. Following these rules helps you avoid bad configurations that can cause downtime, security holes, and strange behavior.

This section covers rules for clear route matching, avoiding wildcard hosts, and making sure all resources are set up and secured correctly. Following these rules is key to a healthy and stable API gateway.

## Rules

| Rule File                                                                          | Name                                   | Description                                                                                                    |
| ---------------------------------------------------------------------------------- | -------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [`avoid-kongclusterplugin-overload.yaml`](./avoid-kongclusterplugin-overload.yaml) | `avoid-kongclusterplugin`              | Avoids using `KongClusterPlugin` in Gateway API setups to prevent issues. Use more specific plugin scoping.    |
| [`disallow-unused-consumers.yaml`](./disallow-unused-consumers.yaml)               | `disallow-unused-consumers`            | Finds consumers with no credentials or ACLs to cut down on security risks and messy configurations.            |
| [`enforce-kic-gateway-mapping.yaml`](./enforce-kic-gateway-mapping.yaml)           | `kic-gateway-mapping`                  | Makes sure there is a single KIC instance for each Gateway resource to keep behavior predictable.              |
| [`enforce-real-ip-forwarding.yaml`](./enforce-real-ip-forwarding.yaml)             | `enforce-real-ip-forwarding`           | Makes sure the real client IP is sent from the load balancer to Kong for correct client identification.        |
| [`enforce-resource-limits.yaml`](./enforce-resource-limits.yaml)                   | `enforce-resource-limits`              | Requires resource limits and requests for Kong's control and data planes to ensure stable resource use.        |
| [`no-wildcard-hosts.yaml`](./no-wildcard-hosts.yaml)                               | `no-wildcard-hosts`                    | Stops the use of wildcard hosts in routes to prevent overly broad request matching and security risks.         |
| [`prevent-open-proxies.yaml`](./prevent-open-proxies.yaml)                         | `prevent-open-proxies`                 | Enforces clear service and route matching to stop Kong from acting as an open proxy, which is a security risk. |
| [`require-catch-all-route.yaml`](./require-catch-all-route.yaml)                   | `require-catch-all-route`              | Requires a default catch-all route to handle unmatched requests safely and prevent odd routing behavior.       |
| [`require-dedicated-gatewayclass.yaml`](./require-dedicated-gatewayclass.yaml)     | `gatewayclass-unique-controller`       | Enforces a separate `GatewayClass` for each Kong Ingress Controller (KIC) to keep tenants isolated.            |
| [`require-explicit-route-matching.yaml`](./require-explicit-route-matching.yaml)   | `require-explicit-route-matching`      | Makes sure routes have clear matching rules (like hosts, paths, or methods) to avoid unpredictable routing.    |
| [`require-readiness-probes.yaml`](./require-readiness-probes.yaml)                 | `readiness-probes-request-termination` | Requires readiness probes with the `request-termination` plugin for good health checks and smooth shutdowns.   |
