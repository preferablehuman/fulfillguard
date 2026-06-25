# Sprint 1 — Architecture and Persistence Foundation

## Sprint control

- **Sprint:** 1
- **Duration:** One week
- **Committed capacity:** 8–12 engineering hours
- **Status:** Active
- **Tracking issue:** #26

## Sprint goal

Convert the runnable Spring Boot shell into a structured modular monolith with reproducible PostgreSQL persistence while closing the accepted FG-001 cleanup debt.

## Selected deliverables

| Deliverable ID | Selected increment | Commitment | Current status |
|---|---|---|---|
| GOV-002 | Complete and verify the canonical repository rename | Committed | Accepted |
| FND-002 | Complete bootstrap metadata and environment hygiene | Committed | Planned |
| FND-003 | Make local build, startup, and health verification safe and trustworthy | Committed | Planned |
| FND-004 | Establish and enforce the initial modular-monolith boundaries | Committed | Planned |
| FND-005 | Provide reproducible PostgreSQL startup, application connectivity, and Liquibase migration | Committed | Planned |
| FND-006 | Add deterministic real-PostgreSQL integration testing | Stretch | Planned |

## Functional requirements

| ID | Requirement | Deliverable | Verification method | Status |
|---|---|---|---|---|
| FR-S1-001 | The canonical repository is accessible as `preferablehuman/fulfillguard`, and new branches and issues operate under that identity. | GOV-002 | Repository and branch inspection | Accepted |
| FR-S1-002 | Maven metadata contains the product name and an accurate description, with unused empty metadata removed. | FND-002 | POM inspection and clean build | Planned |
| FR-S1-003 | Local environment files are excluded while a safe `.env.example` may be committed. | FND-002 | Git ignore verification | Planned |
| FR-S1-004 | The Windows verifier executes clean build, automated tests, application startup, and health verification as one workflow. | FND-003 | Successful script execution | Planned |
| FR-S1-005 | The verifier returns non-zero for failed build, occupied port, failed startup, or unhealthy application and stops only its own process tree. | FND-003 | Demonstrated success and failure paths | Planned |
| FR-S1-006 | The codebase exposes explicit `catalog`, `warehouse`, `inventory`, `order`, `fulfilment`, `channel`, `audit`, and `shared` module boundaries. | FND-004 | Repository structure and architecture tests | Planned |
| FR-S1-007 | Module dependency direction is documented and circular or prohibited dependencies fail automated verification. | FND-004 | Architecture-test output | Planned |
| FR-S1-008 | PostgreSQL starts locally from an OCI-compatible definition using an explicit image version and reports healthy status. | FND-005 | Container startup and health output | Planned |
| FR-S1-009 | FulfillGuard connects to PostgreSQL using environment-supplied configuration without committed credentials. | FND-005 | Application startup and connection evidence | Planned |
| FR-S1-010 | Liquibase initializes an empty database and records the executed changelog in its migration history. | FND-005 | Empty-database initialization and Liquibase history | Planned |
| FR-S1-011 | A documented command resets local database state and permits repeatable clean initialization. | FND-005 | Reset and reinitialization demonstration | Planned |
| FR-S1-012 | A Maven integration test starts a real PostgreSQL engine automatically and verifies application persistence configuration without a permanent developer database. | FND-006 | Testcontainers test and Maven report | Stretch |

## Non-functional requirements

| ID | Requirement | Deliverable | Verification method | Status |
|---|---|---|---|---|
| NFR-S1-001 | All runtime dependencies introduced in this sprint are open source and runnable locally. | All | Dependency and setup inspection | Planned |
| NFR-S1-002 | No credential, secret, machine-specific path, or private local configuration is committed. | FND-002, FND-005 | Git diff and secret review | Planned |
| NFR-S1-003 | `clean verify` is reproducible from a clean checkout without IDE-specific setup. | FND-002, FND-003, FND-004, FND-005 | Clean-checkout build evidence | Planned |
| NFR-S1-004 | `main` remains buildable and runnable after each accepted pull request. | All | Post-merge verification | Planned |
| NFR-S1-005 | Missing or invalid mandatory database configuration fails clearly and does not silently use an unintended database. | FND-005 | Negative startup tests | Planned |
| NFR-S1-006 | Automated tests are deterministic and clean up resources they create. | FND-006 | Repeated Maven test execution | Stretch |
| NFR-S1-007 | No Kafka, security platform, Kubernetes, distributed cache, external-system simulator, or business workflow is introduced. | All | Dependency and code review | Planned |
| NFR-S1-008 | Every merged change identifies its deliverable, sprint requirement IDs, issue, verification evidence, and review outcome. | GOV-003 | Pull request and sprint traceability review | Planned |
| NFR-S1-009 | Setup, reset, architecture, and known limitations are documented at the same time as the accepted implementation. | FND-004, FND-005, FND-006 | Documentation review | Planned |
| NFR-S1-010 | Verification tooling must not terminate or alter unrelated Java processes. | FND-003 | Process-isolation demonstration | Planned |

## Story and traceability map

| Story / issue | Deliverable | Requirement IDs | Branch | Pull request | Review outcome | Merge status |
|---|---|---|---|---|---|---|
| PRE-001 / #2 | GOV-002 | FR-S1-001 | Administrative change | — | Accepted | Completed |
| FG-010 / #25 | FND-002 | FR-S1-002, FR-S1-003, NFR-S1-002, NFR-S1-003, NFR-S1-008 | `chore/spr-1-bootstrap-hygiene` | — | Not reviewed | Not merged |
| FG-009 / #24 | FND-003 | FR-S1-004, FR-S1-005, NFR-S1-003, NFR-S1-008, NFR-S1-010 | `fix/spr-1-verification-workflow` | — | Not reviewed | Not merged |
| FG-002 / #4 | FND-004 | FR-S1-006, FR-S1-007, NFR-S1-003, NFR-S1-007, NFR-S1-008, NFR-S1-009 | `feature/spr-1-module-boundaries` | — | Not reviewed | Not merged |
| FG-003 / #5 | FND-005 | FR-S1-008, FR-S1-009, FR-S1-010, FR-S1-011, NFR-S1-001, NFR-S1-002, NFR-S1-003, NFR-S1-005, NFR-S1-007, NFR-S1-008, NFR-S1-009 | `feature/spr-1-postgres-liquibase` | — | Not reviewed | Not merged |
| FG-004 / #6 | FND-006 | FR-S1-012, NFR-S1-001, NFR-S1-003, NFR-S1-006, NFR-S1-008, NFR-S1-009 | `feature/spr-1-test-foundation` | — | Stretch / not started | Not merged |

## Dependencies and delivery order

```text
PRE-001 -> FG-010 -> FG-009 -> FG-002 -> FG-003 -> FG-004
```

- PRE-001 is complete.
- FG-010 establishes environment hygiene before database credentials are introduced.
- FG-009 ensures subsequent evidence is trustworthy.
- FG-002 determines module placement and dependency direction before persistence configuration is finalized.
- FG-003 establishes PostgreSQL before FG-004 adds PostgreSQL integration tests.
- FG-004 begins only when committed work is accepted and capacity remains.

## Required engineering decisions

The engineer must recommend and defend:

- Single Maven project with package-enforced modules or Maven multi-module structure
- Module dependency direction and enforcement mechanism
- Whether Spring Modulith, ArchUnit, Maven boundaries, or another mechanism best fits the selected structure
- PostgreSQL image and exact version
- Local OCI runtime and Compose-compatible strategy
- Database, schema, application-user, and test-database naming
- Environment-variable contract and safe defaults
- Liquibase root changelog and include structure
- Failure behaviour for missing or invalid database configuration
- Testcontainers lifecycle and Maven test-phase placement if FG-004 begins

For each material decision use:

```text
Decision:
Context:
Reason:
Alternatives considered:
Trade-offs:
Future impact:
```

## Explicit scope exclusions

- Product, SKU, warehouse, inventory, order, fulfilment, or channel business APIs
- Kafka, Kafka Streams, Debezium, and schema registry
- Keycloak or other authentication infrastructure
- Valkey or distributed coordination
- Kubernetes or Open Liberty deployment
- External-system simulators
- Full observability stack
- Speculative entities or tables not required to verify the persistence foundation

## Required sprint evidence

- Clean-checkout build output
- Successful and failing verifier paths
- Module structure and architecture-test results
- PostgreSQL startup and health output
- Application database-connection evidence
- Liquibase migration history from an empty database
- Database reset and repeat-initialization evidence
- Testcontainers output and Maven reports if the stretch story begins
- Pull requests linked to deliverable and requirement IDs
- Updated setup, architecture, and limitation documentation

## Acceptance tracking

| Requirement ID | Evidence reference | Accepted by | Acceptance date | Outcome / notes |
|---|---|---|---|---|
| FR-S1-001 | Repository `preferablehuman/fulfillguard`; issue #2 | Team lead | 2026-06-26 | Accepted |
| FR-S1-002 to FR-S1-012 | Pending implementing pull requests | Team lead | — | Pending |
| NFR-S1-001 to NFR-S1-010 | Pending implementing pull requests | Team lead | — | Pending |

## Sprint completion rule

Sprint 1 is complete only when every committed requirement is accepted, explicitly carried forward, or removed through documented re-scoping. Each accepted requirement must have merged evidence. Follow-up defects and debt require issue IDs, and accepted outcomes must update `docs/product/deliverables.md`.

## Deferred backlog

- FND-007 / FG-005 — Maven quality gates
- FND-008 / FG-006 — Initial ADRs
- FND-009 / FG-007 — Architecture diagrams
- FND-010 / FG-008 — Jenkins pipeline

## Sprint review and retrospective

These sections will be completed at sprint closure with demonstrated outcomes, evidence, carryover, lessons, and concrete process improvements.
