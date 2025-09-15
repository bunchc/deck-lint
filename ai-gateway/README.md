# AI Gateway Rules

These rules are specific to Kong's AI Gateway features, focusing on the unique governance needs of LLM routes, such as rate-limiting, prompt sanitization, and authentication.

## Rules

| Rule File                                                                                                              | Description                                                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| [`disallow-unauthenticated-ai-proxy.yaml`](./disallow-unauthenticated-ai-proxy.yaml)                                   | Prevents AI proxy routes from being exposed without an authentication plugin to avoid abuse and cost overruns.                                   |
| [`disallow-unspecified-upstream-for-self-hosted-llms.yaml`](./disallow-unspecified-upstream-for-self-hosted-llms.yaml) | Ensures that any self-hosted LLM model specifies a valid `upstream_url` to prevent routing failures.                                             |
| [`enforce-ai-proxy-route-type.yaml`](./enforce-ai-proxy-route-type.yaml)                                               | Ensures every AI Proxy plugin is configured with a valid `route_type` to standardize request and response formats.                               |
| [`enforce-prompt-sanitization.yaml`](./enforce-prompt-sanitization.yaml)                                               | Ensures that AI prompt plugins are configured to sanitize inputs, which is a critical defense against prompt injection.                          |
| [`enforce-token-based-rate-limiting-for-llms.yaml`](./enforce-token-based-rate-limiting-for-llms.yaml)                 | Requires the AI Rate Limiting Advanced plugin for any route that proxies to a token-based LLM to prevent consumers from exhausting token quotas. |
| [`mandate-opentelemetry-for-ai-workflows.yaml`](./mandate-opentelemetry-for-ai-workflows.yaml)                         | Requires the OpenTelemetry plugin on all AI Gateway routes to enable end-to-end tracing.                                                         |
| [`recommend-advanced-load-balancing-for-ai-models.yaml`](./recommend-advanced-load-balancing-for-ai-models.yaml)       | Recommends using an advanced load balancing strategy for routes with multiple AI models to improve performance and resource utilization.         |
| [`require-ai-acl-on-mcp-routes.yaml`](./require-ai-acl-on-mcp-routes.yaml)                                             | Mandates that an ACL plugin is applied to all MCP (Model Composition Pipelines) routes to restrict access to authorized consumer groups.         |
| [`require-ai-prompt-guard.yaml`](./require-ai-prompt-guard.yaml)                                                       | Ensures the AI Prompt Guard plugin is enabled on all AI Gateway routes to block harmful or unsafe prompts.                                       |
| [`require-centralized-logging-for-llm-usage.yaml`](./require-centralized-logging-for-llm-usage.yaml)                   | Mandates that a logging plugin is configured for all AI Gateway routes to centralize LLM usage reporting.                                        |
| [`require-rate-limiting-on-llm-routes.yaml`](./require-rate-limiting-on-llm-routes.yaml)                               | Ensures that any route using an AI plugin also has a corresponding AI rate-limiting plugin to prevent abuse and control costs.                   |
