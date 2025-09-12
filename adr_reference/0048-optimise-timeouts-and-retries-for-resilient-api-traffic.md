# 48. Optimise Timeouts and Retries for Resilient API Traffic

Date: 2025-04-22

## Tags

kong, api, gateway, plugin, timeouts, retries, resilience, resource exhaustion, performance, traffic management

## Status

Accepted

Implemented by [138. Configure Timeouts and Retries to Prevent Resource Exhaustion in Kong Gateway](0138-configure-timeouts-and-retries-to-prevent-resource-exhaustion-in-kong-gateway.md)

Governs [130. Apply Resource Limits and Requests to Kong Control and Data Planes](0130-apply-resource-limits-and-requests-to-kong-control-and-data-planes.md)

Basis for [145. Architect Multi-Region Traffic Management with Kong Gateway](0145-architect-multi-region-traffic-management-with-kong-gateway.md)

## Context

Improperly configured timeouts and retries can cause resource exhaustion, hanging connections, increased latency, and amplified load during upstream service failures. Optimized settings ensure the system remains responsive and resilient.

## Decision

Establish best practices for timeouts and retries across all services and API traffic:

- **Timeouts**:

  - Set **connection**, **read**, and **write** timeouts aligned to expected upstream response times.
  - Avoid unnecessarily long timeouts unless dictated by business requirements (e.g., long-polling APIs).

- **Retries**:

  - Set a limited, reasonable number of retries for transient errors.
  - Avoid retry storms that exacerbate outages by amplifying traffic to unhealthy services.

- **Platform Enforcement**:
  - Use Kong plugins and service/entity configuration to enforce default timeout and retry policies centrally.
  - Tune values per environment (Dev/Test/Prod) based on traffic profiles and SLA expectations.

## Consequences

### Positive

- Improved API responsiveness during normal and degraded states.
- Reduced resource contention on Kong Gateways and upstream services.
- Faster detection of upstream failure conditions.

### Risks

- Overly aggressive timeouts may prematurely reject slow but valid responses.
- Retry misconfiguration could cause increased load during upstream degradation.

## References

- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0048-optimise-timeouts-and-retries-for-resilient-api-traffic.md)
- [Health Checks and Circuit Breakers](https://docs.konghq.com/gateway/latest/reference/health-checks-circuit-breakers/)
- [Service Configuration](https://docs.konghq.com/gateway/latest/admin-api/services/)
