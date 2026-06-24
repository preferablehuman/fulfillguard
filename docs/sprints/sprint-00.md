# Sprint 0 — Engineering Foundation

## Sprint summary

- **Sprint:** 0
- **Duration:** One week
- **Committed capacity:** 8–12 hours
- **Product phase:** Engineering foundation
- **Sprint status:** Not started

## Sprint goal

Create a reliable, documented, and locally runnable foundation for FulfillGuard so business functionality can begin without immediate repository or architecture restructuring.

## Business outcome

Sprint 0 does not deliver customer-facing behaviour. Its outcome is reduced delivery risk through a reproducible build, explicit module boundaries, a real database test strategy, automated quality checks, and documented architectural decisions.

## Committed backlog

### FG-001 — Bootstrap the application

**User story**

As a backend engineer, I need a Java and Spring Boot application that starts successfully so future product capabilities have a stable foundation.

**Acceptance criteria**

- The project uses Java 21.
- Maven is the build system.
- The application starts locally from documented commands.
- A health endpoint confirms that the application is running.
- The build succeeds from a clean checkout.
- No IDE-specific setup is required.
- The application name is `fulfillguard`.
- The base package follows a consistent reverse-domain naming convention.
- Startup, build, and test commands are documented.
- Dependency versions are controlled through Spring Boot dependency management or an explicitly justified alternative.

**Required evidence**

- Clean Maven build output
- Successful application startup
- Health endpoint response
- Repository tree

### FG-002 — Establish the modular-monolith structure

**User story**

As the engineering team, we need explicit module boundaries so FulfillGuard does not become an unstructured application.

**Initial modules**

- catalog
- warehouse
- inventory
- order
- audit
- shared

**Acceptance criteria**

- Module boundaries are visible in the package or Maven structure.
- Dependencies between modules are documented.
- Circular dependencies are not permitted.
- The `shared` module or package contains only deliberately shared technical or domain primitives.
- Business functionality is not required yet.
- An architecture-test or module-enforcement mechanism is selected and documented.
- The chosen structure supports future extraction of inventory into a separate service.

**Engineering decision required**

Choose between:

- One deployable Maven project with package-enforced modules
- Maven multi-module project

The engineer must recommend one approach and document the trade-offs.

### FG-003 — Configure PostgreSQL and Liquibase

**User story**

As a developer, I need a reproducible PostgreSQL environment and migration process so persistence work can begin safely in Sprint 1.

**Acceptance criteria**

- PostgreSQL runs locally through an OCI-compatible container definition.
- The image version is explicit and not `latest`.
- Credentials are supplied through environment configuration and are not committed.
- The application connects to PostgreSQL.
- Liquibase runs an initial migration.
- A new database can be created from repository instructions.
- The database container has a health check.
- A documented command resets local database state.
- The application fails clearly when required database configuration is missing or invalid.

**Required evidence**

- Container startup output
- Database health status
- Liquibase migration history
- Successful clean-database initialization

### FG-004 — Establish automated test foundations

**User story**

As the engineering team, we need a reliable testing baseline so future functionality can be delivered safely.

**Acceptance criteria**

- At least one pure unit test executes through Maven.
- At least one Spring context test executes through Maven.
- At least one PostgreSQL integration test uses a real PostgreSQL engine.
- Testcontainers is preferred unless an alternative is justified.
- Tests do not depend on a developer's permanently running local database.
- Test reports are generated.
- Tests are deterministic.
- Integration-test setup and cleanup are automatic.

**Required evidence**

- Maven test output
- Test report locations
- Explanation of the unit, context, and integration-test boundaries

### FG-005 — Establish quality gates

**User story**

As the engineering team, we need automated quality checks so baseline standards are enforced consistently.

**Candidate tools**

- JaCoCo
- Checkstyle
- SpotBugs
- PMD
- OWASP Dependency-Check

**Acceptance criteria**

- Style or formatting violations fail the build.
- Unit-test failures fail the build.
- A coverage report is generated.
- At least one static-analysis report is generated.
- Selected thresholds and exclusions are documented.
- Thresholds are useful but not artificially extreme.
- Generated reports are excluded from version control.
- The build lifecycle used locally and in Jenkins is documented.

### FG-006 — Record initial architecture decisions

Create:

- ADR-001 — Begin as a modular monolith
- ADR-002 — Java and Spring Boot baseline
- ADR-003 — PostgreSQL and Liquibase
- ADR-004 — Local container runtime and environment strategy
- ADR-005 — Package-by-feature and module-boundary enforcement

**Acceptance criteria**

Each ADR contains:

- Status
- Date
- Context
- Decision
- Alternatives considered
- Consequences
- Validation
- Revisit conditions

The ADRs must describe real trade-offs rather than restating the selected technology.

### FG-007 — Create initial architecture diagrams

Create:

- System context diagram
- Initial container diagram
- Initial module dependency diagram

**Acceptance criteria**

- Diagrams are stored in a text-based source format.
- Diagrams match the actual repository and intended Sprint 0 architecture.
- External systems are shown as simulators rather than production integrations.
- Future Kafka and microservice components are not represented as already implemented.
- Diagram rendering instructions are documented.

Acceptable formats include Mermaid, PlantUML, or Structurizr DSL.

### FG-008 — Create the initial Jenkins pipeline

**User story**

As the engineering team, we need pipeline-as-code so the repository can be built and evaluated consistently.

**Minimum stages**

1. Checkout
2. Environment verification
3. Maven compile
4. Unit and integration tests
5. Static analysis
6. Package
7. Archive reports

**Acceptance criteria**

- A `Jenkinsfile` is committed.
- Stages are clearly named.
- A failed test or quality gate fails the pipeline.
- Reports are archived where supported.
- No credentials are embedded in the pipeline.
- The pipeline uses the same Maven commands documented for local development.
- If Jenkins is not installed during Sprint 0, the file must still be syntax-reviewed and the limitation recorded.

## Technical decisions owned by the engineer

The engineer must propose and justify:

1. Single Maven project with package modules or Maven multi-module project
2. Exact Spring Boot version
3. Base package name
4. Local container runtime and Compose-compatible strategy
5. Database naming conventions
6. Error-handling baseline
7. Logging format
8. Architecture-test mechanism
9. Diagramming format
10. Initial test strategy

For each significant decision, use:

```text
Decision:
Context:
Reason:
Alternatives considered:
Trade-offs:
Future impact:
```

## Non-functional requirements

- Clean builds must be reproducible.
- Secrets must not be committed.
- Local setup must be documented.
- The application must fail fast for missing mandatory configuration.
- Build and startup logs must be understandable.
- Repository structure must support later Kafka introduction and service extraction.
- Proprietary development software must not be required.
- Normal development must not require all future platform components.

## Scope restrictions

Do not introduce during Sprint 0 unless a blocking foundation requirement is approved:

- Apache Kafka
- Kafka Streams
- Debezium
- Apicurio Registry
- Valkey
- Keycloak
- Kubernetes
- Open Liberty
- Payment, warehouse, shipping, or ERP simulators
- Full observability stack
- Product business entities beyond what is strictly necessary to prove the foundation

Adding these early will be treated as scope expansion, not initiative.

## Expected repository shape

This is a starting hypothesis, not a mandatory implementation:

```text
fullfillguard/
├── .github/
│   └── pull_request_template.md
├── docs/
│   ├── architecture/
│   │   ├── adr/
│   │   └── diagrams/
│   ├── engineering/
│   ├── product/
│   ├── sprints/
│   └── team/
├── src/
│   ├── main/
│   │   ├── java/<base-package>/
│   │   │   ├── catalog/
│   │   │   ├── warehouse/
│   │   │   ├── inventory/
│   │   │   ├── order/
│   │   │   ├── audit/
│   │   │   └── shared/
│   │   └── resources/
│   │       ├── db/changelog/
│   │       └── application.yml
│   └── test/
├── compose.yaml
├── CONTRIBUTING.md
├── Jenkinsfile
├── pom.xml
└── README.md
```

## First engineering checkpoint

Implement FG-001 through FG-004 before expanding to the rest of the sprint.

Required checkpoint submission:

- Repository branch or pull request
- Repository tree
- Root `pom.xml`
- Application configuration
- Proposed module structure
- Local PostgreSQL definition
- Initial Liquibase changelog
- Unit, context, and PostgreSQL integration tests
- README setup instructions
- Written recommendations for remaining Sprint 0 technical decisions

## Demonstration checklist

At sprint review, demonstrate:

1. Start from a clean checkout.
2. Start PostgreSQL.
3. Run the Maven build.
4. Show passing tests.
5. Start FulfillGuard.
6. Call the health endpoint.
7. Show Liquibase migration history.
8. Show coverage and static-analysis reports.
9. Walk through module boundaries.
10. Explain the ADRs and diagrams.
11. Run or validate the Jenkins pipeline.
12. Show that no secrets or generated build directories are tracked.

## Review questions

Be prepared to answer:

1. Why did you choose package modules or Maven modules?
2. What prevents modules from becoming tightly coupled?
3. Why is the selected Spring Boot version appropriate?
4. How are local secrets supplied?
5. Why initialize Liquibase before business tables exist?
6. Which tests use a real PostgreSQL instance?
7. Which checks fail the build?
8. How does the structure support extracting inventory later?
9. What would change before production deployment?
10. What technical debt was deliberately accepted?

## Sprint completion rule

Sprint 0 closes only after the committed stories satisfy the project Definition of Done or are explicitly re-scoped with a documented reason. Calendar expiry does not automatically complete the sprint.
