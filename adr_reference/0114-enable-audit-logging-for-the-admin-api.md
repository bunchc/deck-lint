# 114. Enable Audit Logging for the Admin API

Date: 2025-04-25

## Tags

kong, api, gateway, plugin, security, authentication, audit-logging, compliance, admin-api, observability, monitoring, rbac, logging, forensics

## Status

Accepted

Implemented by [108. Secure the Admin API with IP Restrictions and Authentication](0108-secure-the-admin-api-with-ip-restrictions-and-authentication.md)

Implements [125. Enable and Monitor Kong Gateway Audit Logging for Operational Transparency](0125-enable-and-monitor-kong-gateway-audit-logging-for-operational-transparency.md)

Basis for [123. Harden Kong Gateway Admin API for Production Environments](0123-harden-kong-gateway-admin-api-for-production-environments.md)

## Context

Kong’s Admin API is a critical control plane interface used to configure and manage the gateway. Unauthorized or accidental changes through the Admin API can cause service outages, security misconfigurations, or compliance violations.

To ensure visibility and traceability of administrative actions, especially in regulated or enterprise environments, audit logging must be enabled to capture:

- Who made a change
- When the change occurred
- What resource was affected
- Which workspace or scope was involved

## Decision

Enable Kong’s built-in audit logging feature to record all administrative actions taken through the Admin API, and forward the logs to a secure, centralized logging backend.

### Implementation Steps

#### 1. Enable Audit Logging

In the Kong configuration:

```yaml
env:
  - name: KONG_AUDIT_LOG
    value: "on"
  - name: KONG_AUDIT_LOG_PLUGIN
    value: "file-log"
  - name: KONG_AUDIT_LOG_PATH
    value: "/usr/local/kong/audit.log"
```

Or for external systems, use:

```yaml
- name: KONG_AUDIT_LOG_PLUGIN
  value: "http-log"
- name: KONG_AUDIT_LOG_HTTP_ENDPOINT
  value: "https://log-forwarder.internal.company.com/audit"
```

#### 2. Use RBAC to Tie Actions to Users

Audit logs are most useful when RBAC is enforced with named users and tokens:

- Create Kong RBAC users (not shared tokens)
- Assign appropriate roles and scopes

Example log output:

```json
{
  "user": "admin@example.com",
  "api": "PATCH /services/payment-api",
  "workspace": "default",
  "timestamp": "2025-04-25T15:00:00Z"
}
```

#### 3. Ship Logs to SIEM or Central Logging

Forward logs to tools like:

- Splunk
- Datadog
- ELK stack
- AWS CloudWatch

Use `http-log`, `tcp-log`, or `syslog` plugin options.

## Consequences

### Positive Outcomes

- Enables full visibility into administrative activity
- Supports forensic investigations and troubleshooting
- Fulfills security and compliance audit requirements

### Risks and Trade-offs

- Minor performance impact due to logging
- Must secure access to log storage and transmission
- Additional configuration effort for external log pipelines

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0114-enable-audit-logging-for-the-admin-api.md)

- [Audit Logging in Kong](https://docs.konghq.com/gateway/latest/kong-enterprise/audit-log/#main)
- [File Log Plugin](https://docs.konghq.com/hub/kong-inc/file-log/)
