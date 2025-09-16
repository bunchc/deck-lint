# Governance Rules

This document provides an overview of the governance rules, which are designed to enforce consistency, best practices, and compliance across the Kong Gateway configuration. These rules help ensure that the gateway is secure, maintainable, and easy to manage.

## Rules

The following table lists all the available governance rules, along with a brief description of what each rule does.

| Rule File                                                                            | Name                              | Description                                                                                                                                         |
| ------------------------------------------------------------------------------------ | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`disallow-deprecated-api-versions.yaml`](./disallow-deprecated-api-versions.yaml)   | Disallow Deprecated API Versions  | Flags routes associated with a service tagged as 'deprecated' to prevent traffic from being routed to outdated or unsupported API versions.         |
| [`disallow-global-plugins.yaml`](./disallow-global-plugins.yaml)                     | Disallow Global Plugins           | Prevents plugins from being applied globally, enforcing that they are explicitly scoped to specific services, routes, or consumers.                 |
| [`enforce-deprecation-tagging.yaml`](./enforce-deprecation-tagging.yaml)             | Enforce Deprecation Tagging       | Requires any service or route marked as deprecated to include a `deprecated` tag and a `sunset-YYYY-MM-DD` tag for clear end-of-life communication. |
| [`enforce-plugin-naming-convention.yaml`](./enforce-plugin-naming-convention.yaml)   | Enforce Plugin Naming Convention  | Ensures that custom plugin names adhere to the standardized `<plugin-base-name>-<major>v<minor>` format for proper versioning.                      |
| [`enforce-service-naming-convention.yaml`](./enforce-service-naming-convention.yaml) | Enforce Service Naming Convention | Enforces a consistent naming convention for all services, such as 'team-app-env', to improve clarity and manageability.                             |
| [`enforce-tagging-schema.yaml`](./enforce-tagging-schema.yaml)                       | Enforce Tagging Schema            | Validates that all resource tags follow the standardized `key:value` format to ensure consistency and support automation.                           |
| [`mandate-deprecation-headers.yaml`](./mandate-deprecation-headers.yaml)             | Mandate Deprecation Headers       | Ensures that routes tagged as deprecated are configured with a plugin to return RFC 9745-compliant `Deprecation` and `Sunset` HTTP headers.         |
| [`require-explicit-api-versioning.yaml`](./require-explicit-api-versioning.yaml)     | Require Explicit API Versioning   | Mandates that all route paths must contain a version identifier (e.g., `/v1/`) for clear API lifecycle management.                                  |
| [`require-mandatory-resource-tags.yaml`](./require-mandatory-resource-tags.yaml)     | Require Mandatory Resource Tags   | Enforces that all services, routes, and plugins include a standard set of tags (e.g., `team:`, `env:`, `owner:`) for ownership and traceability.    |
| [`require-standard-tags.yaml`](./require-standard-tags.yaml)                         | Require Standard Tags             | Ensures that all services and routes are tagged with 'team', 'env', and 'owner' for cost allocation, resource management, and accountability.       |
