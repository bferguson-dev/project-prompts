# Context-Efficient Bug Fix Prompt

<!-- prompt-meta:start -->
- Number: `18`
- Kind: `task`
- Tier: `task`
- Status: `active`
- Use when: the objective is diagnosing and fixing a bug with minimal scope.
- Avoid when: the task is feature development or broad refactoring.
- Overlaps with: `22-debugging-handoff-prompt.md`, `21-refactor-prompt.md`
- Owner intent: Bias toward narrow, targeted bug fixes and clear verification.
<!-- prompt-meta:end -->

```text
Fix this bug in a context-efficient way.

Working rules:
- Treat this as a scoped debugging and implementation task.
- First inspect only the files I name and any directly referenced imports.
- Do not scan the whole repository unless necessary.
- Prefer the smallest safe fix over broader refactors.
- Keep explanations short and technical.
- Ask only one precise blocking question at a time if required.
- Run only targeted checks/tests needed to confirm the fix.
- Confirm the real root cause before calling the bug fixed.
- Check the nearest regression path and any obvious sibling path that could fail
  for the same reason.
- Do not make unrelated cleanup changes.
- At the end, report only:
  1. root cause
  2. files changed
  3. verification performed
  4. what could still regress

Task:
- Current behavior: [fill in]
- Expected behavior: [fill in]
- Error/output: [fill in exact message]
- Relevant files: [fill in]
- Constraints: [fill in]
```
