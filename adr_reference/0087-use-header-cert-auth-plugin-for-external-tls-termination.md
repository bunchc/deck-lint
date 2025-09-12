# 87. Use Header Cert Auth Plugin for External TLS Termination

Date: 2025-04-24

## Tags

kong, gateway, plugin, security, authentication, deployment, mtls, header-cert-auth, external-tls-termination, zero-trust

## Status

Accepted

Implemented by [88. Configure Header Cert Auth Plugin with Trusted IPs and Consumer Mapping](0088-configure-header-cert-auth-plugin-with-trusted-ips-and-consumer-mapping.md)

## Context

In certain architectures, TLS termination occurs upstream of Kong Gateway—such as at a CDN, Web Application Firewall (WAF), or load balancer. In these scenarios, the client certificate used for mutual TLS (mTLS) is not available to Kong via the standard TLS handshake. To maintain client authentication, the upstream component can forward the client certificate to Kong in an HTTP header.

Kong's Header Cert Authentication plugin enables validation of client certificates provided in HTTP headers, allowing Kong to authenticate clients even when TLS is terminated upstream.

## Decision

Adopt the Header Cert Authentication plugin to authenticate clients using certificates passed in HTTP headers when TLS termination occurs upstream of Kong.

### Implementation Steps

- **Upstream Configuration**: Configure the upstream TLS terminator (e.g., CDN, WAF, load balancer) to extract the client's certificate and include it in a designated HTTP header (e.g., `X-Client-Cert`).
- **Kong Configuration**:
  - Enable the Header Cert Auth plugin on the relevant services or routes.
  - Specify the header name containing the client certificate.
  - Configure the plugin with the appropriate Certificate Authority (CA) certificates to validate the client certificates.
  - Optionally, define trusted IP addresses (`trusted_ips`) to ensure that only requests from known sources are accepted.
  - Set up consumer mapping based on certificate attributes (e.g., Common Name or Subject Alternative Name) or define manual mappings as needed.

## Consequences

### Positive

- Enables client certificate authentication in architectures where Kong does not handle TLS termination.
- Maintains end-to-end security by validating client identities at the application layer.
- Provides flexibility in deployment architectures involving third-party TLS terminators.

### Risks

- Relies on the security of the upstream component to correctly extract and forward client certificates.
- Potential for header spoofing if `trusted_ips` is not properly configured.
- Requires careful management of CA certificates and consumer mappings.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0087-use-header-cert-auth-plugin-for-external-tls-termination.md)

- [Header Cert Authentication Plugin Documentation](https://docs.konghq.com/hub/kong-inc/header-cert-auth/)
- [Add Certificate Authorities](https://docs.konghq.com/hub/kong-inc/header-cert-auth/how-to/add-cert-authorities/)
- [Manual Mappings Between Certificate and Consumer Objects](https://docs.konghq.com/hub/kong-inc/header-cert-auth/how-to/manual-mapping-cert-consumers/)
