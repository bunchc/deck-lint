# Spectral Rules for deck file lint

This project offers a set of Spectral rules to help you lint your Kong Gateway configurations. Using these rules with `deck file lint` helps you follow best practices for your APIs.

## How to Use

To use these rules, add them to your `.spectral.yaml` file. You can add single rules, groups of rules, or all of them.

For example, to add rules for mTLS and standard tags:

```yaml
extends:
  - ./security/require-mtls-for-upstreams.yaml
  - ./governance/require-standard-tags.yaml
```

## Rule Groups

The rules are grouped by area. Each group has a `README.md` file with more details.

*   **[AI Gateway](./ai-gateway/README.md)**: Rules for Kong's AI Gateway. They cover needs for LLM routes like rate limits, prompt cleaning, and auth. Good AI service rules are key for security, cost, and performance.
*   **[Governance](./governance/README.md)**: Rules to enforce clear and safe Kong Gateway settings. These rules help keep the gateway secure and easy to manage.
*   **[Observability](./observability/README.md)**: Rules to make sure all Kong parts have logs, metrics, and traces.
*   **[Operational Hygiene](./operational-hygiene/README.md)**: Rules for a clean, safe, and steady API gateway setup. They help stop common problems, lower security risks, and make the gateway easy to check and maintain.
*   **[Resilience and Performance](./resilience-and-performance/README.md)**: Rules for stable, available, and fast services. They enforce best practices for timeouts, retries, circuit breakers, and health checks.
*   **[Security](./security/README.md)**: Rules for security best practices for Kong Gateway. These rules help you set up your gateway securely from the start to reduce risks.

## How to Contribute

We welcome contributions! If you have an idea for a new rule or a change to an old one, please open an issue to discuss it.
