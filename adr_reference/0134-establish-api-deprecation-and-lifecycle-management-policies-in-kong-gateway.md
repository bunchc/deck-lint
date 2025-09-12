# 134. Establish API Deprecation and Lifecycle Management Policies in Kong Gateway

Date: 2025-04-25

## Tags

kong, api, gateway, lifecycle, deprecation, versioning, sunset-header, governance, compliance, documentation

## Status

Accepted

## Context

As APIs evolve, changes such as endpoint modifications, version updates, and deprecations become inevitable. Without a structured API lifecycle management policy:

- Consumers may be surprised by breaking changes
- Orphaned routes and services accumulate in Kong configuration
- Documentation and discoverability degrade over time
- Compliance and versioning guarantees are harder to uphold

API deprecation and lifecycle management policies ensure a predictable, transparent, and governed process for managing APIs deployed through Kong Gateway.

Additionally, RFC 9745 formalizes the use of the `Sunset` HTTP response header to communicate deprecation and retirement timelines to clients programmatically.

## Decision

Establish and enforce structured API lifecycle practices within Kong Gateway, including versioning, deprecation communication using RFC 9745-compliant headers, and formal retirement processes.

### Implementation Guidelines

#### 1. Use Explicit Versioning in Routes

Adopt URI versioning or other explicit strategies:

```yaml
routes:
  - name: payments-v1
    paths:
      - /v1/payments
  - name: payments-v2
    paths:
      - /v2/payments
```

Prefer explicit, discoverable versioning over implicit changes.

#### 2. Define API Deprecation Policies

Publish internal and external standards for:

- Minimum deprecation announcement period (e.g., 90 days notice)
- Communication channels:
  - Developer portal banners
  - Email announcements
  - API responses (headers)
- End-of-life (EOL) sunset dates

#### 3. Label and Track Deprecated APIs in Kong

Use route and service `tags` or metadata annotations to mark deprecated resources:

```yaml
tags:
  - deprecated
  - sunset-2025-12-31
```

This metadata supports automation of lifecycle actions and audits.

#### 4. Implement RFC 9745-Compliant Headers

Use plugins like `response-transformer` or custom Lua code to inject deprecation headers into API responses:

```yaml
plugins:
  - name: response-transformer
    config:
      add:
        headers:
          - "Deprecation: true"
          - "Sunset: Wed, 31 Dec 2025 23:59:59 GMT"
          - 'Link: </v2/payments>; rel="successor-version"'
```

Meaning of headers:

- `Deprecation: true` signals the API is deprecated.
- `Sunset: <timestamp>` signals when the API will be retired.
- `Link: <successor>; rel="successor-version"` points to the replacement API version.

Clients are expected to use this information to migrate proactively.

#### 5. Monitor Usage of Deprecated APIs

Prior to full shutdown:

- Analyze access logs for deprecated routes
- Measure traffic volume and active consumers
- Alert teams or external clients if deprecated APIs are still heavily used

#### 6. Retire APIs Cleanly at Sunset

On the sunset date:

- Remove deprecated routes, services, plugins, and consumers from Kong Gateway.
- Archive declarative configurations and associated documentation.
- Return HTTP 410 Gone for deprecated endpoints if needed for a grace period.

Example using `request-termination`:

```yaml
plugins:
  - name: request-termination
    config:
      status_code: 410
      message: "This API version has been retired."
```

#### 7. Communicate and Document Deprecations

Maintain a publicly accessible changelog, release notes, or deprecation timeline, for example:

- API portal page: `/api-lifecycle`
- Developer newsletters or mailing lists
- In-line API documentation annotations (e.g., OpenAPI `deprecated: true`)

## Consequences

### Positive Outcomes

- Provides consumers early, clear, and standardized notice of API deprecations
- Reduces risk of unexpected downtime due to silent EOL events
- Promotes migration to newer, more secure, and performant APIs
- Improves auditability and governance across API lifecycles
- Aligns with emerging HTTP deprecation standards (RFC 9745)

### Risks and Trade-offs

- Requires developer and platform discipline to tag and track deprecated APIs
- Risk of API bloat if sunset timelines are not enforced
- Clients must update SDKs, integrations, or apps on a predictable schedule

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0134-establish-api-deprecation-and-lifecycle-management-policies-in-kong-gateway.md)

- [RFC 9745: Sunset HTTP Header Field](https://datatracker.ietf.org/doc/rfc9745/)
- [Request Transformer Plugin](https://docs.konghq.com/hub/kong-inc/response-transformer/)
- [Kong Route Tagging](https://docs.konghq.com/gateway/latest/admin-api/#route-object)
