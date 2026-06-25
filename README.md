# FulfillGuard

FulfillGuard is a backend-first, locally operated order, inventory, and fulfilment orchestration platform built with Java and Spring Boot.

## Current status

- Sprint 1 — Architecture and Persistence Foundation
- FG-001 application bootstrap accepted
- Java 21 and Spring Boot 3.5.15
- Executable JAR with embedded Tomcat
- Health endpoint: `http://localhost:8080/actuator/health`
- Local execution and open-source runtime dependencies only

Project documentation is maintained under [`docs/`](docs/).

## Build and test

Windows:

```powershell
.\mvnw.cmd clean verify
```

Linux or macOS:

```bash
./mvnw clean verify
```

## Run locally

Windows:

```powershell
.\mvnw.cmd spring-boot:run
```

Linux or macOS:

```bash
./mvnw spring-boot:run
```

## Health check

```bash
curl http://localhost:8080/actuator/health
```

Expected response:

```json
{"status":"UP"}
```

## Sprint 1 focus

Committed:

- Repository-name correction
- Bootstrap cleanup
- Verification workflow hardening
- Modular-monolith boundaries
- PostgreSQL and Liquibase

Stretch:

- PostgreSQL integration tests with Testcontainers

See [`docs/sprints/sprint-01.md`](docs/sprints/sprint-01.md) for the detailed plan.

## Current limitations

- No business endpoints
- No accepted database configuration yet
- No accepted module boundaries yet
- No automated CI pipeline yet
- Security, messaging, observability, and orchestration are deferred

## Delivery model

Work is delivered through issues, short-lived branches, pull requests, review, and explicit acceptance. See [`CONTRIBUTING.md`](CONTRIBUTING.md) for repository rules.
