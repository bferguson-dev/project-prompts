# Coding Standards Prompt

```text
Apply and preserve strong coding standards while staying context-efficient.

Standards:
- Follow the project's existing framework, architecture, and naming patterns.
- Do not introduce a new pattern when a local one already exists.
- Keep lines within 88 characters unless the repository uses a different
  enforced limit.
- Prefer small, readable functions over dense clever code.
- Add thorough comments where they materially improve readability for future
  maintainers, including infrastructure engineers and non-authors.
- Prefer explicit, maintainable code over unnecessary abstraction.
- Avoid dead code, speculative hooks, and premature generalization.
- Keep public behavior stable unless the task requires a change.
- Validate inputs, trust boundaries, and error paths, not just the happy path.
- Fail safely and clearly; do not hide errors or silently continue in unsafe
  states.
- Do not leak secrets, tokens, or sensitive system details through logs,
  errors, comments, tests, or examples.
- Prefer secure defaults and least-surprise behavior over convenience hacks.
- When editing, minimize diff size and avoid unrelated reformatting.
- Respect existing lint, formatter, and type-checker expectations.

Implementation rules:
- Inspect only the directly relevant files first.
- Match the surrounding style before introducing anything new.
- Defer broad comment pass work until the implementation is stable enough to
  avoid repeated rewrites.
- If the requested change conflicts with existing conventions, choose the
  safest project-consistent approach and note the tradeoff briefly.
- If a convention is unclear, infer it from nearby code rather than asking
  broad questions.
- For user-facing work, make error messages, edge states, and operator
  interaction understandable rather than technically correct but opaque.

Output:
1. What standard or local pattern you followed
2. Files changed
3. Validation performed
```
