# 146. Implement PostgreSQL Database Scaling and High Availability Strategies for Kong Control Plane

Date: 2025-04-25

## Tags

kong, gateway, postgresql, database, scaling, high-availability, ha, backup, replication, control-plane, reliability

## Status

Accepted

## Context

In Kong Gateway deployments using database-backed (traditional) mode or hybrid mode (for Control Plane persistence), PostgreSQL serves as the critical backing store for:

- Services, routes, plugins, and consumer configurations
- Workspaces and RBAC tokens
- Vault references
- Developer Portal content (optional)

Without appropriate database scaling and high availability (HA) planning, PostgreSQL becomes a single point of failure, introducing risks such as:

- Loss of control plane functionality (no Admin API changes, plugin sync issues)
- Data inconsistency during crashes
- Difficulty scaling Kong as API traffic and configurations grow
- Violation of RPO/RTO targets during incidents

## Decision

Implement production-grade PostgreSQL scaling, HA, and backup strategies for all Kong Control Plane database clusters.

### Implementation Guidelines

#### 1. Use Managed or Hardened PostgreSQL Deployments

Prefer:

- AWS RDS for PostgreSQL (Multi-AZ enabled)
- GCP Cloud SQL for PostgreSQL
- Azure Database for PostgreSQL Flexible Server
- Self-managed PostgreSQL HA deployments using Patroni, CrunchyData, or similar

Ensure database patching and maintenance windows are coordinated with Kong upgrade cycles.

#### 2. Enable Multi-AZ High Availability

Always deploy database clusters in at least:

- One primary writer
- One synchronous standby replica (automatic failover enabled)

Example for AWS RDS:

```text
Multi-AZ Deployment with Amazon Aurora or PostgreSQL RDS.
```

This ensures automatic failover without manual intervention if the primary AZ fails.

#### 3. Scale Read Replicas for High Config Load

If Kong Admin API traffic or Konnect syncing loads grow large:

- Deploy read replicas
- Offload analytics, audits, and long-running queries from the primary
- Tune Kong to prefer read replicas where possible

Monitor replica lag carefully.

#### 4. Tune PostgreSQL Settings for Kong Workloads

Optimize:

- Connection pool sizes (e.g., `max_connections`)
- WAL (Write-Ahead Logging) parameters for replication performance
- Autovacuum settings to prevent table bloat
- Memory settings (`shared_buffers`, `work_mem`) for fast config transactions

Profile and adjust based on control plane load testing results.

#### 5. Secure PostgreSQL Communications

- Require SSL/TLS for all database connections from Kong CPs
- Use client authentication and IAM integration if available (e.g., RDS IAM auth)
- Rotate database user passwords or tokens regularly

#### 6. Backup and Snapshot Regularly

- Perform automated encrypted backups (daily minimum; more frequent for critical clusters)
- Retain point-in-time recovery (PITR) capability
- Replicate backups across regions if applicable (cross-region backups)

Verify backup restore integrity periodically through drills.

#### 7. Monitor and Alert on Database Health

Monitor key PostgreSQL metrics:

- Connection saturation
- Disk I/O utilization
- Replica lag
- Deadlocks or slow query rates
- Backup success/failure alerts

Tie database health metrics into Kong’s control plane health dashboards.

## Consequences

### Positive Outcomes

- Increases reliability and fault tolerance of Kong Gateway control plane
- Reduces risk of configuration loss or sync issues during database incidents
- Supports control plane scaling to thousands of APIs and consumers
- Meets enterprise-grade RPO/RTO targets for business continuity

### Risks and Trade-offs

- HA databases incur additional infrastructure and licensing costs
- Database performance tuning requires PostgreSQL expertise
- Replica consistency and failover behavior must be validated carefully to avoid surprises

## References
- [Self](https://github.com/KongHQ-CX/architecture-decision-records/blob/main/doc/adr/0146-implement-postgresql-database-scaling-and-high-availability-strategies-for-kong-control-plane.md)

- [PostgreSQL High Availability and Replication](https://www.postgresql.org/docs/current/different-replication-solutions.html)
- [AWS RDS for PostgreSQL Best Practices](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.html)
