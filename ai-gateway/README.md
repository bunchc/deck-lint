# AI Gateway Rules

These rules are specific to Kong's AI Gateway features, focusing on the unique governance needs of LLM routes, such as rate-limiting, prompt sanitization, and authentication. Proper governance of AI services is critical for security, cost management, and ensuring reliable performance.

The rules in this category help enforce best practices for AI proxy usage, including:

*   **Security**: Preventing unauthorized access, prompt injection, and ensuring secure communication.
*   **Cost Management**: Implementing rate-limiting to control token usage and prevent cost overruns.
*   **Reliability**: Ensuring proper configuration for self-hosted models and standardizing route types.
*   **Observability**: Mandating logging and tracing for monitoring and debugging.

## Rules

| Rule File                                                                                                              | Rule Name                                            | Description                                                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| [`disallow-unauthenticated-ai-proxy.yaml`](./disallow-unauthenticated-ai-proxy.yaml)                                   | `disallow-unauthenticated-ai-proxy`                  | Prevents AI proxy routes from being exposed without an authentication plugin to avoid abuse and cost overruns.                                   |
| [`disallow-unspecified-upstream-for-self-hosted-llms.yaml`](./disallow-unspecified-upstream-for-self-hosted-llms.yaml) | `disallow-unspecified-upstream-for-self-hosted-llms` | Ensures that any self-hosted LLM model specifies a valid `upstream_url` to prevent routing failures.                                             |
| [`enforce-ai-proxy-route-type.yaml`](./enforce-ai-proxy-route-type.yaml)                                               | `enforce-ai-proxy-route-type`                        | Ensures every AI Proxy plugin is configured with a valid `route_type` to standardize request and response formats.                               |
| [`enforce-prompt-sanitization.yaml`](./enforce-prompt-sanitization.yaml)                                               | `enforce-prompt-sanitization`                        | Ensures that AI prompt plugins are configured to sanitize inputs, which is a critical defense against prompt injection.                          |
| [`enforce-token-based-rate-limiting-for-llms.yaml`](./enforce-token-based-rate-limiting-for-llms.yaml)                 | `enforce-token-based-rate-limiting-for-llms`         | Requires the AI Rate Limiting Advanced plugin for any route that proxies to a token-based LLM to prevent consumers from exhausting token quotas. |
| [`mandate-opentelemetry-for-ai-workflows.yaml`](./mandate-opentelemetry-for-ai-workflows.yaml)                         | `mandate-opentelemetry-for-ai-workflows`             | Requires the OpenTelemetry plugin on all AI Gateway routes to enable end-to-end tracing.                                                         |
| [`recommend-advanced-load-balancing-for-ai-models.yaml`](./recommend-advanced-load-balancing-for-ai-models.yaml)       | `recommend-advanced-load-balancing-for-ai-models`    | Recommends using an advanced load balancing strategy for routes with multiple AI models to improve performance and resource utilization.         |
| [`require-ai-acl-on-mcp-routes.yaml`](./require-ai-acl-on-mcp-routes.yaml)                                             | `require-ai-acl-on-mcp-routes`                       | Mandates that an ACL plugin is applied to all MCP (Model Composition Pipelines) routes to restrict access to authorized consumer groups.         |
| [`require-ai-prompt-guard.yaml`](./require-ai-prompt-guard.yaml)                                                       | `require-ai-prompt-guard`                            | Ensures the AI Prompt Guard plugin is enabled on all AI Gateway routes to block harmful or unsafe prompts.                                       |
| [`require-centralized-logging-for-llm-usage.yaml`](./require-centralized-logging-for-llm-usage.yaml)                   | `require-centralized-logging-for-llm-usage`          | Mandates that a logging plugin is configured for all AI Gateway routes to centralize LLM usage reporting.                                        |
| [`require-rate-limiting-on-llm-routes.yaml`](./require-rate-limiting-on-llm-routes.yaml)                               | `require-rate-limiting-on-llm-routes`                | Ensures that any route using an AI plugin also has a corresponding AI rate-limiting plugin to prevent abuse and control costs.                   |
