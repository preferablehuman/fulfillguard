# Engineering Standards

## 1. General principles

- Prefer simple designs that preserve correctness and make future change possible.
- Do not introduce distributed infrastructure until the product requirement justifies it.
- Protect business invariants in more than one layer where appropriate: domain logic, transaction boundaries, and database constraints.
- Treat failure handling, operability, and testability as part of the feature.
- Use current, supported open-source dependencies and document material licensing concerns.
- Do not claim production readiness without production-grade evidence.

## 2. Java baseline

- Target Java 21 unless an approved ADR changes the baseline.
- Use modern Java features when they improve clarity; do not use them merely to demonstrate syntax.
- Prefer immutable request, response, event, and value objects where practical.
- Avoid shared mutable state.
- Use explicit domain types for identifiers, money, quantities, and status where primitive values would create ambiguity.
- Do not catch broad exceptions without a defined recovery or translation strategy.
- Preserve interrupt status when handling interrupted threads.
- Avoid blocking work on event-loop or limited executor threads.

## 3. Spring application design

- Package by feature or domain rather than maintaining only controller/service/repository technical layers.
- Keep controllers thin. Controllers validate transport-level input, invoke application use cases, and map results.
- Do not embed business rules in controllers, entity callbacks, mappers, or configuration classes.
- Declare transaction boundaries at the application-service level unless a documented alternative is required.
- Avoid self-invocation assumptions with proxy-based annotations such as `@Transactional` and `@Async`.
- Use constructor injection.
- Externalize environment-specific configuration.
- Fail fast for missing mandatory configuration.
- Avoid exposing JPA entities directly through public APIs.

## 4. Domain and persistence

- Define aggregate boundaries before implementing repositories.
- A transaction should normally modify one aggregate unless a documented use case requires otherwise.
- Critical invariants must have database protection where possible.
- Use database migrations for every schema change.
- Migrations must be forward-repeatable from an empty database.
- Avoid destructive migration changes without an explicit migration strategy.
- Review fetch strategies, cascade rules, and orphan removal deliberately.
- Avoid unbounded collection loading and N+1 query behaviour.
- Use optimistic or pessimistic locking only after defining the conflicting operation and expected contention.
- Do not use distributed locks to conceal an incorrect data model.

## 5. API design

- Public HTTP APIs must be documented with OpenAPI.
- Use request and response models distinct from persistence entities.
- Apply Bean Validation to externally supplied input.
- Use a consistent machine-readable error representation, preferably Problem Details.
- Define idempotency behaviour for commands that may be retried.
- Use appropriate HTTP status codes; do not return success for rejected business operations.
- Version APIs only when compatibility requirements justify it.
- Pagination is required for potentially unbounded collections.
- Do not expose stack traces or internal exception details.

## 6. Event design

These standards become active when Kafka is introduced.

- Events represent immutable facts that have already occurred.
- Commands and events must not be confused.
- Every event must have a unique event ID, type, version, occurrence time, producer, and correlation metadata.
- Partition-key choice must be documented against ordering requirements.
- Consumers must assume duplicate delivery.
- Consumer side effects must be idempotent or safely deduplicated.
- Event schemas must be registered and compatibility checked.
- Sensitive data must not be published without an explicit requirement and review.
- Retry and dead-letter behaviour must be designed per failure category.
- Offset commits must align with side-effect completion.
- “Exactly once” claims must identify the boundary over which the guarantee applies.

## 7. Testing

Required test layers will be selected by feature, but the project should include:

- Unit tests for domain behaviour and pure logic
- Spring slice tests where they provide focused value
- Integration tests against real PostgreSQL using Testcontainers
- API tests for public contracts
- Concurrency tests for inventory invariants
- Consumer and producer integration tests when Kafka is introduced
- Contract tests for external simulators and extracted services
- Failure tests for retry, timeout, duplicate, and recovery behaviour
- Performance tests for defined capacity questions

Test requirements:

- Tests must be deterministic.
- Time-dependent behaviour should use an injected clock.
- Random test data must record its seed.
- Avoid mocking repositories in tests intended to validate persistence behaviour.
- Do not assert implementation trivia when observable behaviour is sufficient.
- A failing test must provide enough context to diagnose the scenario.

## 8. Code quality

The Maven build will progressively enforce:

- Formatting or style checks
- Unit and integration tests
- JaCoCo coverage reporting
- Checkstyle
- SpotBugs
- PMD where its rules provide value
- OWASP Dependency-Check
- Architecture tests

Coverage percentage alone is not a quality measure. Critical domain branches, failures, and invariants matter more than inflated line coverage.

## 9. Logging and observability

- Use structured logs when introduced by the sprint plan.
- Include correlation identifiers for workflows.
- Do not log credentials, tokens, secrets, or unnecessary personal data.
- Log state transitions and integration failures at an appropriate level.
- Avoid duplicate logging of the same exception at multiple layers.
- Metrics must answer an operational question.
- Traces must cross HTTP and messaging boundaries once distributed components are introduced.
- Health endpoints must distinguish liveness from dependency readiness when relevant.

## 10. Security

- No credentials or secrets may be committed.
- Local secrets must be supplied through ignored environment files, environment variables, or an approved local secret mechanism.
- Dependency versions and vulnerabilities must be reviewed.
- Validate file, network, and API input at trust boundaries.
- Apply least privilege to database users, service accounts, and containers where practical.
- Authentication and authorization will be introduced through an approved sprint rather than improvised early.
- Security-sensitive decisions require threat considerations in the PR or ADR.

## 11. Containers and local infrastructure

- Container definitions must be reproducible from the repository.
- Use explicit image versions; avoid unqualified `latest` tags.
- Add health checks where startup order or readiness matters.
- Persist only data that needs to survive container recreation.
- Document cleanup and reset commands.
- Infrastructure profiles should avoid running the entire future platform during ordinary development.
- Product services should not require proprietary container tooling.

## 12. Documentation

Update documentation when a change affects:

- Product behaviour
- Setup or build commands
- Architecture or module boundaries
- API or event contracts
- Data model or migrations
- Operational procedures
- Known limitations
- Security assumptions

Significant architectural decisions require an ADR. Code comments should explain non-obvious reasons, not restate code.

## 13. Commit and pull-request quality

- Commits should be coherent and have descriptive imperative messages.
- Do not mix unrelated refactoring with feature work without explanation.
- Pull requests should remain reviewable.
- Generated build outputs, credentials, local IDE files, and unnecessary binaries must not be committed.
- A PR must state how it was tested and which acceptance criteria it satisfies.
