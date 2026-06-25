# FulfillGuard Deliverables Catalogue

## Purpose

This document is the canonical catalogue of product, engineering, architecture, and operational deliverables for FulfillGuard.

A deliverable describes an accepted outcome. It is larger and more stable than a sprint story. Sprints select deliverables or bounded portions of deliverables, define exact functional and non-functional requirements, and create stories to implement them.

The traceability chain is:

```text
Deliverable -> Sprint requirement -> Story or defect -> Branch and pull request -> Evidence -> Acceptance -> Deliverable status
```

## Status model

- **Proposed:** Candidate outcome that is not part of the committed roadmap.
- **Backlog:** Accepted as required, but not assigned to an active sprint.
- **Planned:** Selected for a future or active sprint but not yet being implemented.
- **In progress:** At least one implementing story is active.
- **Partially accepted:** Some outcome requirements are accepted; material requirements remain.
- **Accepted:** The defined outcome is demonstrated by merged code, tests, documentation, and required evidence.
- **Superseded:** Replaced by another deliverable or decision.

Only the product owner/team lead changes a deliverable to **Accepted**. Issue closure or code compilation alone is not acceptance.

## Evidence policy

The evidence required depends on the deliverable, but acceptance normally requires:

- Working code or configuration where applicable
- Automated tests at the appropriate boundary
- Demonstrated success and important failure behaviour
- Updated architecture, API, event, operational, or setup documentation
- A reviewed and merged pull request
- Measured or observable evidence when performance, resilience, or operability is claimed

## Governance and foundation deliverables

| ID | Deliverable | Outcome | Status | Current traceability |
|---|---|---|---|---|
| GOV-001 | Product and delivery governance | Charter, roadmap, operating model, engineering standards, branching policy, and review process define how the project is governed. | Accepted | Initiation documentation and PRs #1, #11, #27 |
| GOV-002 | Canonical repository identity | Repository, links, and local remotes use the correct `preferablehuman/fulfillguard` identity. | Accepted | PRE-001 / issue #2 |
| GOV-003 | Deliverable and requirement traceability | Deliverables, sprint requirements, issues, pull requests, evidence, and acceptance remain linked. | In progress | FG-011 / issue #28 |
| FND-001 | Runnable Java application baseline | Java 21 Spring Boot application builds, tests, packages as an executable JAR, starts locally, and exposes health. | Accepted | FG-001 / PR #23 |
| FND-002 | Bootstrap metadata and environment hygiene | Maven metadata, local environment exclusions, and evidence conventions are clean and intentional. | Planned | FG-010 / Sprint 1 |
| FND-003 | Safe local verification workflow | Local verification reliably checks build, tests, startup, and health without affecting unrelated processes. | Planned | FG-009 / Sprint 1 |
| FND-004 | Modular-monolith boundaries | Domain modules and dependency rules are explicit, documented, and automatically enforced. | Planned | FG-002 / Sprint 1 |
| FND-005 | PostgreSQL and Liquibase foundation | A reproducible PostgreSQL environment and repeatable schema migration process are available locally. | Planned | FG-003 / Sprint 1 |
| FND-006 | Automated test foundation | Unit, Spring context, and real PostgreSQL integration tests run deterministically through Maven. | Planned | FG-004 / Sprint 1 stretch |
| FND-007 | Maven quality gates | Coverage and selected static-analysis checks produce reports and enforce agreed thresholds. | Backlog | FG-005 |
| FND-008 | Architecture decision record baseline | Significant architecture choices are captured with context, alternatives, consequences, validation, and revisit conditions. | Backlog | FG-006 |
| FND-009 | Architecture diagram baseline | System context, container, and module dependency diagrams match the accepted implementation. | Backlog | FG-007 |
| FND-010 | Continuous integration pipeline | Jenkins pipeline builds, tests, analyzes, packages, and archives evidence using the local Maven lifecycle. | Backlog | FG-008 |

## Core product deliverables

| ID | Deliverable | Outcome | Status |
|---|---|---|---|
| CAP-001 | Product and SKU management | Products and SKUs can be created, queried, validated, and maintained through documented APIs. | Backlog |
| CAP-002 | Warehouse management | Warehouses can be created, queried, activated, and used as inventory locations. | Backlog |
| CAP-003 | Inventory balances and adjustments | Stock-on-hand, reserved, and available quantities are represented with auditable adjustment rules. | Backlog |
| CAP-004 | Inventory reservation and release | Inventory can be reserved and released while preserving quantity invariants. | Backlog |
| CAP-005 | Order intake and lifecycle | Orders can be accepted, validated, queried, cancelled, and transitioned through defined lifecycle states. | Backlog |
| CAP-006 | Audit history | Important state changes and operator-relevant actions are recorded and queryable. | Backlog |
| CAP-007 | Sales-channel integration boundary | At least one local channel simulator submits orders through a documented and idempotent integration contract. | Backlog |
| CAP-008 | Payment orchestration | Payment authorization outcomes participate in order workflow without real payment processing. | Backlog |
| CAP-009 | Warehouse allocation and fulfilment | Orders are allocated to warehouses and progress through locally simulated fulfilment decisions. | Backlog |
| CAP-010 | Shipment tracking | Shipment status and deadline progress can be ingested, queried, and correlated to orders. | Backlog |
| CAP-011 | Exception detection and investigation | Operational exceptions are detected, classified, surfaced, and traceable to affected workflow state. | Backlog |
| CAP-012 | Compensation and recovery | Failed multi-step workflows execute safe, idempotent compensation or enter an actionable recovery state. | Backlog |
| CAP-013 | Reconciliation and event replay | Authoritative state can be compared with projections and repaired through controlled replay or reconciliation. | Backlog |
| CAP-014 | Legacy ERP integration | A justified adapter exchanges data with a locally simulated legacy ERP boundary. | Backlog |

## Correctness and distributed-system deliverables

| ID | Deliverable | Outcome | Status |
|---|---|---|---|
| COR-001 | Concurrency-correct reservation | Concurrent attempts to reserve final stock cannot oversell or corrupt inventory state. | Backlog |
| COR-002 | Idempotent command handling | Duplicate requests are detected or safely replayed without duplicate business effects. | Backlog |
| EVT-001 | Domain-event publication | Order and inventory events are published and consumed with documented keys, partitioning, ordering, and envelopes. | Backlog |
| EVT-002 | Event failure handling | Duplicate, transient, poison, and non-retryable events are handled through idempotency, retry, dead-letter, and replay policies. | Backlog |
| EVT-003 | Transactional outbox and CDC | Database state and event publication remain consistent through an outbox and Debezium change-data capture. | Backlog |
| SVC-001 | Inventory service extraction | Inventory becomes independently deployable with explicit ownership and preserved order-workflow correctness. | Backlog |
| WFL-001 | Recoverable order saga | Inventory, payment, warehouse, and shipping steps are coordinated with durable state, timeouts, and compensation. | Backlog |
| STR-001 | Real-time operational projections | Kafka Streams builds inventory and exception projections with defined event-time and out-of-order behaviour. | Backlog |
| SCH-001 | Event schema governance | Event schemas use registry-backed compatibility rules, contract tests, and AsyncAPI documentation. | Backlog |

## Platform and operational deliverables

| ID | Deliverable | Outcome | Status |
|---|---|---|---|
| OPS-001 | Cache and distributed coordination | Selected read and coordination paths use Valkey without weakening PostgreSQL as source of truth. | Backlog |
| SEC-001 | Identity and access control | Administrative and integration APIs use locally reproducible OAuth 2.0 and OpenID Connect authorization. | Backlog |
| OBS-001 | End-to-end observability | Logs, metrics, and traces correlate an order across HTTP, database, and messaging boundaries. | Backlog |
| DEL-001 | Containerized local delivery | The system is built, packaged, deployed, verified, and rolled back locally through Jenkins and kind Kubernetes. | Backlog |
| RES-001 | Resilience and performance evidence | Behaviour under load, latency, process failure, broker failure, and recovery is measured and documented. | Backlog |

## Candidate deliverables

These remain **Proposed** until promoted through backlog refinement:

- Returns and refunds
- Backorders
- Split fulfilment across warehouses
- Feature flags
- OpenSearch-based operational investigation
- Inventory forecasting
- Anomaly detection
- Native-image experiments
- gRPC for selected internal communication

## Sprint selection rules

A deliverable may span multiple sprints. A sprint must select either the complete deliverable or a clearly bounded increment of it.

Each selected increment must define:

1. Deliverable ID
2. Exact sprint functional requirements
3. Exact sprint non-functional requirements
4. Implementing story or defect IDs
5. Dependencies and scope exclusions
6. Required evidence
7. Pull-request and merge status
8. Final acceptance outcome

Unselected portions remain in this catalogue and must not be implied as delivered.

## Update rules

- The catalogue is maintained by the product owner/team lead.
- Sprint assignment is authoritative in the relevant `docs/sprints/sprint-XX.md` file.
- Implementation detail belongs in issues, ADRs, code, and pull requests rather than being duplicated here.
- At merge, the sprint traceability table is updated with the PR and review outcome.
- At sprint closure, accepted outcomes update this catalogue; partial or carried work remains explicit.
