# Prompt Kit For Making Shit Good

This repo is a practical prompt kit for running engineering work with better
judgment, tighter QA, and less avoidable mess.

The goal is not to load everything at once. The goal is to load the minimum
set of prompts that gives a coding agent the right operating rules for the
task in front of it.

## Start Here

For baseline repo work, use this core pack:

1. `04-general-session-policy-prompt.md`
2. `05-project-governance-prompt.md`
3. `06-coding-standards-prompt.md`
4. `07-github-workflow-prompt.md`
5. `08-credentials-and-secrets-prompt.md`
6. `09-test-strategy-prompt.md`
7. `10-tooling-and-lint-prompt.md`
8. `11-adversarial-testing-prompt.md`
9. `12-reliability-and-recovery-prompt.md`
10. `13-security-review-prompt.md`
11. `14-ship-readiness-prompt.md`
12. `15-compatibility-and-migration-prompt.md`

Then add one task prompt and only the extra constraint or documentation prompts
that are actually relevant.

If you want a file-based entry point, start with `01-prompt-index.md`.

The leading numbers indicate recommended load order and relative importance:

- `01` to `03`: navigation and session-start helpers
- `04` to `10`: baseline operating rules
- `11` to `15`: risk-focused overlays for stronger review depth
- `16` and above: task- or domain-specific prompts

## Core Files

- `02-session-start-cheatsheet.md`
  Quick chooser for deciding whether to keep the current session or start a
  new one.
- `01-prompt-index.md`
  Fast map of what prompt to load and when.
- `03-master-session-template.md`
  A ready-to-fill session template for more structured starts.
- `04-general-session-policy-prompt.md`
  Baseline operating rules for almost every coding session.
- `05-project-governance-prompt.md`
  Pushes for senior-engineer ownership, QA discipline, and good judgment.
- `06-coding-standards-prompt.md`
  Baseline coding rules for safe, maintainable, understandable changes.
- `07-github-workflow-prompt.md`
  Baseline Git and review workflow rules.
- `08-credentials-and-secrets-prompt.md`
  Baseline secret-handling and least-exposure rules.
- `09-test-strategy-prompt.md`
  Baseline testing-layer expectations.
- `10-tooling-and-lint-prompt.md`
  Baseline validation and tooling expectations.
- `11-adversarial-testing-prompt.md`
  Forces deliberate break-it thinking instead of happy-path-only validation.
- `12-reliability-and-recovery-prompt.md`
  Forces restart, retry, recovery, and partial-failure review.
- `13-security-review-prompt.md`
  Forces trust-boundary and exposure review on risky work.
- `14-ship-readiness-prompt.md`
  Forces an evidence-based go/no-go view instead of assuming green checks mean
  release readiness.
- `15-compatibility-and-migration-prompt.md`
  Forces review of compatibility risk, migration steps, and rollback concerns.

## Task Prompts

Use the task prompt that matches the current objective:

- `16-project-setup-prompt.md`
- `17-project-setup-prompt-short.md`
- `18-bug-fix-prompt.md`
- `19-feature-work-prompt.md`
- `20-code-review-prompt.md`
- `21-refactor-prompt.md`
- `22-debugging-handoff-prompt.md`

Then add only the relevant supporting prompts for standards, workflow,
secrets, environment constraints, docs, or repo style.

For high-risk or shippable work, add:

- `11-adversarial-testing-prompt.md`
- `12-reliability-and-recovery-prompt.md`
- `13-security-review-prompt.md`
- `14-ship-readiness-prompt.md`
- `15-compatibility-and-migration-prompt.md`

The prompt set is intentionally scoped to avoid unnecessary overlap:

- baseline files set default operating rules
- risk overlays deepen review for shippable or exposed work
- task prompts define the immediate work mode
- documentation prompts are split between general docs, README-specific work,
  and portfolio-specific presentation

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
- config syntax validation for JSON, YAML, and TOML
- optional strict-mode behavior that can fail when key doc or shell tools are
  missing

It is designed to be reusable across projects, with environment variables for
test paths and optional commands where a project has non-pytest validation.

## Placeholder Convention

`<PROMPT_HOME>` is a neutral placeholder for the local directory where these
prompt files live. Use it in docs and examples instead of machine-specific
user paths.

## Regression Fixtures

The repo includes `tests/check_sh_selftest.sh` plus fixture files under
`tests/fixtures/check-sh/` so `check.sh` can be regression-tested, not just
syntax-checked.

## Changelog

Policy-level changes to the prompt kit are tracked in `CHANGELOG.md`.

## Intent

This repo is for making agent-driven engineering work sharper, safer, and more
reviewable without turning every task into process theater.
