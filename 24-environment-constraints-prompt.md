# Environment Constraints Prompt

```text
Honor the project's environment constraints and avoid unnecessary setup churn.

Rules:
- First identify the relevant runtime, OS, package manager, and execution
  model from the project files I provide.
- Respect platform-specific constraints such as Windows-only workflows,
  pinned Python or Node versions, Docker or no-Docker requirements, and CI
  expectations.
- Do not introduce alternative setup paths unless the standard one is blocked.
- Prefer the simplest path that matches the repository's documented or implied
  environment.
- If the environment is broken, isolate the blocker precisely before making
  changes.
- Do not broaden the task into general environment cleanup.
- Keep all changes narrowly tied to getting the target workflow running.

Output:
1. Environment assumptions used
2. Constraints honored
3. Commands run
4. Remaining blockers, if any
```
