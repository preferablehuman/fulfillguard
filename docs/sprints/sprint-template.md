# Sprint X — Sprint Name

## Sprint control

- **Sprint:** X
- **Duration:** One week
- **Committed capacity:** 8–12 engineering hours
- **Status:** Planned / Active / Completed / Completed with partial scope
- **Tracking issue:** #
- **Start date:** YYYY-MM-DD
- **Review date:** YYYY-MM-DD

## Sprint goal

State the single outcome this sprint must produce.

## Selected deliverables

| Deliverable ID | Selected increment | Commitment | Current status |
|---|---|---|---|
| FND-000 | Precisely bounded outcome selected from the catalogue | Committed / Stretch | Planned |

## Functional requirements

Functional requirements describe observable behaviour or a concrete system capability delivered during this sprint.

| ID | Requirement | Deliverable | Verification method | Status |
|---|---|---|---|---|
| FR-SX-001 | Testable requirement | FND-000 | Test, command, API call, or demonstration | Planned |

## Non-functional requirements

Non-functional requirements define quality, security, operability, maintainability, performance, reproducibility, or process constraints.

| ID | Requirement | Deliverable | Verification method | Status |
|---|---|---|---|---|
| NFR-SX-001 | Testable quality constraint | FND-000 | Test, inspection, report, or demonstration | Planned |

## Story and traceability map

| Story / issue | Deliverable | Requirement IDs | Branch | Pull request | Review outcome | Merge status |
|---|---|---|---|---|---|---|
| FG-000 | FND-000 | FR-SX-001, NFR-SX-001 | `type/spr-x-description` | — | Not reviewed | Not merged |

## Dependencies

List technical, product, administrative, and sequencing dependencies.

## Required engineering decisions

List decisions the engineer must propose and defend. For each material decision use:

```text
Decision:
Context:
Reason:
Alternatives considered:
Trade-offs:
Future impact:
```

## Explicit scope exclusions

List capabilities and technologies that are not permitted in this sprint.

## Required evidence

Define evidence required across the complete sprint, including:

- Clean build output
- Automated test results
- API or command demonstrations
- Failure-path evidence
- Database or event state where applicable
- Reports, logs, metrics, or traces where applicable
- Updated documentation

## Acceptance tracking

| Requirement ID | Evidence reference | Accepted by | Acceptance date | Outcome / notes |
|---|---|---|---|---|
| FR-SX-001 | PR, test report, command output, or document | Team lead | — | Pending |

## Definition of sprint completion

The sprint is complete only when:

- Every committed requirement is Accepted, explicitly carried forward, or removed through documented re-scoping.
- Each accepted requirement is supported by merged evidence.
- Deliverable statuses are updated in `docs/product/deliverables.md`.
- Follow-up defects and technical debt have issue IDs.
- Sprint review and retrospective are recorded.

## Sprint review

Record the demonstrated increment, accepted work, rejected or partial work, and evidence.

## Retrospective

Record:

- What worked
- What did not work
- What was learned
- Which assumptions changed
- Which process or technical improvement will be applied next sprint
