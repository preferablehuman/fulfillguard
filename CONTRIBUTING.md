# Contributing to FulfillGuard

FulfillGuard is developed through sprint-scoped branches, pull requests, and explicit review outcomes.

## 1. Before starting work

1. Confirm that a GitHub issue or sprint story defines the requirement.
2. Read the applicable product, sprint, engineering, and architecture documents under `docs/`.
3. Identify acceptance criteria and required evidence.
4. Raise ambiguity before implementing a materially different interpretation.
5. Do not add future-roadmap technology without an approved requirement.

## 2. Branch naming

Use short-lived branches with this required format:

```text
<type>/spr-<sprint-number>-<short-description>
```

Approved branch types:

- `feature` — product or engineering capability
- `fix` — defect correction
- `docs` — documentation-only change
- `chore` — build, tooling, dependency, or repository maintenance
- `refactor` — internal restructuring without intended behaviour change
- `spike` — time-boxed investigation or experiment
- `hotfix` — urgent correction to a broken accepted build

Examples:

```text
feature/spr-0-project-bootstrap
feature/spr-0-postgres-liquibase
fix/spr-2-negative-inventory
chore/spr-0-maven-quality-gates
docs/spr-0-branch-policy
spike/spr-3-kafka-partitioning
refactor/spr-6-extract-inventory-service
```

Branch-name rules:

- Use the sprint in which the work is planned, not the sprint when it is eventually merged.
- Use lowercase kebab-case for the description.
- Keep the description concise but specific.
- Do not use personal names, dates, or vague names such as `changes`, `work`, or `test`.
- Create the branch from the latest accepted `main` unless a documented dependency requires another base.
- One branch should normally contain one independently reviewable change.
- Delete the branch after merge.

The branch name does not contain the GitHub issue ID. Therefore, traceability to the relevant `FG-###` issue is mandatory in the pull-request title or body. When a branch legitimately addresses multiple issues, list each issue and explain why the changes are inseparable.

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

- Related `FG-###` issue or story
- Sprint number
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
