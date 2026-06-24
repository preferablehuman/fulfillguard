# Branching Strategy

## Permanent branch

`main` is the only permanent branch. It contains accepted, reviewed, and working code.

## Branch format

All working branches use:

```text
<type>/spr-<sprint-number>-<short-description>
```

Examples:

```text
feature/spr-0-project-bootstrap
feature/spr-1-inventory-reservation
fix/spr-2-negative-inventory
docs/spr-0-branch-policy
chore/spr-0-maven-quality-gates
refactor/spr-6-inventory-service-extraction
spike/spr-3-kafka-partitioning
```

## Approved types

- `feature`
- `fix`
- `docs`
- `chore`
- `refactor`
- `spike`
- `hotfix`

## Rules

1. Create branches from the latest accepted `main`.
2. Keep branches short-lived.
3. One branch should normally represent one independently reviewable change.
4. Link every pull request to the applicable `FG-###` issue because the issue ID is not included in the branch name.
5. Use squash merge for normal work.
6. Delete merged branches.
7. Do not create long-lived `develop` or sprint integration branches.
8. Use sprint documents, issues, and release tags to represent sprint and release boundaries.
9. A branch keeps the sprint number in which the work was planned even when completion carries into a later sprint; carryover is recorded in the issue and sprint review.

## Pull-request naming

Recommended pull-request title:

```text
FG-001: Bootstrap the Java 21 Spring Boot application
```

This preserves issue traceability independently of the branch name.
