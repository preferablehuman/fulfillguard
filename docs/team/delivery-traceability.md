# Delivery Traceability Process

## Purpose

This process ensures that planned outcomes, sprint commitments, implementation work, pull requests, verification evidence, and accepted product claims remain connected.

## Traceability hierarchy

```text
Product charter
  -> Deliverables catalogue
    -> Roadmap sequence
      -> Sprint-selected deliverable increment
        -> Functional and non-functional requirements
          -> Story, defect, chore, or spike
            -> Branch and pull request
              -> Verification evidence and review outcome
                -> Sprint acceptance record
                  -> Deliverable status
```

Each layer answers a different question:

- **Product charter:** Why does FulfillGuard exist and what capabilities should it eventually provide?
- **Deliverables catalogue:** What accepted outcomes must the project produce?
- **Roadmap:** In what approximate sequence should outcomes be pursued?
- **Sprint document:** What exact outcomes and requirements are committed now?
- **Issue:** What bounded engineering work will satisfy those requirements?
- **Pull request:** What changed, how was it verified, and which requirements can be accepted?
- **Acceptance record:** What evidence supports the final outcome?

## Identifier model

### Deliverable identifiers

Deliverables use stable domain-oriented identifiers such as:

```text
GOV-003
FND-005
CAP-004
EVT-002
OBS-001
```

Deliverable IDs do not change when sprint scheduling changes.

### Sprint requirement identifiers

Functional requirements use:

```text
FR-S<sprint>-<sequence>
```

Non-functional requirements use:

```text
NFR-S<sprint>-<sequence>
```

Examples:

```text
FR-S1-010
NFR-S1-005
```

Requirement IDs are scoped to one sprint and must be testable or inspectable.

### Work-item identifiers

Implementation work uses GitHub issues such as `FG-003`. Administrative dependencies may use `PRE-###`, and sprint tracking uses `SPR-###` or the repository's established sprint issue convention.

## Planning workflow

1. Review the product charter and deliverables catalogue.
2. Select a complete deliverable or a clearly bounded increment.
3. Confirm dependencies and minimum-capacity fit.
4. Add the selected deliverable to the sprint document.
5. Define exact functional requirements.
6. Define exact non-functional requirements.
7. Create or refine issues that map to those requirements.
8. Record branch names, required evidence, exclusions, and delivery order.
9. Mark work as committed or stretch.

A sprint must not begin with only issue titles. The sprint document must define the observable and quality requirements against which those issues will be reviewed.

## Story readiness

A story is ready only when it identifies:

- Selected deliverable ID
- Sprint requirement IDs
- User or engineering outcome
- Testable acceptance criteria
- Dependencies
- Explicit exclusions
- Required engineering decisions
- Required evidence
- Expected branch scope

One story may satisfy multiple requirements. One requirement may require multiple stories, but the mapping must be explicit.

## Pull-request traceability

Every pull request must identify:

- Sprint
- Deliverable IDs
- Functional requirement IDs
- Non-functional requirement IDs
- Linked issue
- Exact acceptance criteria
- Verification commands and evidence
- Failure and edge-case evidence where relevant
- Known limitations and follow-up issues

A pull request must not check a requirement as satisfied merely because related code exists. The evidence must demonstrate the requirement.

## Review and merge workflow

The product owner/team lead reviews the pull request against the active sprint document and records one outcome:

- Accepted
- Accepted with follow-up
- Partially complete
- Changes required
- Rejected

Before or immediately after merge, the team lead:

1. Records the pull request number in the sprint traceability table.
2. Records the review outcome.
3. Links accepted evidence to requirement IDs.
4. Creates follow-up defects or debt items.
5. Updates requirement status.
6. Updates the deliverables catalogue only when the selected outcome is complete.

Merge does not automatically mean that every linked deliverable is accepted. A deliverable may remain **Partially accepted** when additional requirements remain.

## Carryover and re-scoping

Unfinished work must be handled explicitly:

- **Carryover:** Requirement remains unchanged and is assigned to a later sprint.
- **Re-scope:** Requirement is changed or removed with a documented reason.
- **Partial acceptance:** Some requirements are accepted and others remain open.
- **Follow-up debt:** Increment is safe to accept, but a separate issue records bounded non-blocking work.
- **Rejection:** Evidence does not support the requirement or the implementation violates constraints.

No requirement disappears because a sprint ended.

## Documentation ownership

### Product owner/team lead

- Maintains `docs/product/deliverables.md`.
- Defines sprint functional and non-functional requirements.
- Maintains sprint traceability and acceptance records.
- Updates deliverable status after accepted evidence.
- Creates missing defects, debt, or follow-up stories.

### Engineer

- Proposes technical decisions and trade-offs.
- Implements the bounded story scope.
- Provides accurate requirement mapping in the pull request.
- Supplies reproducible success and failure evidence.
- Reports limitations and incomplete requirements accurately.

## Source-of-truth rules

- Product scope and constraints: `docs/product/project-charter.md`
- Deliverable outcomes and status: `docs/product/deliverables.md`
- Approximate sequencing: `docs/product/roadmap.md`
- Active sprint commitments and requirements: `docs/sprints/sprint-XX.md`
- Work execution and discussion: GitHub issues
- Implementation and evidence: pull requests, code, tests, reports, and ADRs

When sources conflict, the product owner/team lead resolves the conflict through a documentation pull request before dependent implementation is accepted.
