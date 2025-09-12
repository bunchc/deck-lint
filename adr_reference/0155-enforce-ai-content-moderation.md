# 155. Enforce AI Content Moderation

Date: 2025-04-28

## Tags

kong, ai, llm, content-moderation, plugin, security, azure, compliance, safety, moderation, governance

## Status

Accepted

## Context

AI Proxy routes user requests to LLMs for text generation. Without in-flight moderation, malicious or inappropriate content may be generated or forwarded, leading to compliance and user safety risks. Azure Content Safety offers a managed content moderation API, supporting detection of hate speech, self-harm, sexual content, and more.

## Decision

Deploy the **AI Azure Content Safety** plugin in the AI Gateway pipeline:

- Configure it immediately after the **AI Proxy** plugin to intercept generated content.
- Require the AI Proxy plugin to be configured first, as the Azure Content Safety plugin extends its functionality.
- Point the plugin to your Azure Content Safety service endpoint, supplying secure credentials via environment variables or a vault.
- Invoke the Azure Content Safety API synchronously for each request payload.

Leverage the plugin’s configuration parameters to define:

Severity thresholds: Numeric scores per moderation category (e.g., 0.5 for “hate speech”) that determine when to block or flag content.
Blocklist IDs: An array of pre-configured Azure blocklist identifiers to ban specific terms or patterns.
Content composition: Choose to scan the full conversation history or only the "user" messages by adjusting the plugin’s route_type and composition settings.

**Security**

- Store Azure keys securely in a vault or as protected environment variables.
- Enforce HTTPS/TLS for all communications with Azure endpoints.

**Performance**

- Tune the plugin’s HTTP timeouts and retries to balance reliability and latency.
- Use the nearest Azure regional endpoint to minimize network delay.

## Consequences

### Positive

- Centralized, managed content moderation with no custom code.
- Offloads complex moderation logic to a specialized cloud service.
- Policy updates (thresholds, blocklists) are applied at configuration time.

### Risks

- External dependency: Azure service outages can block AI responses.
- Added per-request latency (typically 100–200 ms).
- Incremental cost based on moderation API usage volume.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0155-enforce-ai-content-moderation.md)

- [AI Azure Content Safety Plugin](https://docs.konghq.com/hub/kong-inc/ai-azure-content-safety/)
