# 70. Utilize Kong Konnect Service Catalog with Traceable for Shadow API Discovery

Date: 2025-04-24

## Tags

kong, api, security, monitoring, kong konnect, service catalog, traceable, shadow api, api discovery, inventory, governance

## Status

Accepted

## Context

Unmanaged or undocumented APIs, often referred to as shadow APIs, pose significant security risks. Without visibility into these endpoints, organizations cannot enforce security policies effectively. Integrating Traceable with Kong Konnect's Service Catalog enables the discovery and management of shadow APIs.

## Decision

Leverage the integration between Traceable and Kong Konnect's Service Catalog to identify and manage shadow APIs:

- **API Discovery**: Use Traceable's discovery capabilities to detect all active APIs within the infrastructure.
- **Service Catalog Integration**: Import discovered APIs into Kong Konnect's Service Catalog for centralized management.
- **Policy Enforcement**: Apply consistent security policies across all APIs, including those previously unmanaged.
- **Continuous Monitoring**: Maintain ongoing surveillance for new or changed APIs to ensure continuous governance.

## Consequences

### Positive

- Comprehensive inventory of all APIs, reducing security blind spots.
- Centralized management and policy enforcement through Kong Konnect.
- Improved compliance with security standards and regulations.

### Risks

- Initial integration complexity between Traceable and Kong Konnect.
- Potential resource requirements for continuous monitoring and management.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0070-utilize-kong-konnect-service-catalog-with-traceable-for-shadow-api-discovery.md)

- [Kong Konnect Service Catalog Documentation](https://docs.konghq.com/konnect/service-catalog/)
- [Traceable API Discovery Features](https://www.traceable.ai/)
- [Kong Blog: Building and Running Secure APIs with Kong and Traceable](https://konghq.com/blog/engineering/secure-apis-with-kong-and-traceable)
