# Deployment Rules

This directory contains spectral linting rules designed to enforce best practices for deploying Kong Gateway and its associated components. These rules cover various aspects of deployment, including:

*   **Deployment Topologies**: Ensuring recommended architectural patterns for Kong Enterprise, Kong Konnect, and Kubernetes Ingress Controller deployments.
*   **Containerization**: Standardizing golden images, build processes, and custom plugin deployment strategies.
*   **Resource Allocation**: Optimizing CPU and worker configurations for Kubernetes nodes.
*   **High Availability & Disaster Recovery**: Formalizing strategies for HA/DR, including health probes and graceful shutdowns.
*   **Upgrade Strategies**: Implementing blue/green and canary deployment approaches for safe upgrades.
*   **Kubernetes-Native Deployments**: Utilizing Gateway API standards and operators for multi-gateway management.
