# Architecture Decision Process

## 1. Purpose

Architecture Decision Records capture significant technical decisions, their context, alternatives, and consequences. They prevent the project from repeatedly revisiting decisions without evidence and make trade-offs visible during code review.

## 2. Decisions requiring an ADR

Create an ADR when a decision materially affects one or more of the following:

- System architecture or deployable boundaries
- Module ownership or dependencies
- Database technology, ownership, or schema strategy
- Transaction boundaries and consistency model
- Messaging, Kafka topic design, partitioning, or delivery guarantees
- Event schema format or compatibility policy
- API style or compatibility policy
- Authentication, authorization, or secrets handling
- Runtime, application server, containers, or orchestration
- Observability architecture
- Major framework or library adoption
- Technology that is difficult or expensive to reverse
- A fixed project constraint

Routine implementation choices do not need individual ADRs.

## 3. ADR lifecycle

Each ADR uses one of these statuses:

- **Proposed** — under review and not yet authoritative
- **Accepted** — approved and active
- **Superseded** — replaced by a later ADR
- **Deprecated** — still present but should no longer guide new work
- **Rejected** — considered and deliberately not selected

Accepted ADRs are not immutable. Reversal requires a new ADR that explains the changed context and supersedes the previous record.

## 4. ADR template

```text
# ADR-NNN: Decision title

Status: Proposed | Accepted | Superseded | Deprecated | Rejected
Date: YYYY-MM-DD
Owners: names or roles
Related stories: FG-###

## Context
What problem or force requires a decision? Include constraints and evidence.

## Decision
State the selected approach precisely.

## Alternatives considered
Describe credible alternatives and why they were not selected.

## Consequences
List positive, negative, operational, testing, security, and migration consequences.

## Validation
Explain how the decision will be tested or reviewed.

## Revisit conditions
State which evidence or changed condition should trigger reconsideration.
```

## 5. Evaluation criteria

Architectural recommendations should be evaluated against:

- Correctness and preservation of business invariants
- Simplicity and cognitive load
- Local reproducibility
- Open-source licensing
- Testability
- Operability and failure recovery
- Security
- Performance and scalability requirements
- Compatibility and migration cost
- Educational value without artificial complexity
- Future service extraction
- Time available within the sprint plan

## 6. Initial ADR backlog

Sprint 0 must create at least:

- ADR-001 — Begin as a modular monolith
- ADR-002 — Java and Spring Boot baseline
- ADR-003 — PostgreSQL and Liquibase
- ADR-004 — Local container runtime and environment strategy
- ADR-005 — Package-by-feature and module-boundary enforcement

The engineer owns the initial recommendation for ADR-002 through ADR-005. ADR-001 is a product-level architecture constraint but must still document alternatives and consequences.

## 7. Architecture review standard

An ADR may be rejected when:

- It selects a technology before defining the requirement.
- It omits realistic alternatives.
- It ignores local execution or open-source constraints.
- It claims scalability or reliability without a measurable scenario.
- It adds operational burden disproportionate to product value.
- It relies on future refactoring without describing a migration path.
- It uses a pattern by name without defining the failure or consistency problem it solves.

## 8. Storage convention

Store ADRs under:

```text
docs/architecture/adr/
```

Use file names such as:

```text
0001-modular-monolith.md
0002-java-spring-baseline.md
```

Never renumber an accepted ADR.
