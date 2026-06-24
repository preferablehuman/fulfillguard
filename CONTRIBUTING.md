# Contributing to FulfillGuard

FulfillGuard is developed through sprint-scoped branches, pull requests, and explicit review outcomes.

## 1. Before starting work

1. Confirm that a GitHub issue or sprint story defines the requirement.
2. Read the applicable product, sprint, engineering, and architecture documents under `docs/`.
3. Identify acceptance criteria and required evidence.
4. Raise ambiguity before implementing a materially different interpretation.
5. Do not add future-roadmap technology without an approved requirement.

## 2. Branch naming

Use short-lived branches:

- `feature/fg-###-short-description`
- `fix/fg-###-short-description`
- `docs/short-description`
- `chore/short-description`
- `spike/short-description`

Examples:

```text
feature/fg-001-project-bootstrap
feature/fg-003-postgres-liquibase
fix/fg-002-module-cycle
```

## 3. Commit messages

Use concise imperative messages with a type where helpful:

```text
feat: add inventory reservation endpoint
fix: prevent duplicate reservation processing
test: cover concurrent final-unit reservation
docs: record PostgreSQL migration decision
chore: configure Maven quality plugins
```

Keep commits coherent. Do not mix unrelated formatting, refactoring, and feature behaviour without explanation.

## 4. Pull requests

A pull request must describe:

- Related issue or story
- Purpose and scope
- Design decisions
- Acceptance criteria satisfied
- Tests executed
- Risks and known limitations
- Documentation changes

A pull request may be rejected for being too large, combining unrelated work, lacking evidence, or introducing unjustified complexity.

## 5. Local verification

Before requesting review:

- Build from a clean state.
- Run all required unit and integration tests.
- Run configured quality checks.
- Confirm database migrations work from an empty database when changed.
- Confirm no secrets, generated outputs, or IDE-specific files are tracked.
- Update documentation.

Exact commands will be added during Sprint 0 after the Maven lifecycle is established.

## 6. Architecture decisions

Create an ADR for significant decisions. Follow [`docs/architecture/decision-process.md`](docs/architecture/decision-process.md).

## 7. Review response

Address blocking and major comments before merge. Explain disagreements with evidence rather than silently ignoring comments. Do not resolve review threads until the underlying concern has been answered or fixed.

## 8. Merge policy

`main` represents accepted work. Use pull requests for product and engineering changes. Direct commits to `main` should be limited to unavoidable repository initialization or an explicitly approved emergency correction.
