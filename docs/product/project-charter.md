# FulfillGuard Product Charter

## 1. Purpose

FulfillGuard is a backend-first order, inventory, and fulfilment orchestration platform. It coordinates order intake, stock reservation, warehouse allocation, payment status, fulfilment, shipment progress, and operational exceptions across multiple simulated sales channels and external systems.

The project is not a storefront. It represents the coordination layer that an e-commerce platform, marketplace, point-of-sale application, ERP, warehouse-management system, payment provider, or carrier would integrate with.

## 2. Product statement

> FulfillGuard helps multichannel sellers reduce overselling and detect fulfilment failures by coordinating inventory, orders, payments, warehouses, and shipments through observable and recoverable workflows.

## 3. Project objectives

The project has two equal objectives.

### 3.1 Revision objective

Reinforce professional experience with:

- Java and object-oriented design
- Spring Boot and Spring Framework
- REST APIs and integration design
- JPA, Hibernate, JDBC, SQL, and PostgreSQL
- Transaction management and concurrency
- Maven, Jenkins, and CI/CD
- JUnit and integration testing
- Logging, monitoring, and operational support
- Enterprise integration and application-server concepts
- Agile delivery and code review

### 3.2 Learning objective

Develop demonstrable experience with technologies and concepts currently underrepresented in the engineer's resume:

- Java 21
- Apache Kafka and Kafka Streams
- Event-driven architecture
- Distributed transactions and saga patterns
- Transactional outbox and Debezium CDC
- Event schemas and schema evolution
- Apicurio Registry
- CQRS projections and event replay
- Idempotent processing and delivery semantics
- Valkey caching and distributed coordination
- OAuth 2.0, OpenID Connect, and Keycloak
- OpenTelemetry and distributed tracing
- Testcontainers, contract testing, and failure testing
- Local Kubernetes and containerized delivery
- Resilience, performance, and recovery engineering

## 4. Fixed constraints

The following constraints are binding unless changed through an approved Architecture Decision Record:

1. The complete system must run locally.
2. Runtime dependencies must be open source.
3. The project is backend-first; no substantial custom frontend is required.
4. Swagger UI, API clients, dashboards, and administration consoles may provide operational interfaces.
5. Development begins as a modular monolith.
6. Microservices are introduced only when independent deployment, scaling, ownership, or failure isolation creates a documented benefit.
7. Kafka must solve a genuine event-distribution or stream-processing problem; it must not be added as decorative infrastructure.
8. Every sprint must produce a runnable and testable increment.
9. All business data must be synthetic and reproducible.
10. The implementation should remain commercially credible despite being local-only.
11. Technologies must not be added solely to enlarge the resume.
12. Product code, tests, configuration, and documentation are reviewed through pull requests.

## 5. Target users

### Primary user

An operations manager responsible for orders and fulfilment across multiple sales channels and warehouses.

### Secondary users

- Warehouse operator
- Customer-support agent
- Inventory administrator
- Integration engineer
- Platform operator
- Business analyst

### Integrating systems

- Online storefront
- Marketplace
- Physical point-of-sale system
- Wholesale ordering portal
- Warehouse-management system
- Payment provider
- Shipping carrier
- Legacy ERP

All external systems are initially represented by local simulators.

## 6. Core business capabilities

The target product will eventually support:

1. Product and SKU management
2. Warehouse management
3. Inventory balances and adjustments
4. Inventory reservation and release
5. Order intake and lifecycle management
6. Payment orchestration
7. Warehouse allocation
8. Fulfilment orchestration
9. Shipment tracking
10. Exception detection and investigation
11. Compensation and recovery
12. Real-time inventory projections
13. Event replay and reconciliation
14. Audit history
15. Operational monitoring
16. Legacy ERP integration
17. Identity and access control

## 7. Initial product scope

The first usable product increment will support:

- Multiple products and SKUs
- Multiple warehouses
- Stock-on-hand, reserved-stock, and available-stock quantities
- At least one simulated sales channel
- Order creation
- Inventory reservation
- Reservation rejection
- Order cancellation
- Audit history
- Concurrent attempts to reserve the final available unit
- Deterministic test data

The initial scope excludes:

- Customer-facing UI
- Real payment processing
- Real marketplace integrations
- Real shipping-carrier integrations
- Forecasting or machine learning
- Production cloud deployment
- Multi-region operation

## 8. Representative failure scenarios

The product must eventually handle or detect:

- Two channels attempting to sell the final unit concurrently
- Duplicate order requests
- Duplicate Kafka events
- Out-of-order events
- Payment authorization after reservation expiry
- Inventory reserved without fulfilment starting
- Warehouse rejection
- Shipment deadline violation
- Consumer failure after processing but before offset commit
- Database commit followed by event-publication failure
- Poison messages
- Schema-incompatible messages
- Consumer lag
- Service restart during an active workflow
- Partial compensation
- Inventory-projection drift
- Cache inconsistency
- Network latency, timeout, or partial outage

These are product requirements, not merely test concerns.

## 9. Architecture evolution

### Phase 1 — Modular monolith

Initial logical modules:

- catalog
- warehouse
- inventory
- order
- fulfilment
- channel
- audit
- shared

This phase establishes domain terminology, aggregate boundaries, transaction boundaries, persistence design, API contracts, concurrency behaviour, and module dependencies.

### Phase 2 — Event-enabled modular monolith

Kafka is introduced for domain-event publication and asynchronous processing while the main business capabilities remain in one deployable application.

### Phase 3 — Selective service extraction

Capabilities are extracted only when justified by deployment independence, scaling, ownership, or failure isolation. Inventory is the likely first extraction candidate.

### Phase 4 — Distributed workflow platform

The system evolves to include:

- Order saga
- Payment, warehouse, and shipping simulators
- Transactional outbox
- Debezium CDC
- Kafka Streams projections
- Schema registry
- Distributed tracing
- Local Kubernetes deployment

## 10. Product success criteria

The project is successful when it can demonstrate, with reproducible tests and operational evidence:

- Correct inventory reservation under concurrent load
- Prevention or safe handling of duplicate operations
- Recoverable order workflows across component failures
- Consistent event publication after database commit
- Explainable handling of retries and dead-letter events
- Real-time projections built from event streams
- Traceability across HTTP, database, and Kafka boundaries
- Automated local build, test, packaging, and deployment
- Clear architectural decisions and documented trade-offs
- Resume claims supported by working code, tests, and measurements

## 11. Current status

The project is in product initiation. Sprint 0 begins after the initiation documents, branch conventions, review process, and backlog are accepted.
