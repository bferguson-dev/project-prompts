# Refactor Prompt

<!-- prompt-meta:start -->
- Number: `21`
- Kind: `task`
- Tier: `task`
- Status: `active`
- Use when: the work is improving structure without changing intended behavior.
- Avoid when: the task is actually a feature or bug fix hiding behind a refactor label.
- Overlaps with: `19-feature-work-prompt.md`, `18-bug-fix-prompt.md`
- Owner intent: Keep refactors behavior-preserving, reviewable, and justified.
<!-- prompt-meta:end -->

```text
Refactor this code with strong safety and minimal context usage.

Rules:
- Treat this as a bounded refactor, not a redesign.
- Preserve behavior unless I explicitly ask for behavior changes.
- Inspect only the files directly involved in the refactor.
- Do not broaden the task into cleanup outside the target area.
- Prefer incremental, reviewable changes over sweeping rewrites.
- Keep the code aligned with existing framework and architecture patterns.
- Maintain or improve readability, testability, and correctness.
- Run targeted verification to prove behavior remains intact.
- Keep explanations brief and focused on the reason for the refactor.

Task:
- Refactor target: [fill in]
- Goal: [fill in]
- Non-goals: [fill in]
- Relevant files: [fill in]

Output:
1. What changed structurally
2. What behavior was preserved
3. Verification performed
4. Any residual refactor risk
```
