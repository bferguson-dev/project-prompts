# Ship Readiness Prompt

<!-- prompt-meta:start -->
- Number: `14`
- Kind: `risk-overlay`
- Tier: `overlay`
- Status: `active`
- Use when: you need an evidence-based go/no-go judgment.
- Avoid when: the work is exploratory and not near a ship decision.
- Overlaps with: `05-project-governance-prompt.md`, `12-reliability-and-recovery-prompt.md`
- Owner intent: Prevent green-check theater by forcing explicit readiness criteria.
<!-- prompt-meta:end -->

```text
Judge whether the change is actually ready to ship, not just whether it is
well-written.

Rules:
- Treat ship readiness as a go/no-go decision with evidence.
- Confirm the software works for the intended use, not just that checks are
  green.
- Review release risk, rollback path, observability, operator clarity, and
  known failure modes before calling work ready.
- Check whether docs, config expectations, and migration steps match the shipped
  behavior.
- Check whether monitoring, logging, health signals, and incident triage would
  make a real failure diagnosable after release.
- Check whether compatibility, migration, performance, security, and usability
  evidence are strong enough for the actual release risk.
- Distinguish between "validated enough to continue development" and "validated
  enough that a hostile or stressed real environment is unlikely to expose an
  obvious miss."
- Distinguish clearly between "works locally", "validated enough to merge", and
  "credible to ship".
- If critical evidence is missing, say it is not ship-ready yet.
- Do not soften serious readiness gaps into vague follow-up notes.

Output:
1. Ship-readiness decision
2. Evidence supporting that decision
3. Blocking risks or missing proof
4. Rollback, observability, and operator-readiness status
5. What must happen before release if not ready
```
