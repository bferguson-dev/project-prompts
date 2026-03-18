# Reliability And Recovery Prompt

<!-- prompt-meta:start -->
- Number: `12`
- Kind: `risk-overlay`
- Tier: `overlay`
- Status: `active`
- Use when: restart safety, retries, rollback, or partial failure matter.
- Avoid when: the task has no meaningful failure-recovery dimension.
- Overlaps with: `14-ship-readiness-prompt.md`, `15-compatibility-and-migration-prompt.md`
- Owner intent: Surface operational resilience concerns before shipping.
<!-- prompt-meta:end -->

```text
Review and validate the change for reliability, restart safety, and recovery.

Rules:
- Check for partial-write, duplicate-write, and interrupted-execution risks.
- Validate retry behavior, idempotency, cleanup paths, and rollback or
  recovery expectations where relevant.
- Consider startup, shutdown, restart, and resume behavior for services,
  scripts, jobs, or workflows.
- Check how the system behaves when dependencies are slow, missing, or return
  partial failures.
- Look for orphaned state, stale locks, temp files, broken caches, or
  inconsistent data after failure.
- Prefer explicit recovery behavior over silent best-effort continuation.
- If safe rollback is not possible, state that clearly as a release risk.
- Do not claim reliability that was not actually exercised or reasoned about.

Output:
1. Reliability and recovery risks reviewed
2. What was validated
3. Failure or restart concerns found
4. Remaining recovery gaps
```
