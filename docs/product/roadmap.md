# FulfillGuard Product and Learning Roadmap

## Roadmap principles

- Each sprint must produce a runnable increment.
- Existing Java and Spring skills are revised before distributed complexity is introduced.
- New technology is adopted only when the current product behaviour creates a credible need.
- The roadmap may change when sprint evidence invalidates an assumption.
- Sprint completion is based on acceptance criteria and review, not calendar expiry.

## Phase 0 — Initiation

Outcomes:

- Product charter accepted
- Team operating model established
- Engineering standards established
- Architecture decision process established
- Sprint 0 backlog created
- Repository and pull-request conventions established

## Sprint 0 — Engineering foundation

Primary learning and revision:

- Java 21 and Spring Boot project setup
- Maven build structure
- Modular-monolith organization
- PostgreSQL and Liquibase
- Testcontainers
- Code-quality gates
- Jenkins pipeline foundation
- Architecture Decision Records

Product outcome:

A clean, documented, locally reproducible foundation ready for business functionality.

## Sprint 1 — Synchronous order and inventory workflow

Primary learning and revision:

- REST resource design
- Bean Validation
- Error handling
- JPA and Hibernate
- Aggregate design
- Transaction boundaries
- Database constraints

Product outcome:

Create products, warehouses, inventory, and orders; reserve inventory synchronously and reject invalid reservations.

## Sprint 2 — Concurrency correctness

Primary learning:

- Lost updates
- Optimistic locking
- Pessimistic locking
- Isolation levels
- Idempotency keys
- Concurrent integration testing

Product outcome:

Correctly handle multiple requests attempting to reserve the final available units.

## Sprint 3 — Kafka fundamentals

Primary learning:

- Producers and consumers
- Topic design
- Partitions and keys
- Consumer groups
- Offset handling
- Event envelopes

Product outcome:

Publish and consume order and inventory events with documented ordering behaviour.

## Sprint 4 — Kafka failure handling

Primary learning:

- At-least-once delivery
- Idempotent consumers
- Retry topics
- Dead-letter topics
- Poison events
- Replay

Product outcome:

Recover safely from duplicate, transient, and non-retryable event-processing failures.

## Sprint 5 — Transactional outbox and Debezium

Primary learning:

- Dual-write failure
- Transactional outbox
- Change data capture
- Debezium connectors
- Event publication after commit

Product outcome:

Eliminate the inconsistency window between committed database state and event publication.

## Sprint 6 — Inventory-service extraction

Primary learning:

- Service-boundary extraction
- Database ownership
- Eventual consistency
- API and event contracts
- Local distributed debugging

Product outcome:

Move inventory into an independently deployable service without breaking order workflow correctness.

## Sprint 7 — Order saga

Primary learning:

- Saga orchestration and choreography
- Timeouts
- Compensation
- Durable workflow state
- Recovery after restart

Product outcome:

Coordinate inventory, payment, warehouse, and fulfilment simulators through a recoverable order workflow.

## Sprint 8 — Kafka Streams

Primary learning:

- Stateful stream processing
- KTables and joins
- Windowing
- Event time
- Late and out-of-order events
- Materialized state stores

Product outcome:

Build real-time inventory and operational-exception projections from event streams.

## Sprint 9 — Schema governance

Primary learning:

- Avro or JSON Schema
- Apicurio Registry
- Compatibility modes
- Consumer-driven contract testing
- AsyncAPI

Product outcome:

Protect producers and consumers from incompatible event evolution.

## Sprint 10 — Caching and distributed coordination

Primary learning:

- Valkey
- Cache-aside behaviour
- Expiration
- Reservation timeout state
- Distributed rate limits
- Cache invalidation and stampede prevention

Product outcome:

Improve selected read and coordination paths without weakening the database source of truth.

## Sprint 11 — Security

Primary learning:

- Keycloak
- OAuth 2.0
- OpenID Connect
- Service accounts
- Scopes and roles
- Tenant-aware authorization

Product outcome:

Protect administrative and integration APIs through a locally reproducible identity platform.

## Sprint 12 — Observability

Primary learning:

- OpenTelemetry
- Trace propagation through Kafka
- Prometheus metrics
- Grafana dashboards
- Tempo traces
- Loki logs
- Service-level indicators

Product outcome:

Trace an order from HTTP intake through database and messaging boundaries and identify failures operationally.

## Sprint 13 — Jenkins and local Kubernetes

Primary learning:

- Pipeline as code
- Container image builds
- kind Kubernetes
- Health probes
- Rolling deployments
- Smoke tests and rollback

Product outcome:

Build, test, package, deploy, verify, and roll back FulfillGuard locally through an automated pipeline.

## Sprint 14 — Resilience and performance

Primary learning:

- Broker and consumer failure
- Network fault injection
- Backpressure
- Load testing
- Capacity analysis
- Recovery time

Product outcome:

Produce measured evidence of behaviour under load and infrastructure failure.

## Later candidate increments

These are not committed roadmap items:

- Returns and refunds
- Backorders
- Split fulfilment across warehouses
- Legacy ERP adapter on Open Liberty
- gRPC for selected internal communication
- OpenSearch-based operational investigation
- Feature flags
- Inventory forecasting
- Anomaly detection
- Native-image experiments

## Resume evidence policy

A skill may be presented as project experience only after the relevant sprint produces:

- Working code
- Automated tests
- Documented architecture
- Demonstrated failure behaviour
- Measured or observable evidence where applicable

Reading documentation or adding an unused dependency does not qualify.
