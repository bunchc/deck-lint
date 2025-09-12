# 81. Automate API Delivery Using APIOps Principles

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, deployment

## Status

Accepted

## Context

Traditional API management workflows often involve manual configuration and operational bottlenecks, which slow down innovation and increase the risk of drift or misalignment across environments. APIOps — the application of DevOps principles to API lifecycle management — seeks to solve this by using GitOps, CI/CD pipelines, and infrastructure-as-code to automate delivery, governance, and testing of APIs.

Kong Konnect and Kong Gateway support declarative configuration and CI/CD integration, making them suitable platforms to implement APIOps workflows.

## Decision

Adopt APIOps best practices by integrating Kong Gateway and/or Konnect into an automated delivery pipeline that:

- **Defines APIs as code**:

  - Use OpenAPI Specification (OAS) or declarative config (YAML/JSON) to define services, routes, and plugins.
  - Store API definitions in version control (e.g., Git).

- **Uses CI/CD pipelines to validate and deploy APIs**:

  - Automate linting and schema validation of OAS documents.
  - Integrate Kong Gateway with CI pipelines (e.g., GitHub Actions, GitLab CI, Jenkins) to apply config via `decK`, Konnect APIs, or Gateway Admin API.
  - Include tests for routing logic, security policies, and rate limiting.

- **Implements GitOps principles**:

  - Use Git as the source of truth for API configuration.
  - Deploy declarative configs automatically to staging/production upon merge or approval.

- **Monitors APIs post-deployment**:
  - Use Kong’s observability tools and plugins (e.g., Prometheus, OpenTelemetry) to verify performance and error metrics.
  - Automatically roll back on test or health check failure.

## Consequences

### Positive

- Increases release velocity and reliability of API changes.
- Promotes consistency across environments and teams.
- Reduces human error and accelerates time to production.

### Risks

- Requires pipeline setup and ongoing maintenance.
- Environments must support declarative config or Admin API automation.
- Governance processes must be encoded into tooling and reviews.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0081-automate-api-delivery-using-apiops-principles.md)

- [Kong decK CLI](https://docs.konghq.com/deck/)
- [Kong Konnect API Automation](https://docs.konghq.com/konnect/)
- [Kong Gateway Declarative Config](https://docs.konghq.com/gateway/latest/kong-enterprise/kong-gateway-config-reference/)
- [Kong Blog: Automating API Delivery with APIOps and Kong](https://konghq.com/blog/engineering/automating-api-delivery-with-apiops-and-kong)
