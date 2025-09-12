# 88. Configure Header Cert Auth Plugin with Trusted IPs and Consumer Mapping

Date: 2025-04-24

## Tags

kong, api, plugin, security, authentication, mtls, header-cert-auth, trusted-ips, consumer-mapping, external-tls-termination

## Status

Accepted

Implements [87. Use Header Cert Auth Plugin for External TLS Termination](0087-use-header-cert-auth-plugin-for-external-tls-termination.md)

## Context

When using the Header Cert Authentication plugin, it's crucial to ensure that only trusted sources can send client certificates via HTTP headers to prevent spoofing. Additionally, mapping validated certificates to Kong consumers allows for fine-grained access control and auditing.

## Decision

Enhance the security and manageability of the Header Cert Authentication plugin by:

- Defining `trusted_ips` to restrict the sources from which Kong accepts client certificate headers.
- Implementing consumer mapping based on certificate attributes or manual mappings.

### Implementation Steps

- **Trusted IPs**:
  - Configure the `trusted_ips` parameter in the plugin to include the IP addresses of upstream components authorized to send client certificate headers.
- **Consumer Mapping**:
  - Utilize the `consumer_by` configuration to map certificates to consumers based on attributes like Common Name (CN) or Subject Alternative Name (SAN).
  - For more control, define manual mappings between specific certificate attributes and consumers using the Admin API or declarative configuration.

## Consequences

### Positive

- Prevents unauthorized entities from impersonating clients by restricting accepted certificate headers to known IP addresses.
- Enables detailed access control and auditing by associating client certificates with specific consumers.
- Enhances security posture in environments with upstream TLS termination.

### Risks

- Misconfiguration of `trusted_ips` can lead to legitimate requests being rejected or unauthorized access if too permissive.
- Manual consumer mappings require ongoing maintenance, especially in dynamic environments with frequent certificate changes.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0088-configure-header-cert-auth-plugin-with-trusted-ips-and-consumer-mapping.md)

- [Header Cert Authentication Plugin Documentation](https://docs.konghq.com/hub/kong-inc/header-cert-auth/)
- [Manual Mappings Between Certificate and Consumer Objects](https://docs.konghq.com/hub/kong-inc/header-cert-auth/how-to/manual-mapping-cert-consumers/)
