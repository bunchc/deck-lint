# Resilience and Performance Rules

These rules help ensure high availability and optimal performance by enforcing best practices for timeouts, retries, and health checks.

## Rules

| Rule File                                                                                      | Description                                                                                                                                 |
| ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| [`disallow-excessive-retries.yaml`](./disallow-excessive-retries.yaml)                         | Prevents configuring more than 3 retries on a service to avoid cascading failures.                                                          |
| [`disallow-excessive-service-retries.yaml`](./disallow-excessive-service-retries.yaml)         | Limits the number of retries for a service to a maximum of 2 to prevent overwhelming upstream services.                                     |
| [`enforce-circuit-breaker-config.yaml`](./enforce-circuit-breaker-config.yaml)                 | Ensures that all services have a circuit breaker plugin configured to prevent cascading failures.                                           |
| [`enforce-dp-timeout-resilience.yaml`](./enforce-dp-timeout-resilience.yaml)                   | Ensures that `cluster_control_plane_timeout` and `cluster_data_plane_purge_delay` are configured for data planes in hybrid mode.            |
| [`enforce-production-timeouts.yaml`](./enforce-production-timeouts.yaml)                       | Validates that 'connect_timeout', 'read_timeout', and 'write_timeout' are set to reasonable values for production environments.             |
| [`enforce-rate-limiting-sync-rate.yaml`](./enforce-rate-limiting-sync-rate.yaml)               | Enforces a minimum `sync_rate` of 1 second for the `rate-limiting-advanced` and `service-protection` plugins.                               |
| [`enforce-service-timeouts.yaml`](./enforce-service-timeouts.yaml)                             | Ensures that all services have `connect_timeout`, `read_timeout`, and `write_timeout` properties configured.                                |
| [`recommend-passive-healthchecks.yaml`](./recommend-passive-healthchecks.yaml)                 | Recommends the use of passive health checks for all upstream services to supplement active health checks.                                   |
| [`recommend-sliding-window-rate-limiting.yaml`](./recommend-sliding-window-rate-limiting.yaml) | Recommends the use of the sliding window algorithm for rate limiting to ensure stricter enforcement.                                        |
| [`require-active-healthchecks.yaml`](./require-active-healthchecks.yaml)                       | Mandates that all upstream services have active health checks configured.                                                                   |
| [`require-healthchecks-for-upstreams.yaml`](./require-healthchecks-for-upstreams.yaml)         | Ensures that all upstream services have active health checks configured to detect and route traffic away from unhealthy upstream instances. |
