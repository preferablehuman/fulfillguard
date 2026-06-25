# Team Operating Model

## Roles

### Product owner, team lead, and senior reviewer — ChatGPT

Responsibilities:
- Define product outcomes, constraints, priorities, and acceptance criteria.
- Maintain the roadmap, deliverables catalogue, sprint requirements, and acceptance records.
- Create and refine stories, defects, technical-debt items, and follow-up work.
- Review architecture, code, tests, configuration, security, operability, and documentation.
- Record review outcomes, sprint reviews, retrospectives, carryover, and deliverable status.

### Backend engineer and solution architect — Kunal Maheshwari

Responsibilities:
- Propose technical decisions and explain alternatives and trade-offs.
- Implement production-quality code, tests, configuration, and required engineering documentation.
- Map issues and pull requests accurately to deliverable and sprint requirement identifiers.
- Provide reproducible success, failure, and edge-case evidence.
- Report blockers, limitations, incomplete requirements, and technical debt accurately.
- Avoid future-sprint infrastructure without an approved requirement.

## Decision ownership

The product owner defines the problem, business constraints, priority, and acceptance criteria. The engineer owns the initial technical recommendation.

For material decisions, provide:

```text
Decision:
Context:
Reason:
Alternatives considered:
Trade-offs:
Future impact:
```

## Sprint cadence

- Sprint length: one week
- Planned commitment: 8–12 engineering hours
- Additional effort: optional stretch capacity
- Normal commitment: one primary increment plus necessary engineering work

## Definition of Ready

A work item is ready when:
- Its deliverable ID is identified.
- Its functional and non-functional sprint requirement IDs are identified.
- The outcome and testable acceptance criteria are clear.
- Dependencies, risks, scope exclusions, and required evidence are known.
- The item is small enough for the sprint.

## Definition of Done

A story is complete only when:
- All linked requirements and acceptance criteria pass.
- The project builds from a clean checkout.
- Required automated tests and important failure paths pass.
- Relevant documentation is current.
- Known limitations and debt are issue-backed.
- The pull request receives an explicit review outcome.
- The active sprint document records the pull request, evidence, and acceptance state.

Compilation alone is not completion.

## Branch and pull-request workflow

`main` represents accepted work. Development normally occurs on a short-lived branch from the latest accepted `main`.

```text
<type>/spr-<sprint-number>-<short-description>
```

Approved types are `feature`, `fix`, `docs`, `chore`, `refactor`, `spike`, and `hotfix`.

Every pull request must identify:
- Sprint
- Deliverable IDs
- Functional and non-functional requirement IDs
- Linked issue
- Purpose and scope
- Design decisions
- Requirement-level evidence
- Risks and limitations

Normal work is squash-merged after acceptance. Long-lived integration branches are not used.

## Review outcomes

- Accepted
- Accepted with follow-up
- Partially complete
- Changes required
- Rejected

## Delivery traceability

The governing process is defined in [`delivery-traceability.md`](delivery-traceability.md).

```text
Deliverable -> Sprint requirement -> Issue -> Pull request -> Evidence -> Acceptance
```

Before or immediately after an accepted merge, the team lead:
1. Records the pull request and review outcome in the active sprint document.
2. Links evidence to the affected requirement IDs.
3. Creates follow-up issues for accepted debt or incomplete requirements.
4. Updates requirement status.
5. Updates the deliverables catalogue only when the selected outcome is complete.

Requirements are accepted, carried forward, re-scoped with a reason, or rejected explicitly.

## Sprint review and retrospective

Sprint review covers selected deliverables, requirements, demonstrated behaviour, tests, architecture decisions, failure handling, security, operability, limitations, and debt.

Retrospective records what worked, what did not, what was learned, changed assumptions, and one concrete improvement.

## Professional feedback standard

Feedback is direct, evidence-based, and specific. Technology claims require meaningful implementation, tests, and evidence.
