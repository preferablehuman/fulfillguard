# Team Operating Model

## 1. Roles

### Product owner, team lead, and senior reviewer — ChatGPT

Responsibilities:

- Define product outcomes and feature requirements.
- Maintain the product roadmap and sprint sequence.
- Write detailed user stories, acceptance criteria, and non-functional requirements.
- Identify dependencies, risks, and scope boundaries.
- Review proposed architecture and challenge unsupported decisions.
- Review code, tests, configuration, security, operability, and documentation.
- Create and maintain governing project documents.
- Create defects, technical-debt items, and follow-up stories.
- Conduct sprint review and retrospective discussions.
- Accept, partially accept, reject, or carry forward completed work.
- Point out weak design, avoidable complexity, missing tests, misleading claims, and production risks directly.

The team lead does not approve work merely because it compiles, runs once, or passes a happy-path test.

### Backend engineer and solution architect — Kunal Maheshwari

Responsibilities:

- Propose architecture and implementation approaches.
- Select appropriate open-source libraries and explain trade-offs.
- Implement production-quality code and configuration.
- Write unit, integration, contract, concurrency, and failure tests as required.
- Document significant decisions and known limitations.
- Demonstrate completed functionality.
- Report blockers, defects, and technical debt accurately.
- Respond to code-review findings and defend design choices with evidence.
- Avoid implementing future-sprint infrastructure without an approved requirement.

## 2. Decision ownership

The product owner defines the problem, business constraints, acceptance criteria, and priority.

The engineer owns the initial technical recommendation. For significant choices, the engineer must provide:

- Decision
- Context
- Reason
- Alternatives considered
- Trade-offs
- Future impact

The team lead reviews the recommendation and may accept it, reject it, or require additional evidence.

## 3. Sprint cadence

- Sprint length: one week
- Planned capacity: 8–12 committed engineering hours
- Additional effort: optional stretch capacity
- Normal commitment: one primary vertical increment plus required engineering work

Planning will use sustainable minimum capacity rather than occasional maximum availability.

## 4. Definition of Ready

A backlog item is ready when:

- The business objective is clear.
- Acceptance criteria are testable.
- Non-functional requirements are stated where relevant.
- Dependencies and known risks are identified.
- Major ambiguities are resolved or explicitly delegated as engineering decisions.
- The item is small enough to complete within the sprint.
- Required test evidence is understood.

## 5. Definition of Done

A story is complete only when:

- All acceptance criteria pass.
- Code builds from a clean checkout.
- Required unit and integration tests pass.
- Error paths and important edge cases are tested.
- Database migrations are repeatable where applicable.
- Public API or event contracts are documented.
- Static analysis and agreed quality gates pass.
- Logs contain sufficient diagnostic context without leaking secrets.
- Startup and execution commands are documented.
- Relevant architecture and operational documentation is updated.
- The implementation is demonstrated.
- Known limitations and technical debt are recorded.
- The pull request has received an explicit review outcome.

Compilation alone is not completion.

## 6. Branch and pull-request workflow

### Protected branch intent

`main` represents accepted work. Development must normally occur on short-lived branches created from the latest accepted `main`.

### Required branch naming

Use:

```text
<type>/spr-<sprint-number>-<short-description>
```

Examples:

```text
feature/spr-0-project-bootstrap
feature/spr-0-postgres-liquibase
fix/spr-2-negative-inventory
docs/spr-0-branch-policy
chore/spr-0-maven-quality-gates
spike/spr-3-kafka-partitioning
```

Approved types are `feature`, `fix`, `docs`, `chore`, `refactor`, `spike`, and `hotfix`.

A branch should normally contain one independently reviewable change. Sprint membership in the branch name does not replace issue traceability. Every pull request must link the relevant `FG-###` issue or issues.

### Pull-request expectations

Every product change should include:

- Linked issue or story ID
- Sprint number
- Purpose and scope
- Design summary
- Test evidence
- Screenshots or logs only when useful
- Risks and known limitations
- Documentation changes
- Checklist confirming no secrets were committed

Large, mixed-purpose pull requests may be rejected and split.

### Merge approach

- Normal work is squash-merged into `main` after acceptance.
- The source branch is deleted after merge.
- Long-lived `develop` or sprint branches are not used.
- Sprint boundaries are represented by issues, documents, and release tags rather than integration branches.

## 7. Review outcomes

The team lead may assign one of these outcomes:

- **Accepted:** Meets the Definition of Done.
- **Accepted with follow-up:** Safe to merge, with explicitly recorded non-blocking work.
- **Partially complete:** Some acceptance criteria met; unfinished work remains in the sprint.
- **Changes required:** Blocking correctness, design, testing, security, or operability issues exist.
- **Rejected:** The implementation solves the wrong problem, violates constraints, or introduces unjustified complexity.

## 8. Review severity

- **Blocker:** Must be fixed before merge; data loss, security exposure, broken invariant, unrecoverable workflow, or unusable build.
- **Major:** Must normally be fixed before merge; incorrect behaviour, weak transaction boundary, missing critical test, or serious maintainability issue.
- **Minor:** Improvement that does not invalidate the increment.
- **Suggestion:** Optional alternative or future refinement.

## 9. Sprint review

At the end of each sprint, the engineer must demonstrate the increment from a clean or documented environment. The review covers:

- Business behaviour
- Acceptance criteria
- Automated tests
- Architecture decisions
- Failure handling
- Observability
- Security implications
- Known limitations
- Technical debt

## 10. Retrospective

Each sprint closes with:

- What worked
- What did not work
- What was learned
- Which assumptions changed
- Which process or technical improvement will be applied next sprint

The retrospective is not a status report. It should identify concrete improvements.

## 11. Professional feedback standard

Feedback will be direct, evidence-based, and specific. The review will not inflate quality, experience, or resume claims. A technology may be listed as project experience only after it is used in a meaningful scenario and supported by working code and tests.
