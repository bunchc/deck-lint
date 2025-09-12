# 166. Choose Placeholder vs Synthetic Replacement Modes When Sanitizing AI Requests

Date: 2025-04-28

## Tags

kong, ai, plugin, sanitizer, pii, anonymization, redaction, security, compliance, auditability

## Status

Accepted

## Context

Different use-cases require distinct sanitization strategies:

- **Placeholder**: fixed tokens for auditing and traceability.
- **Synthetic**: realistic replacements preserving data type semantics.

Selecting the wrong approach can hinder downstream processing or analytics.

## Decision

- Default to **`placeholder`** mode for high-security environments where auditability is critical.
- Use **`synthetic`** mode for testing and demo pipelines to maintain natural language flow.
- Override per-request via the plugin’s `anonymize` and `redact_mode` settings.

## Consequences

### Positive

- Fine-grained control over sanitization semantics.
- Ability to preserve format and category context in synthetic replacements.
- Placeholders enhance reproducible redaction audits.

### Risks

- Synthetic replacements may accidentally leak model biases.
- Placeholders may break schema-driven downstream parsing if not accounted for.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0166-choose-placeholder-vs-synthetic-replacement-modes.md)

- [Available Anonymization Modes](https://docs.konghq.com/hub/kong-inc/ai-sanitizer/#available-anonymization-modes)
