# Master Session Template

```text
Read only the minimum relevant prompt files for this task from
`<PROMPT_HOME>\prompt-index.md`.

Required baseline:
- `<PROMPT_HOME>\general-session-policy-prompt.md`
- `<PROMPT_HOME>\project-governance-prompt.md`
- `<PROMPT_HOME>\coding-standards-prompt.md`
- `<PROMPT_HOME>\github-workflow-prompt.md`
- `<PROMPT_HOME>\credentials-and-secrets-prompt.md`
- `<PROMPT_HOME>\test-strategy-prompt.md`
- `<PROMPT_HOME>\tooling-and-lint-prompt.md`

Use these additional prompts when the task is risky, externally exposed, or
intended to be shippable:
- `<PROMPT_HOME>\adversarial-testing-prompt.md`
- `<PROMPT_HOME>\reliability-and-recovery-prompt.md`
- `<PROMPT_HOME>\security-review-prompt.md`
- `<PROMPT_HOME>\ship-readiness-prompt.md`
- `<PROMPT_HOME>\compatibility-and-migration-prompt.md`

Then read only the task-specific and constraint-specific prompt files that are
actually relevant. Do not load every prompt file by default.

Working rules:
- Treat this as a scoped engineering task with QA-level output.
- Inspect only the directly relevant files first.
- Do not scan the whole repository unless necessary.
- Follow the project's existing framework, architecture, and tooling patterns.
- Keep lines within 88 characters unless the repo clearly uses a different
  standard.
- Prefer the smallest safe change that satisfies the goal.
- Defer broad code comments and documentation passes until late in the task,
  once implementation is stable.
- When comments are added, make them thorough enough that future maintainers,
  including infrastructure engineers, can understand the code.
- When documentation is added, write it like production documentation, not a
  portfolio.
- Keep explanations concise and technical.
- Ask only one precise blocking question at a time.
- Use safe, non-destructive Git practices.
- Do not treat broken or skipped checks as passes.
- Run targeted validation first and broader checks only when needed.

At the end, report only:
1. outcome or root cause
2. files changed
3. commands and validation performed
4. how you tried to break it
5. remaining risks, assumptions, or needed input

Task:
- Goal: [fill in]
- Relevant files or directories: [fill in]
- Relevant prompt files to read: [fill in or say "choose from index"]
- Constraints: [fill in]
- Exact errors or expected behavior: [fill in if applicable]
```
