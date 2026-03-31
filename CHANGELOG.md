# Changelog

## 2026-03-31

- Added a baseline prompt-kit rule for longer tasks to send concise bulleted
  progress updates every 60 seconds using `Now:`, `Done:`, `Found:`,
  `Blocker:`, and `Next:` labels, with an explicit `Blocker: none` when
  applicable.
- Replaced remaining `git-secrets` references in the prompt kit with
  `gitleaks` so the prompts, README, and `check.sh` match the repo's actual
  secret-scanning workflow and the session-log rules.

## 2026-03-18

- Added `prompt_catalog.json`, `VERSION`, generated prompt metadata blocks, and
  prompt-doc sync/lint scripts as the source-of-truth system for prompt
  ordering and descriptions.
- Added `PROMPT_POLICY.md` with versioning, lifecycle, deprecation, breaking
  change, and downstream-sync rules.
- Added repo-local `gitleaks` config, a tracked pre-commit hook, pytest-based
  prompt consistency tests, and a GitHub Actions CI workflow.
- Standardized the prompt index and README ordering around numbered filenames.
- Established one fixed legal disclaimer phrase for reuse across repositories.
- Established the prompt kit baseline and QA gate.
- Added adversarial testing, reliability/recovery, and security review prompts.
- Added stronger Git hygiene, secret scanning, Markdown sanity, and staged diff
  heuristics to `check.sh`.
- Removed personal-name references from general prompt/docs while preserving a
  portfolio exception for personal GitHub Pages work.
- Added explicit priority rules that working software matters more than clean
  syntax or green lint alone.
- Added ship-readiness and compatibility/migration prompts.
- Added config syntax checks, strict mode behavior, and a self-test harness for
  `check.sh`.
- Expanded the baseline, overlay, and task prompts to encode assumptions,
  regression thinking, failure-mode review, operability, compatibility, and
  deep QA expectations from the brainstormed improvement lists.
- Strengthened `check.sh` with staged sensitive-path checks, suspicious-artifact
  detection, executable-shebang validation, case-collision checks, and stricter
  staged-file risk detection.
- Clarified that generated docs must be updated through the sync scripts rather
  than manual edits.
