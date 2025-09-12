# 75. Implement API Product Tiering Using Kong Gateway

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, authentication, product tiering, api monetization, consumer groups, acl, rate limiting, access control, subscription

## Status

Accepted

## Context

API product tiering allows organizations to offer different levels of API access, features, and usage limits based on customer subscription plans. This approach helps in monetizing APIs, controlling resource usage, and catering to diverse user needs.

Kong Gateway provides features such as Consumer Groups, Access Control Lists (ACLs), and Rate Limiting plugins that facilitate the implementation of API product tiering.

## Decision

Adopt API product tiering in Kong Gateway by:

- **Defining API Products**: Create services and routes for each API product (e.g., Market Data, Account Information, Payment Processing).

- **Enabling Authentication**: Implement key authentication to secure API access.

- **Creating Consumers and Credentials**: Represent end-users or applications as consumers and provision unique credentials for each.

- **Organizing Consumers into Groups**: Use Consumer Groups to categorize consumers into tiers (e.g., Free, Basic, Premium).

- **Applying ACLs**: Utilize the ACL plugin to restrict access to API products based on Consumer Groups.

- **Implementing Rate Limits**: Configure the Rate Limiting plugin to enforce usage limits per tier.

## Consequences

### Positive

- Enables monetization through differentiated API offerings.
- Controls resource usage and prevents abuse.
- Enhances user experience by providing tailored access levels.

### Risks

- Increased complexity in managing multiple tiers and configurations.
- Potential for misconfiguration leading to unauthorized access or service denial.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0075-implement-api-product-tiering-using-kong-gateway.md)

- [Key Authentication Plugin](https://docs.konghq.com/hub/kong-inc/key-auth/)
- [ACL Plugin](https://docs.konghq.com/hub/kong-inc/acl/)
- [Rate Limiting Plugin](https://docs.konghq.com/hub/kong-inc/rate-limiting/)
- [Consumer Groups](https://docs.konghq.com/konnect/gateway-manager/configuration/consumer-groups/)
- [Kong Blog: How to Implement API Product Tiering with Kong Konnect](https://konghq.com/blog/engineering/api-product-tiering)
