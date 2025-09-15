# Observability Rules

This category contains rules to ensure that all Kong entities are properly instrumented for logging, metrics, and distributed tracing.

## Rules

| Rule File                                                                                    | Description                                                                                                                                          |
| -------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`disallow-file-log-in-production.yaml`](./disallow-file-log-in-production.yaml)             | Discourages the use of the `file-log` plugin in production environments to promote centralized logging.                                              |
| [`enforce-global-observability-plugins.yaml`](./enforce-global-observability-plugins.yaml)   | Verifies that key observability plugins (Prometheus, OpenTelemetry, and a logging plugin) are applied globally.                                      |
| [`enforce-opentelemetry-config.yaml`](./enforce-opentelemetry-config.yaml)                   | Validates the configuration of the OpenTelemetry plugin to ensure that it is sending traces to a valid endpoint and using the correct sampling rate. |
| [`enforce-secure-opentelemetry-exporter.yaml`](./enforce-secure-opentelemetry-exporter.yaml) | Ensures that the OpenTelemetry plugin is configured to use a secure exporter endpoint (e.g., HTTPS).                                                 |
| [`enforce-w3c-trace-context.yaml`](./enforce-w3c-trace-context.yaml)                         | Enforces the use of W3C Trace Context for trace propagation in the OpenTelemetry plugin.                                                             |
| [`mandate-correlation-id-plugin.yaml`](./mandate-correlation-id-plugin.yaml)                 | Ensures that the 'correlation-id' plugin is enabled globally, which is crucial for tracing and debugging.                                            |
| [`recommend-slo-monitoring-tags.yaml`](./recommend-slo-monitoring-tags.yaml)                 | Recommends adding SLO-related tags to services and routes to support SLO monitoring.                                                                 |
| [`require-log-sanitization.yaml`](./require-log-sanitization.yaml)                           | Recommends configuring log sanitization to prevent the leakage of sensitive information.                                                             |
| [`require-logging-plugin.yaml`](./require-logging-plugin.yaml)                               | Ensures that every service has a logging plugin attached for centralized logging.                                                                    |
| [`require-prometheus-plugin.yaml`](./require-prometheus-plugin.yaml)                         | Ensures that the Prometheus plugin is enabled to expose metrics for monitoring.                                                                      |
