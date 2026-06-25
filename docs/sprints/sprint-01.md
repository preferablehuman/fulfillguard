# Sprint 1 — Architecture and Persistence Foundation

## Summary

- Duration: one week
- Capacity: 8–12 engineering hours
- Status: Planned
- Tracking issue: #26

## Goal

Convert the runnable Spring Boot shell into a structured modular monolith with reproducible PostgreSQL persistence while closing accepted FG-001 cleanup debt.

## Committed work

1. PRE-001 — Rename repository to `fulfillguard`.
2. FG-010 — Bootstrap metadata and environment hygiene.
3. FG-009 — Local verification hardening.
4. FG-002 — Modular-monolith boundaries.
5. FG-003 — PostgreSQL and Liquibase.

## Stretch work

- FG-004 — PostgreSQL integration tests with Testcontainers.

## Delivery order

```text
PRE-001 -> FG-010 -> FG-009 -> FG-002 -> FG-003 -> FG-004
```

FG-004 begins only if committed work is accepted and capacity remains.

## Restrictions

Do not introduce Kafka, Debezium, Apicurio Registry, Valkey, Keycloak, Kubernetes, Open Liberty, external-system simulators, or the full observability stack.

Do not implement inventory or order business behaviour. Only module scaffolding and minimal persistence structures needed to prove migrations are in scope.

## Required decisions

The engineer must recommend and defend:

- Package-enforced modules or Maven multi-module structure
- Module dependency direction and enforcement
- PostgreSQL image and exact version
- Local OCI and Compose-compatible strategy
- Database and schema naming
- Environment-variable contract
- Liquibase changelog structure
- Failure behaviour for invalid database configuration

## Expected branches

```text
chore/spr-1-bootstrap-hygiene
fix/spr-1-verification-workflow
feature/spr-1-module-boundaries
feature/spr-1-postgres-liquibase
feature/spr-1-test-foundation
```

## Success criteria

- Repository name matches the product name.
- Accepted bootstrap cleanup debt is closed.
- Module boundaries are explicit and enforced.
- PostgreSQL starts with an explicit version and health check.
- Credentials are not committed.
- The application connects to PostgreSQL.
- Liquibase initializes an empty database.
- Reset and clean-start procedures are documented.
- `main` remains runnable after every accepted pull request.

## Deferred backlog

- FG-005 — Maven quality gates
- FG-006 — Initial ADRs
- FG-007 — Architecture diagrams
- FG-008 — Jenkins pipeline
