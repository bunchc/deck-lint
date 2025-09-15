# Governance Rules

These rules enforce organizational standards, such as resource tagging, naming conventions, and API lifecycle management.

## Rules

| Rule File                                                                            | Description                                                                                                                                      |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| [`disallow-deprecated-api-versions.yaml`](./disallow-deprecated-api-versions.yaml)   | Flags routes that are associated with a service tagged as 'deprecated' to ensure clients are migrated to newer versions.                         |
| [`disallow-global-plugins.yaml`](./disallow-global-plugins.yaml)                     | Prevents plugins from being applied globally, ensuring they are explicitly scoped to specific services, routes, or consumers.                    |
| [`enforce-deprecation-tagging.yaml`](./enforce-deprecation-tagging.yaml)             | Requires that any service or route marked as deprecated includes a `deprecated` tag and a `sunset-YYYY-MM-DD` tag.                               |
| [`enforce-plugin-naming-convention.yaml`](./enforce-plugin-naming-convention.yaml)   | Ensures that custom plugin names adhere to the standardized `<plugin-base-name>-<major>v<minor>` format for proper versioning.                   |
| [`enforce-service-naming-convention.yaml`](./enforce-service-naming-convention.yaml) | Enforces a consistent naming convention for all services, such as 'team-app-env', to improve clarity and management.                             |
| [`enforce-tagging-schema.yaml`](./enforce-tagging-schema.yaml)                       | Validates that all resource tags follow the standardized `key:value` format, which is critical for automation and reporting.                     |
| [`mandate-deprecation-headers.yaml`](./mandate-deprecation-headers.yaml)             | Ensures that routes tagged as deprecated are configured with a plugin to return RFC 9745-compliant `Deprecation` and `Sunset` HTTP headers.      |
| [`require-explicit-api-versioning.yaml`](./require-explicit-api-versioning.yaml)     | Mandates that all route paths must contain a version identifier (e.g., `/v1/`) for clear API lifecycle management.                               |
| [`require-mandatory-resource-tags.yaml`](./require-mandatory-resource-tags.yaml)     | Enforces that all services, routes, and plugins include a standard set of tags (e.g., `team:`, `env:`, `owner:`) for ownership and traceability. |
| [`require-standard-tags.yaml`](./require-standard-tags.yaml)                         | Ensures that all services and routes are tagged with 'team', 'env', and 'owner' for cost allocation and resource management.                     |
