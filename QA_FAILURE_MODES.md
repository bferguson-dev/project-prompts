# QA Failure Modes Reference

This file consolidates the failure modes and review targets that the prompt kit
is expected to consider across implementation, review, testing, and ship
readiness work.

It is not a numbered prompt. It is a reference artifact for keeping the prompt
kit honest about the classes of bugs and blind spots it is supposed to catch.

## Correctness And Data Integrity

- Silent data truncation.
- Off-by-one boundaries.
- Null vs empty-string confusion.
- `None` or `null` leaking into downstream logic.
- Incorrect defaults masking configuration mistakes.
- Unsafe fallback paths hiding failures.
- Partial writes without rollback.
- Duplicate side effects on retry.
- Broken idempotency.
- Race conditions on shared state or files.
- Time-of-check/time-of-use bugs.
- Stale or unauthorized cache reads.
- Broken cache invalidation.
- Sorting instability or nondeterministic output.
- Pagination, truncation, and large-result handling bugs.
- Serialization and deserialization mismatches.
- Schema drift and stored-data version mismatches.
- Migration scripts that are unsafe to re-run or unsafe to roll back.
- Orphaned resources after failure.
- Duplicate submission or replay handling failures.
- Data-loss risk in destructive paths.

## Boundary, Input, And Interface Risk

- Empty, null, malformed, duplicate, reordered, or oversized input.
- Locale-dependent parsing failures.
- Unicode normalization mismatches.
- Timezone, DST, and clock-skew mistakes.
- Hidden assumptions about ordering or deterministic iteration.
- Invalid flags, bad config, and missing-file handling.
- Hidden reliance on current working directory.
- Hidden reliance on shell-specific behavior.
- Hidden reliance on local usernames, home paths, or hostnames.
- Case-sensitivity bugs across filesystems.
- Path separator differences between Windows and Unix.
- CRLF vs LF line-ending bugs.
- Feature-flag split behavior and config-precedence confusion.
- API, CLI, config, env-var, file-format, and workflow compatibility breaks.
- Upgrade, downgrade, and mixed-version behavior gaps.

## Reliability, Recovery, And Operations

- Partial failure handling that leaves inconsistent state.
- Retry logic that amplifies damage or duplicates work.
- Startup, shutdown, restart, and resume failures.
- Broken cleanup of temp files, locks, or partial outputs.
- Dependency slowness, absence, or partial responses.
- Queue backpressure and failure-recovery gaps.
- Lock contention and deadlock risk.
- Health checks that report liveness but not readiness.
- Broken graceful termination or signal handling.
- Config precedence mistakes.
- Unsafe feature-flag defaults.
- Split-brain behavior across nodes, workers, or clients.
- Resource exhaustion in memory, CPU, disk, network, or startup cost.
- Missing rollback or recovery guidance.
- Missing observability for new failure modes.

## Security And Trust Boundaries

- Command injection.
- SQL injection.
- Regex denial-of-service.
- Template injection.
- XSS through rendered HTML or Markdown.
- Open redirects.
- CSRF gaps.
- Missing authorization checks.
- Privilege escalation through role or permission mismatch.
- Session lifecycle, expiry, or invalidation failures.
- Secret leakage in logs, errors, telemetry, tests, or fixtures.
- Excessive file permissions on created artifacts or temp files.
- World-readable sensitive paths.
- Unsafe archive extraction or path traversal.
- Symlink handling mistakes.
- Insecure defaults and unsafe fallback behavior.
- Missing least-privilege thinking.
- Secret rotation and revocation assumptions.
- Dependency, GitHub Action, or supply-chain trust gaps.

## Performance, Scale, And Pressure

- Performance regressions under realistic load.
- Instability under concurrency or repeated requests.
- Queue buildup and backpressure failure.
- Cache stampedes or stale-cache behavior.
- Resource leaks under sustained use.
- Slow startup or shutdown behavior that breaks operations.
- Rate-limit and abuse resistance gaps.
- Flaky behavior caused by randomness, timing, or shared state.

## Usability, Accessibility, And Operator Clarity

- Empty-state, loading-state, and partial-state failures.
- Error messages that are technically correct but operationally useless.
- Missing accessibility or usability validation.
- Client/server validation mismatch.
- Confusing or unsafe operator workflows.
- Documentation that omits assumptions, failure modes, or recovery steps.
- Docs or examples that drift away from actual commands and filenames.

## Review And Process Blind Spots

- Tests that pass but assert the wrong thing.
- Over-mocked tests that miss real integration bugs.
- Missing negative-path, denial-path, or regression tests.
- Empty test suites treated as success.
- Broken tools or skipped checks treated as pass.
- Local-only success being treated like CI or ship success.
- CI green because it skipped the real path.
- Generated files drifting from their source.
- Lockfile changes without dependency review.
- Broad `.gitignore` rules hiding important files.
- Local note files, screenshots, archives, database dumps, or exports entering
  commits accidentally.
- Executable bits on the wrong files.
- Scripts missing shebangs or syntax validation.
- Merge conflict markers, debug prints, or TODO/HACK markers landing in commits.
- Vague commit messages that do not explain intent.
- Wrong branch or remote target on push.
- Broken secret scans reported as green.
- Prompt drift that creates conflicting instructions.

## How This Repo Uses The List

- The numbered prompts encode the human review and engineering rules.
- `check.sh` automates the parts that can be checked reliably.
- `PROMPT_POLICY.md` defines where new doctrine should live.
- `CHANGELOG.md` records prompt-kit policy changes over time.

Use this reference as a coverage checklist, not as a substitute for judgment.
