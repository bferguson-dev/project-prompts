# Context-Efficient Project Setup Prompt

```text
Set up this project in a context-efficient way.

Working rules:
- Treat this as a scoped engineering task, not an open-ended exploration.
- First inspect only the files and folders directly relevant to setup.
- Do not scan the whole repository unless necessary.
- Prefer the smallest safe set of changes that gets the project working.
- Keep explanations short and technical.
- Do not give long tutorials unless I ask.
- If information is missing, ask only one precise question at a time.
- Run only targeted commands/checks needed for setup and validation.
- Do not do broad cleanup, refactors, or extra improvements unless I ask.
- At the end, report only:
  1. what you changed
  2. what commands you ran
  3. what still needs my input, if anything

Goal:
Set up the project so I can start working quickly.

Context:
- I want to minimize context usage and maximize productive work within a limited usage budget.
- I prefer focused execution over broad analysis.
- I usually want one meaningful objective per session.
- If the work naturally splits into separate workstreams, tell me where a new session should start instead of carrying unnecessary context forward.

Project info:
- Project/app: [fill in]
- Stack: [fill in]
- Package manager: [fill in]
- Runtime/version requirements: [fill in]
- Constraints: [fill in]

Setup task:
- Get the project installed/configured/runnable.
- Only touch files required for setup.
- If there are multiple possible setup paths, choose the most standard and lowest-risk one.
- If blocked by missing secrets, external services, or credentials, stop and ask for the exact missing item.
```
