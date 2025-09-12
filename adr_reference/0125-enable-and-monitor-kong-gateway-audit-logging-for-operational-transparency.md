# 125. Enable and Monitor Kong Gateway Audit Logging for Operational Transparency

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, audit-logging, compliance, observability, monitoring, logging, rbac, admin-api

## Status

Accepted

Implemented by [114. Enable Audit Logging for the Admin API](0114-enable-audit-logging-for-the-admin-api.md)

## Context

In enterprise environments, especially those with regulatory, security, or operational requirements, audit logging is essential to track who changed what, when, and how in the Kong Gateway platform.

Kong Gateway (Enterprise) supports audit logging for changes made via the Admin API, including CRUD operations on services, routes, plugins, consumers, certificates, and RBAC tokens. Without audit logs:

- It is difficult to investigate incidents or changes
- Compliance with standards like ISO 27001, PCI-DSS, or SOC 2 is harder to demonstrate
- Shared environments lack accountability for administrative actions

## Decision

Enable Kong Gateway audit logging and integrate it into the broader observability stack for secure collection, retention, and alerting.

### Implementation Guidelines

#### 1. Enable Audit Logging in Kong Configuration

In `kong.conf`, enable audit log output to file or syslog:

```ini
audit_log = /var/log/kong/audit.log
audit_log_enabled = on
```

Optionally, configure:

- `audit_log_syslog_facility`
- `audit_log_syslog_host`
- `audit_log_syslog_port`

#### 2. Define What to Log

By default, audit logs capture:

- Authenticated user (RBAC token subject)
- Request method, path, and parameters
- Timestamp and status code
- Workspace context (if applicable)

Ensure logs include changes to:

- Services, routes, and plugins
- RBAC roles, tokens, and permissions
- Certificates and credentials
- Declarative syncs (via decK or CI)

#### 3. Integrate Logs into Centralized Platform

Forward logs to a log aggregation platform such as:

- Splunk
- ELK Stack
- Datadog
- Fluentd / Loki

Ensure logs are:

- Retained according to compliance policies
- Protected from tampering
- Searchable for incident response

#### 4. Alert on Suspicious Admin Activity

Create alerts for:

- Unusual or high-volume changes
- Unauthorized configuration modifications
- Access to sensitive routes or tokens

Integrate with security information and event management (SIEM) tools.

#### 5. Periodic Review and Compliance Reporting

Review audit logs during:

- Quarterly access reviews
- Post-incident analysis
- Internal compliance audits

Provide reports or filtered logs to auditors upon request.

## Consequences

### Positive Outcomes

- Full traceability of changes to Kong configuration
- Meets enterprise security and compliance standards
- Enables faster root cause analysis and accountability

### Risks and Trade-offs

- Requires log rotation and retention policy management
- Audit logs must be protected to avoid tampering
- Slight performance overhead for log capture and forwarding

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0125-enable-and-monitor-kong-gateway-audit-logging-for-operational-transparency.md)
