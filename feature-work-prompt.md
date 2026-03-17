# Context-Efficient Feature Work Prompt

```text
Implement this feature in a context-efficient way.

Working rules:
- Treat this as a scoped implementation task, not an open-ended redesign.
- First inspect only the files I name and any directly related files.
- Do not scan the whole repository unless necessary.
- Prefer the smallest safe implementation that satisfies the requirement.
- Preserve existing patterns unless I ask for a redesign.
- Keep explanations short and technical.
- Ask only one precise blocking question at a time if required.
- Run only targeted validation for the feature.
- Do not add unrelated refactors, cleanup, or enhancements.
- At the end, report only:
  1. what you implemented
  2. files changed
  3. verification performed

Task:
- Feature: [fill in]
- Expected behavior: [fill in]
- Relevant files: [fill in]
- Constraints: [fill in]
```
