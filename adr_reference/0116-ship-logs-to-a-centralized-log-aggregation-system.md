# 116. Ship Logs to a Centralized Log Aggregation System

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, monitoring, logging, log-aggregation, observability, compliance, correlation-id, centralized-logging

## Status

Accepted

Implemented by [62. Enable Comprehensive API Logging and Monitoring for Incident Detection](0062-enable-comprehensive-api-logging-and-monitoring-for-incident-detection.md)

## Context

Kong Gateway produces multiple types of logs, including access logs, Admin API logs, and plugin-specific logs. In production environments, it is essential to aggregate these logs in a centralized logging system to support:

- Troubleshooting and debugging
- Security auditing and threat detection
- Performance analysis
- Compliance and governance

Without centralized log collection, it becomes difficult to correlate issues, analyze trends, or ensure retention and immutability of log data.

## Decision

Deploy and configure Kong to forward logs to a centralized log aggregation solution using supported plugins and platform-native agents.

### Logging Strategies

#### 1. Select Logging Plugins Based on Target System

| Logging Plugin       | Use Case                                                                           |
| -------------------- | ---------------------------------------------------------------------------------- |
| `http-log`           | Send logs to HTTP endpoints (e.g., Fluentd, Logstash)                              |
| `syslog`             | For integration with syslog-based tools                                            |
| `tcp-log`, `udp-log` | Low-latency log streaming                                                          |
| `kafka-log`          | Push logs to Kafka pipelines                                                       |
| `file-log`           | Only for development or test; avoid in production unless logs are scraped securely |

Example:

```bash
curl -X POST http://localhost:8001/services/payments/plugins \
  --data "name=http-log" \
  --data "config.http_endpoint=https://log-collector.internal/logs"
```

#### 2. Include Correlation Metadata

Use the `correlation-id` plugin to inject request identifiers:

```bash
curl -X POST http://localhost:8001/plugins \
  --data "name=correlation-id" \
  --data "config.header_name=X-Request-ID"
```

This allows tracing requests end-to-end across distributed systems.

#### 3. Sanitize Logs for Sensitive Information

Apply transformation plugins or configure logging plugins to redact or omit sensitive headers, tokens, or payloads.

#### 4. Ensure Reliable Delivery

For production, prefer:

- Buffered delivery (e.g., `http-log` with retries)
- Async logging options
- TLS for log transmission

#### 5. Integrate with Log Management Tools

Forward logs into:

- Elasticsearch + Kibana (ELK)
- Splunk
- Datadog Logs
- Fluentd or Fluent Bit
- Cloud-native systems (e.g., CloudWatch, Stackdriver, Azure Monitor)

## Consequences

### Positive Outcomes

- Unified log visibility across the Kong fleet
- Faster root cause analysis during incidents
- Supports compliance through immutable logging
- Enables advanced monitoring and analytics

### Risks and Trade-offs

- Logging plugins may introduce latency under heavy load
- Risk of leaking PII if logs are not properly scrubbed
- Requires operational management of log collectors and pipelines

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0116-ship-logs-to-a-centralized-log-aggregation-system.md)

- [Logging Plugins](https://docs.konghq.com/hub/?category=logging)
