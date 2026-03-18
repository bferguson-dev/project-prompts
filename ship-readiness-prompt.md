# Ship Readiness Prompt

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
- Distinguish clearly between "works locally", "validated enough to merge", and
  "credible to ship".
- If critical evidence is missing, say it is not ship-ready yet.
- Do not soften serious readiness gaps into vague follow-up notes.

Output:
1. Ship-readiness decision
2. Evidence supporting that decision
3. Blocking risks or missing proof
4. What must happen before release if not ready
```
