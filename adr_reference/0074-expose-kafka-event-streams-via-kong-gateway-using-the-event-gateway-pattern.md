# 74. Expose Kafka Event Streams via Kong Gateway Using the Event Gateway Pattern

Date: 2025-04-24

## Tags

kong, api, gateway, plugin, security, authentication, authorization, kafka, event gateway, event streaming, confluent, kafka upstream, rest to kafka, integration

## Status

Accepted

## Context

Organizations leveraging Apache Kafka for real-time data streaming often face challenges in securely exposing Kafka topics to external consumers. Direct exposure can lead to security vulnerabilities and operational complexities.

Implementing an Event Gateway pattern using Kong Gateway allows for controlled exposure of Kafka topics. Kong acts as an intermediary, translating RESTful API calls into Kafka messages, thereby providing a standardized and secure interface for external consumers.

## Decision

Adopt the Event Gateway pattern by integrating Kong Gateway with Confluent Cloud to expose Kafka topics:

- **Kong Gateway**: Deploy Kong Gateway to handle incoming RESTful API requests from external consumers.
- **Kafka Upstream Plugin**: Utilize the Kafka Upstream plugin to transform RESTful requests into Kafka messages and publish them to designated topics in Confluent Cloud.
- **Security and Control**: Apply Kong's built-in plugins for authentication, authorization, rate limiting, and observability to manage and monitor access to Kafka topics.

## Consequences

### Positive

- Provides a secure and standardized method for external consumers to interact with Kafka topics.
- Leverages Kong's plugin ecosystem for enhanced security and observability.
- Decouples external API interfaces from internal Kafka infrastructure.

### Risks

- Additional latency introduced due to the intermediary processing by Kong.
- Requires careful configuration to ensure message integrity and delivery guarantees.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0074-expose-kafka-event-streams-via-kong-gateway-using-the-event-gateway-pattern.md)

- [Kong Kafka Upstream Plugin Documentation](https://docs.konghq.com/hub/kong-inc/kafka-upstream/)
- [Confluent Cloud Documentation](https://docs.confluent.io/cloud/current/index.html)
- [Kong Blog: Exposing and Controlling Apache Kafka® Data Streaming with Kong Konnect and Confluent Cloud](https://konghq.com/blog/engineering/kafka-event-streaming-confluent-cloud)
