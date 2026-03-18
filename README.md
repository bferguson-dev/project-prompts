# Prompt Kit For Making Shit Good

This repo is a practical prompt kit for running engineering work with better
judgment, tighter QA, and less avoidable mess.

The goal is not to load everything at once. The goal is to load the minimum
set of prompts that gives a coding agent the right operating rules for the
task in front of it.

## Start Here

For baseline repo work, use this core pack:

1. `general-session-policy-prompt.md`
2. `project-governance-prompt.md`
3. `coding-standards-prompt.md`
4. `github-workflow-prompt.md`
5. `credentials-and-secrets-prompt.md`
6. `test-strategy-prompt.md`
7. `tooling-and-lint-prompt.md`
8. `adversarial-testing-prompt.md`
9. `reliability-and-recovery-prompt.md`
10. `security-review-prompt.md`

Then add one task prompt and only the extra constraint or documentation prompts
that are actually relevant.

If you want a file-based entry point, start with `prompt-index.md`.

## Core Files

- `general-session-policy-prompt.md`
  Baseline operating rules for almost every coding session.
- `project-governance-prompt.md`
  Pushes for senior-engineer ownership, QA discipline, and good judgment.
- `coding-standards-prompt.md`
  Baseline coding rules for safe, maintainable, understandable changes.
- `github-workflow-prompt.md`
  Baseline Git and review workflow rules.
- `credentials-and-secrets-prompt.md`
  Baseline secret-handling and least-exposure rules.
- `test-strategy-prompt.md`
  Baseline testing-layer expectations.
- `tooling-and-lint-prompt.md`
  Baseline validation and tooling expectations.
- `adversarial-testing-prompt.md`
  Forces deliberate break-it thinking instead of happy-path-only validation.
- `reliability-and-recovery-prompt.md`
  Forces restart, retry, recovery, and partial-failure review.
- `security-review-prompt.md`
  Forces trust-boundary and exposure review on risky work.
- `prompt-index.md`
  Fast map of what prompt to load and when.
- `master-session-template.md`
  A ready-to-fill session template for more structured starts.

## Task Prompts

Use the task prompt that matches the current objective:

- `bug-fix-prompt.md`
- `feature-work-prompt.md`
- `code-review-prompt.md`
- `refactor-prompt.md`
- `project-setup-prompt.md`
- `project-setup-prompt-short.md`
- `debugging-handoff-prompt.md`
- `test-strategy-prompt.md`

Then add only the relevant supporting prompts for standards, workflow,
secrets, environment constraints, docs, or repo style.

For high-risk or shippable work, add:

- `adversarial-testing-prompt.md`
- `reliability-and-recovery-prompt.md`
- `security-review-prompt.md`

## Workflow Defaults

This repo assumes:

- working software comes first
- minimal context loading
- small safe changes
- QA-first execution
- non-destructive Git usage
- no secrets committed, ever
- no false passes on broken or skipped validation
- usability and operator clarity matter, not just raw correctness

Before commit, the expected workflow is:

1. Review `git diff --cached`
2. Run `git secrets` against pending changes
3. Check for accidental file-mode or executable-bit changes
4. Run targeted validation
5. Commit
6. Push

If GPG signing blocks a commit, the workflow is to wait for the user's approval or
passphrase flow before falling back to unsigned commit behavior.

## `check.sh`

`check.sh` is the repo's all-around QA gate. It is meant to be a practical
single entry point, not a narrow lint wrapper.

Its purpose is to support shipping code that actually works, not to create a
false sense of quality from clean syntax or green lint alone.

It currently covers:

- staged Git hygiene and patch quality checks
- formatting and linting
- static security scanning
- secret scanning
- dependency auditing
- shell-script linting when available
- Markdown style and relative-link checks when available
- test-layer reporting for unit, integration, system, acceptance, regression,
  performance/load, usability, and security concerns
- Git hygiene checks around staged diffs, secret exposure, and file modes
- staged-diff heuristics for merge markers, debug prints, TODO-style markers,
  suspicious local paths, and accidental artifacts

It is designed to be reusable across projects, with environment variables for
test paths and optional commands where a project has non-pytest validation.

## Intent

This repo is for making agent-driven engineering work sharper, safer, and more
reviewable without turning every task into process theater.
