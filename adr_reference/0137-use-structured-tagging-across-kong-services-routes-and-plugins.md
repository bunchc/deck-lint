# 137. Use Structured Tagging Across Kong Services, Routes, and Plugins

Date: 2025-04-25

## Tags

kong, gateway, tagging, metadata, governance, automation, ownership, compliance, observability

## Status

Accepted

## Context

As Kong Gateway deployments grow across multiple teams, services, environments, and regions, managing the lifecycle and ownership of Kong resources becomes increasingly complex. Without structured metadata or tagging:

- It's difficult to associate resources with owners or SLAs
- Platform automation and reporting become brittle
- Resource cleanups (e.g., removing deprecated APIs) are error-prone
- Audit and compliance efforts are slowed down

Kong Gateway natively supports tagging for services, routes, plugins, consumers, certificates, and more. Structured and enforced tagging brings order, traceability, and governance to the platform.

## Decision

Adopt a standardized tagging strategy for all Kong-managed resources to support governance, automation, and operational visibility.

### Implementation Guidelines

#### 1. Define a Tagging Schema

At minimum, tags should include:

| Tag Key       | Description                       | Example                  |
| ------------- | --------------------------------- | ------------------------ |
| `team:`       | Owning team or department         | `team:billing`           |
| `env:`        | Environment type                  | `env:prod`               |
| `service:`    | Logical API or system association | `service:payments-api`   |
| `owner:`      | Responsible user or system        | `owner:jdoe@example.com` |
| `compliance:` | Compliance category (optional)    | `compliance:PCI`         |

Tags are flat strings, so prefix keys for clarity.

Example service with tags:

```bash
curl -X POST http://localhost:8001/services \
  --data "name=payments-api" \
  --data "url=https://payments.internal" \
  --data "tags=team:billing,env:prod,service:payments-api"
```

#### 2. Enforce Tagging via CI/CD Pipelines

Integrate tagging checks into `deck validate`, GitHub Actions, or other pipeline tools. Block deployments that lack mandatory tags.

#### 3. Use Tags for Resource Lifecycle Management

- Identify unused or orphaned services/routes via tagging queries
- Implement cleanup scripts based on `env:dev` or `env:test` expiration policies
- Filter audit reports and metrics by tags (e.g., by team or service)

#### 4. Leverage Tags in Observability and Dashboards

Aggregate and slice API metrics, error rates, and latency by:

- Environment (prod vs. staging)
- Team
- Service or API product

This improves operational insights and alert routing.

#### 5. Tag Sensitive APIs for Compliance Tracking

Mark APIs handling PII, PCI, HIPAA, or financial data with compliance tags for risk management and security audits.

#### 6. Maintain Tagging Standards and Training

Publish a simple tagging guideline document and require teams to follow it when registering new APIs or modifying configurations.

## Consequences

### Positive Outcomes

- Improved visibility, ownership, and traceability of Kong-managed resources
- Enables scalable governance, reporting, and automation
- Supports faster compliance audits and API cataloging efforts
- Simplifies incident response and operational triage

### Risks and Trade-offs

- Requires initial and ongoing education of developers and platform teams
- Risk of "tag drift" if not enforced automatically
- Tags are limited in complexity (flat key:value style) compared to hierarchical metadata models

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0137-use-structured-tagging-across-kong-services-routes-and-plugins.md)

- [Kong Tags Overview](https://docs.konghq.com/gateway/latest/admin-api/#tags)
