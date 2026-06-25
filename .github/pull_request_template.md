## Traceability

- Sprint: SPR-
- Deliverable ID(s):
- Functional requirement ID(s):
- Non-functional requirement ID(s):
- Issue/story: Closes FG- / #

Every identifier must exist in `docs/product/deliverables.md`, the active sprint document, or the linked issue. Do not claim requirements that this pull request does not verify.

## Purpose

Describe the problem being solved, the selected deliverable increment, and why this change is required now.

## Scope

Describe what is included and explicitly state anything intentionally excluded.

## Design summary

Explain the implementation approach, important trade-offs, dependencies, and architecture decisions.

For material technical decisions include:

```text
Decision:
Context:
Reason:
Alternatives considered:
Trade-offs:
Future impact:
```

## Acceptance criteria

Copy or reference the exact story acceptance criteria satisfied by this pull request.

- [ ] Criterion 1
- [ ] Criterion 2

## Requirement verification

| Requirement ID | Verification method | Evidence / result |
|---|---|---|
| FR- or NFR- | Test, command, inspection, API call, or demonstration | Exact result or evidence location |

## Verification commands

List exact commands, tests, API calls, logs, or demonstrations used to verify the change.

```text
./mvnw clean verify
```

Include relevant success and failure paths. Raw logs should be attached or committed only when the sprint evidence policy requires them.

## Database and compatibility impact

- Schema migration: Yes / No
- API contract change: Yes / No
- Event contract change: Yes / No
- Backward compatibility considerations:
- Reset, migration, or rollback considerations:

## Operational and security impact

Describe configuration, logging, metrics, failure handling, secrets, permissions, process lifecycle, or deployment impact.

## Documentation

- [ ] Setup or operating instructions updated where applicable
- [ ] Architecture or module documentation updated where applicable
- [ ] API or event documentation updated where applicable
- [ ] ADR added or updated where required
- [ ] Known limitations and accepted debt recorded

The product owner/team lead owns the canonical deliverables catalogue and sprint acceptance record. The engineer must provide accurate facts and evidence required for those updates.

## Risks and known limitations

State remaining risks, accepted technical debt, and follow-up work. Link every deferred blocking or non-trivial item to an issue.

## Author checklist

- [ ] I created this branch from the latest accepted `main`.
- [ ] I built the project from a clean state.
- [ ] I ran the required automated tests.
- [ ] I tested important error and edge cases.
- [ ] I verified every requirement ID claimed above.
- [ ] I did not commit secrets, generated build output, or unintended local files.
- [ ] I did not introduce future-sprint technology without an approved requirement.
- [ ] The change is small enough to review effectively.
- [ ] The linked issue and this description accurately represent the implementation.

## Team-lead merge record

Completed by the product owner/team lead during acceptance:

- [ ] Review outcome recorded
- [ ] Follow-up defects or debt created
- [ ] Active sprint traceability table updated with PR and outcome
- [ ] Accepted requirement evidence recorded
- [ ] Deliverables catalogue status updated when the selected outcome is complete
