# Context-Efficient Feature Work Prompt

<!-- prompt-meta:start -->
- Number: `19`
- Kind: `task`
- Tier: `task`
- Status: `active`
- Use when: the objective is adding or extending product behavior.
- Avoid when: the work is primarily debugging or review-only.
- Overlaps with: `21-refactor-prompt.md`, `20-code-review-prompt.md`
- Owner intent: Keep feature work scoped, validated, and aligned with local patterns.
<!-- prompt-meta:end -->

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
- State the key assumptions, non-goals, and likely regression surfaces.
- Do not add unrelated refactors, cleanup, or enhancements.
- At the end, report only:
  1. what you implemented
  2. files changed
  3. verification performed
  4. how you tried to break it
  5. what could still regress

Task:
- Feature: [fill in]
- Expected behavior: [fill in]
- Relevant files: [fill in]
- Constraints: [fill in]
```
