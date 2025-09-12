# 28. Audit Logging Integration for Konnect on AWS

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, deployment, kubernetes, aws, lambda, cloudwatch, audit-logging, serverless, log-ingestion, konnect, webhook, observability, cost-optimization

## Status

Accepted

## Context

AWS CloudWatch does not natively accept HTTP webhooks, so Konnect’s audit‑log webhook cannot deliver logs directly. Customers without a full‑blown SIEM (Splunk, logz.io, etc.) need a lightweight ingestion path into CloudWatch without incurring excessive cost or operational overhead.

## Decision

Use an AWS Lambda function as the audit‑log ingestion endpoint for small‑to‑medium deployments, with the following guidelines:

- **Input**: Konnect audit‑log webhook targets a Lambda‑fronted API (via a custom Kong route).
- **Processing**: Lambda parses the incoming log batch and forwards it to CloudWatch Logs.
- **Metrics**: Track invocation count and bytes forwarded in CloudWatch Metrics.
- **Cost threshold**:
  - **Invocations < 1 million/month**: Lambda remains cost‑effective.
  - **Approaching 10 million/month**: Migrate to a long‑lived ingestion service (EC2, container, or Kubernetes pod) to reduce per‑request overhead and total cost.

## Alternatives Considered

1. **Direct SIEM Integration** (Splunk, logz.io, etc.)
   - Pros: turnkey ingestion, rich analytics.
   - Cons: requires licensing or existing SIEM infrastructure.
2. **Custom Ingestion Service** (self‑hosted container/pod)
   - Pros: full control, horizontally scalable.
   - Cons: more operational overhead, base cost even at low volume.
3. **Push to CloudWatch Logs API** within Kong plugin
   - Pros: fewer moving parts.
   - Cons: CloudWatch API limits, added plugin complexity, potential rate‑limit issues.

## Consequences

### Positive Outcomes

- **Low operational burden**: no always‑on servers for small deployments.
- **Cost‑effective** at low volumes (< 1 M invocations/month).
- **Seamless scaling**: Lambda auto‑scales with traffic bursts.

### Risks & Trade‑offs

- **Cold‑start latency**: occasional higher latency on first invocation.
- **Invocation cost**: per‑request charge may grow at high volume.
- **Operational complexity** when migrating to a long‑lived service at scale.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0028-audit-logging-integration-for-konnect-on-aws.md)
- [Konnect Audit Logging](https://docs.konghq.com/konnect/audit-logging/)
- [Kong Gateway Logging Plugins](https://docs.konghq.com/hub/#logging)
