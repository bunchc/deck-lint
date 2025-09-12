# 25. Observability Debugging Workflow for Traces

Date: 2025-04-22

## Tags

observability, debugging, traces, troubleshooting, workflow

## Status

Accepted

Supports debugging of [20. Datadog Integration Strategy for Kong](0020-datadog-integration-strategy.md)

Used by [44. Implement Full Observability Stack: Logging, Monitoring, Tracing](0044-implement-full-observability-stack-logging-monitoring-tracing.md)

## Context

Troubleshooting missing traces required ad‑hoc checks of logs, headers, and exporter output. A standardized debugging workflow ensures faster root‑cause identification.

## Decision

Establish a **four‑step trace debugging playbook**:

1. **Header Inspection**: verify absence/presence of propagation headers (`traceparent`, `x-b3-sampled`) on incoming requests.
2. **Exporter Log Check**: search Kong logs for exporter entries—if none appear, spans were dropped pre‑export.
3. **Plugin Log Analysis**: review enhanced drop‑reason logs (per ADR‑0023) to pinpoint cause.
4. **End‑to‑End Trace Verification**: use a test client to send instrumented requests and confirm span arrival.

## Alternatives Considered

- **Ad hoc debugging**: faster to start but inconsistent outcomes.
- **Full service mesh tracing**: heavy‑weight solution that may be overkill for simple span drops.

## Consequences

### Positive

- Developers and SREs follow a repeatable checklist, reducing mean‑time‑to‑resolution.
- Gaps in observability are quickly detected (e.g., missing exporter logs).

### Negative

- Requires training teams on the new workflow.
- Relies on the prior ADRs (22–24) being implemented for full efficacy.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0025-observability-debugging-workflow-for-traces.md)
- [Kong Debug Guide](https://docs.konghq.com/gateway/latest/production/debug/)
- [Kong Logging](https://docs.konghq.com/gateway/latest/reference/configuration/#log)
