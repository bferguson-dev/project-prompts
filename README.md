*[!] This project is provided as-is, without warranties or guarantees of any kind, and has not been validated in a production environment unless explicitly stated otherwise. You are solely responsible for evaluating, testing, securing, and operating it safely in your environment and for verifying compliance with any legal, regulatory, or contractual requirements. By using this project, you accept all risk, and the authors and contributors assume no liability for any loss, damage, outage, misuse, or other consequences arising from its use. [!]*

# Prompt Kit For Making Shit Good

This repo is a practical prompt kit for running engineering work with better
judgment, tighter QA, and less avoidable mess.

Current prompt-kit version: `2026.04.06.1`.

The goal is not to load everything at once. The goal is to load the minimum
set of prompts that gives a coding agent the right operating rules for the
task in front of it.

The full legal disclaimer is in `DISCLAIMER.md`.

## Non-Goals

- This repo is not a general-purpose coding standard for every team.
- This repo is not a legal, compliance, or security certification.
- This repo does not replace project-specific validation in downstream repos.

## Requirements

- Python 3 for prompt sync and lint scripts.
- Bash for `check.sh`.
- `gitleaks` for staged and optional history-aware secret scanning.
- Optional Markdown, shell, and dependency-audit tools when strict local checks
  are enabled.

## Assumptions

- Downstream repos will pin or record the prompt-kit version or commit they
  used.
- Generated docs stay synchronized through `scripts/sync_prompt_docs.py`.
- The canonical legal disclaimer in `prompt_catalog.json` is reused verbatim
  unless a repo-specific exception is explicitly approved.

## Setup

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install -U pip pytest
git config core.hooksPath .githooks
```

## Usage

1. Select the smallest prompt bundle that matches the task.
2. Read `01-prompt-index.md` when you need a file-based entry point.
3. Use `repo-compliance-prompt.md` when applying the prompt kit to another
   repository.
4. Run `./check.sh` before committing prompt-kit changes.

## Expected Output

- Updated generated docs after `python scripts/sync_prompt_docs.py`.
- Prompt lint results from `python scripts/lint_prompts.py`.
- Local quality-gate output from `./check.sh`.

## Start Here

For baseline repo work, use this core pack:

1. `04-general-session-policy-prompt.md`
2. `05-project-governance-prompt.md`
3. `06-coding-standards-prompt.md`
4. `07-github-workflow-prompt.md`
5. `08-credentials-and-secrets-prompt.md`
6. `09-test-strategy-prompt.md`
7. `10-tooling-and-lint-prompt.md`
8. Add `11` to `15` when risk, compatibility, or release readiness matter
9. Add one task prompt from `16` to `22`

If you want a file-based entry point, start with `01-prompt-index.md`.

The leading numbers indicate recommended load order and relative importance:

- `01` to `03`: navigation and session-start helpers
- `04` to `10`: baseline operating rules
- `11` to `15`: risk-focused overlays for stronger review depth
- `16` to `22`: task-specific prompts
- `23` to `24`: process and environment constraints
- `25` to `29`: documentation and presentation prompts

## Compatibility Table

| Range | Role | Default |
|---|---|---|
| `01-03` | Navigation helpers | Optional |
| `04-10` | Baseline operating rules | Default for most repo work |
| `11-15` | Risk overlays | Add for higher-risk or shippable work |
| `16-22` | Task prompts | Choose one per objective |
| `23-24` | Constraints | Add only when directly relevant |
| `25-29` | Documentation and presentation | Add only when docs or presentation are in scope |

## Core Files

- `01-prompt-index.md`
  Use when you need the fastest file-based entry point into the prompt kit.
- `02-session-start-cheatsheet.md`
  Use when you need a quick decision aid for choosing a task prompt or deciding whether to start a new session.
- `03-master-session-template.md`
  Use when you want a structured handoff or repeatable session start template.
- `04-general-session-policy-prompt.md`
  Use when you need the default engineering behavior for most coding sessions.
- `05-project-governance-prompt.md`
  Use when you want stronger senior-engineer ownership and release-safety behavior.
- `06-coding-standards-prompt.md`
  Use when you need local-pattern-preserving implementation standards.
- `07-github-workflow-prompt.md`
  Use when you want default Git, PR, and review workflow expectations.
- `08-credentials-and-secrets-prompt.md`
  Use when the work touches secrets, credentials, tokens, keys, or sensitive configs.
- `09-test-strategy-prompt.md`
  Use when you need explicit test-scope reasoning and layered validation choices.
- `10-tooling-and-lint-prompt.md`
  Use when you need validation-order discipline and project-tool alignment.
- `11-adversarial-testing-prompt.md`
  Use when you want break-it thinking for risky or exposed changes.
- `12-reliability-and-recovery-prompt.md`
  Use when restart safety, retries, rollback, or partial failure matter.
- `13-security-review-prompt.md`
  Use when trust boundaries, auth, secrets, or exposure risk are central.
- `14-ship-readiness-prompt.md`
  Use when you need an evidence-based go/no-go judgment.
- `15-compatibility-and-migration-prompt.md`
  Use when interfaces, configs, schemas, or workflows might break consumers.

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

## Prompt Bundles

- Small bug fix: `04`, `06`, `09`, `10`, `18`
- Security-sensitive feature: `04`, `05`, `08`, `09`, `10`, `11`, `13`, `19`
- Ship-readiness pass: `04`, `05`, `09`, `10`, `12`, `14`, `15`, `20`
- Documentation refresh: `04`, `25`, `26`, `27`

## Anti-Patterns

- Loading every prompt by default instead of choosing a scoped bundle
- Using multiple task prompts for one objective instead of picking one work mode
- Treating overlays as baseline requirements for trivial changes
- Rewriting the canonical legal disclaimer instead of reusing it verbatim
- Renaming numbered files without updating the catalog, index, README, and changelog together

## Update Safely

1. Edit `prompt_catalog.json` first.
2. Run `python scripts/sync_prompt_docs.py`.
3. Run `python scripts/lint_prompts.py`.
4. Run `./check.sh`.
5. Review `git diff --cached`.
6. Record policy-level changes in `CHANGELOG.md`.

## Prompt Lifecycle

- `active`: current and recommended
- `deprecated`: still present for compatibility, but not preferred for new usage
- `archived`: retained for history only

See `PROMPT_POLICY.md` for numbering, deprecation, breaking-change, and
downstream-sync rules.

## Secret Scanning

This repo includes `.gitleaks.toml` and `.githooks/pre-commit` so staged
changes can be scanned consistently.

One-time setup:

```bash
git config core.hooksPath .githooks
```

`check.sh` also uses `gitleaks` for staged and optional history-aware secret
scanning. This repo does not rely on `git-secrets`.

## Workflow Defaults

This repo assumes:

- working software comes first
- minimal context loading
- small safe changes
- longer tasks include concise bulleted progress updates every 60 seconds
- progress updates use short, concrete `Now:`, `Done:`, `Found:`, `Blocker:`, and `Next:` lines when relevant
- progress updates explicitly say `Blocker: none` when there is no blocker
- QA-first execution
- non-destructive Git usage
- no secrets committed, ever
- no false passes on broken or skipped validation
- usability and operator clarity matter, not just raw correctness
- assumptions, regressions, and what was not verified must be surfaced
- rollback, recovery, compatibility, and observability matter for real releases

## Downstream Consumer Checklist

1. Record the prompt-kit version or commit you are using.
2. Reuse the canonical disclaimer text from `27-legal-disclaimer-prompt.md` verbatim.
3. Keep numbered filenames intact when referencing prompt files.
4. Treat local prompt changes as explicit deviations.
5. Re-run downstream validation after sync.

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
- prompt-catalog generation and lint checks
- test-layer reporting for unit, integration, system, acceptance, regression,
  performance/load, usability, and security concerns
- Git hygiene checks around staged diffs, secret exposure, and file modes
- staged-diff heuristics for merge markers, debug prints, task-note markers,
  suspicious local paths, secret-like additions, and accidental artifacts
- config syntax validation for JSON, YAML, and TOML
- case-collision detection for case-insensitive filesystem safety
- executable-file sanity checks for shebangs and suspicious executable files
- optional strict-mode behavior that can fail when key doc or shell tools are
  missing

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

## Failure-Mode Reference

Use `QA_FAILURE_MODES.md` as the consolidated reference for the bug
classes, failure modes, and review blind spots this kit is meant to
cover.

## Intent

This repo is for making agent-driven engineering work sharper, safer, and more
reviewable without turning every task into process theater.

## Troubleshooting

- If generated docs drift, update `prompt_catalog.json` first and rerun
  `python scripts/sync_prompt_docs.py`.
- If `gitleaks` is unavailable, install it before treating a commit as ready.
- If optional strict checks fail because tools are missing, either install the
  missing tools or report the validation gap explicitly.

## Recovery And Rollback

- Revert prompt body changes with normal Git review if downstream behavior
  would change unintentionally.
- Treat renumbering, renaming, or changing the canonical legal disclaimer as a
  breaking change and record it in `CHANGELOG.md`.

## Known Limitations

- The prompt kit improves review discipline but cannot prove downstream code is
  correct.
- Some checks depend on optional local tools and may be warnings outside strict
  mode.
- Downstream repositories still need their own tests, threat review, and
  environment-specific validation.
