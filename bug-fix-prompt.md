# Context-Efficient Bug Fix Prompt

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
- Do not make unrelated cleanup changes.
- At the end, report only:
  1. root cause
  2. files changed
  3. verification performed

Task:
- Current behavior: [fill in]
- Expected behavior: [fill in]
- Error/output: [fill in exact message]
- Relevant files: [fill in]
- Constraints: [fill in]
```
