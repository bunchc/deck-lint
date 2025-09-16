# Governance Rules

This document explains the governance rules for the Kong Gateway. These rules help keep the gateway configuration consistent, secure, and easy to manage. They enforce best practices and compliance.

## Rules

The table below lists each governance rule and what it does.

| Rule File                                                                            | Name                              | Description                                                                                                                                                     |
| ------------------------------------------------------------------------------------ | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`disallow-deprecated-api-versions.yaml`](./disallow-deprecated-api-versions.yaml)   | Disallow Deprecated API Versions  | Stops traffic from being sent to old or unsupported API versions by flagging routes linked to a service tagged as 'deprecated'.                                 |
| [`disallow-global-plugins.yaml`](./disallow-global-plugins.yaml)                     | Disallow Global Plugins           | Stops plugins from being used globally. This makes sure they are set for specific services, routes, or consumers.                                               |
| [`enforce-deprecation-tagging.yaml`](./enforce-deprecation-tagging.yaml)             | Enforce Deprecation Tagging       | Requires services or routes marked as deprecated to have a `deprecated` tag and a `sunset-YYYY-MM-DD` tag. This clearly communicates when they will be retired. |
| [`enforce-plugin-naming-convention.yaml`](./enforce-plugin-naming-convention.yaml)   | Enforce Plugin Naming Convention  | Makes sure custom plugin names follow the `<plugin-base-name>-<major>v<minor>` format for correct versioning.                                                   |
| [`enforce-service-naming-convention.yaml`](./enforce-service-naming-convention.yaml) | Enforce Service Naming Convention | Enforces a standard naming format for all services, like 'team-app-env', to make them easier to manage.                                                         |
| [`enforce-tagging-schema.yaml`](./enforce-tagging-schema.yaml)                       | Enforce Tagging Schema            | Checks that all resource tags use the `key:value` format. This ensures consistency and helps with automation.                                                   |
| [`mandate-deprecation-headers.yaml`](./mandate-deprecation-headers.yaml)             | Mandate Deprecation Headers       | Ensures deprecated routes use a plugin to return `Deprecation` and `Sunset` HTTP headers that follow RFC 9745.                                                  |
| [`require-explicit-api-versioning.yaml`](./require-explicit-api-versioning.yaml)     | Require Explicit API Versioning   | Requires all route paths to include a version number (e.g., `/v1/`). This helps manage the API lifecycle.                                                       |
| [`require-mandatory-resource-tags.yaml`](./require-mandatory-resource-tags.yaml)     | Require Mandatory Resource Tags   | Makes sure all services, routes, and plugins have standard tags (like `team:`, `env:`, `owner:`) for tracking.                                                  |
| [`require-standard-tags.yaml`](./require-standard-tags.yaml)                         | Require Standard Tags             | Ensures all services and routes are tagged with 'team', 'env', and 'owner'. This helps with cost tracking and management.                                       |
