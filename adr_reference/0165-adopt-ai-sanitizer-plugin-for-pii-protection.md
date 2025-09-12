# 165. Adopt AI Sanitizer Plugin for PII Protection

Date: 2025-04-28

## Tags

kong, ai, plugin, pii, sanitizer, redaction, compliance, data-privacy, gdpr, ccpa, security

## Status

Accepted

## Context

Client request bodies often contain sensitive PII (names, locations, dates, credentials) that must be masked or anonymized before reaching upstream services to ensure regulatory compliance (GDPR, CCPA) and prevent data leaks. Custom in-line sanitization is error-prone and difficult to maintain.

Kong’s **AI Sanitizer** plugin integrates with an external AI PII Anonymizer service to detect and sanitize PII in request payloads, enabling consistent, extensible redaction without custom code.

## Decision

- Enable the **AI Sanitizer** plugin for all APIs handling user-generated content.
- Configure Kong to forward request bodies to the external PII service endpoint (`/llm/v1/sanitize`).
- Chain AI Sanitizer with the **AI Proxy** or **AI Proxy Advanced** plugin for seamless forwarding.
- Sanitize PII in-flight, ensuring upstream services only see redacted payloads.

## Consequences

### Positive

- Centralized, model-driven PII detection and redaction.
- Simplifies compliance with data-privacy regulations.
- Offloads NLP complexity to a maintained external service.

### Risks

- Introduces dependency on external PII service availability.
- Network latency for remote sanitization calls.
- Requires securing communications to the PII service (mTLS, firewall).

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0165-adopt-ai-sanitizer-plugin-for-pii-protection.md)

- [AI Sanitizer Overview](https://docs.konghq.com/hub/kong-inc/ai-sanitizer/#overview)
