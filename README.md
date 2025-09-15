# Best-Practice Spectral Rules for `deck file lint`

This project provides a curated collection of Spectral linting rules designed to ensure that Kong Gateway configurations are secure, compliant, and well-architected. By leveraging these rules with `deck file lint`, you can automate the enforcement of best practices across your API lifecycle.

## Usage

To incorporate these rules into your linting process, extend your local `.spectral.yaml` file with the desired rules from this repository. You can include individual rules, categories, or the entire ruleset.

For example, to include specific rules for requiring mTLS and standard tags:

```yaml
extends:
  - ./security/require-mtls-for-upstreams.yaml
  - ./governance/require-standard-tags.yaml
```

## Rule Categories

The rules are organized into the following categories. Each category directory contains a `README.md` with detailed information about the rules it contains.

*   **[Security](./security/README.md)**: Enforces security best practices to protect your APIs and infrastructure from vulnerabilities.
*   **[Governance](./governance/README.md)**: Ensures that your API landscape is consistent, compliant, and well-managed.
*   **[Resilience and Performance](./resilience-and-performance/README.md)**: Helps you build robust and high-performing APIs by enforcing patterns for reliability.
*   **[Observability](./observability/README.md)**: Mandates logging, tracing, and monitoring configurations to ensure visibility into API behavior.
*   **[AI Gateway](./ai-gateway/README.md)**: Provides rules specifically for securing and managing Large Language Model (LLM) traffic.
*   **[Operational Hygiene](./operational-hygiene/README.md)**: Promotes clean, maintainable, and efficient gateway configurations.

## Contributing

Contributions are welcome! If you have an idea for a new rule or an improvement to an existing one, please open an issue to start a discussion.
