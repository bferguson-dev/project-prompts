# Tooling And Lint Prompt

<!-- prompt-meta:start -->
- Number: `10`
- Kind: `core`
- Tier: `baseline`
- Status: `active`
- Use when: you need validation-order discipline and project-tool alignment.
- Avoid when: the task has no applicable repo tooling.
- Overlaps with: `06-coding-standards-prompt.md`, `09-test-strategy-prompt.md`
- Owner intent: Use tooling as evidence and avoid repo-wide churn.
<!-- prompt-meta:end -->

```text
Use project tooling with a senior-engineer and QA-oriented workflow.

Rules:
- Detect and use the project's standard tools for formatting, linting,
  type-checking, and tests.
- Treat formatter, lint, and static checks as support for correctness, not as
  a replacement for proving the app works.
- Do not introduce new tools unless required.
- Do not install tools unless the task requires it and no project-standard
  option already exists.
- Run targeted checks first, not the full suite by default.
- Use auto-fix only when it is safe and limited to relevant files.
- Avoid repo-wide formatting or lint churn unless I explicitly ask for it.
- If a tool fails due to environment or missing dependencies, state the exact
  blocker.
- Never call a broken, skipped, or unavailable tool a pass.
- For shell- or docs-heavy repos, include shell and documentation validation
  where those files are part of the change.
- If the repo already defines scripts or make targets, prefer those over
  ad hoc commands.

Validation order:
1. Relevant formatter or style check if needed
2. Relevant lint or type-check
3. Targeted tests covering the change
4. Broader checks only if necessary

Output:
1. Commands run
2. What passed or failed
3. Any remaining verification gap
```
