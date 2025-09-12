# ADR-001: Deploying Kong Gateway Enterprise Data Planes on AWS ECS Fargate

 ## Tags: 
 
 kong-gateway, ecs, fargate, data-plane, aws, cost-optimization  

## Status: 

Accepted

Alternative: [3. Kong Enterprise CP/DP (Hybrid Mode) Deployment Architecture](0003-kong-enterprise-hybrid-deployment.md)  
Alternative: [4. Kong Konnect (SaaS Control Plane) Deployment Architecture](0004-kong-konnect-saas-deployment.md)  
See also: [2. Recommended Kong Deployment Architectures](0002-recommended-kong-deployment-architectures.md)

## Context

Operating Kong Gateway Enterprise data planes in EKS clusters can lead to increasing infrastructure costs, driven by the need to provision and maintain persistent node pools, manage control plane overhead, and ensure high availability across multiple environments. These requirements are straining infrastructure budgets, especially as the number of data plane instances scales across regions and business units.

AWS Fargate offers a serverless container runtime that eliminates the need for managing EC2 instances directly. This aligns well with the goal of minimizing operational overhead and optimizing cost by paying only for actual compute consumption. Additionally, Fargate Spot capacity provides an opportunity for further savings in non-critical environments where occasional interruption is acceptable.

## Decision

Deploy Kong Gateway data plane services in AWS ECS Fargate to capitalize on Fargate’s serverless and cost-efficient compute model.

Key implementation details:
- Use Fargate Spot for lower-tier or non-critical environments to reduce compute costs.
- Use standard Fargate for production environments requiring higher reliability.
- Provision each data plane with its own network interface for secure VPC integration.
- Manage deployments using Terraform, leveraging Kong’s community and internal modules.

## Consequences

**Benefits:**
- Significant reduction in compute costs by eliminating persistent EC2 node pools.
- Simplified deployment model with reduced operational burden.
- Scalability and elasticity based on per-container resource requirements.

**Trade-offs:**
- Limited observability unless instrumentation is adapted for Fargate (e.g., build-time agent injection, OpenTelemetry).
- Inflexibility in customizing the underlying OS (no custom AMIs).
- May require changes in secrets management and mTLS termination architecture.

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0168-deploying-kong-gateway-enterprise-data-planes-on-aws-ecs-fargate.md)
- [AWS ECS Fargate](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html)
