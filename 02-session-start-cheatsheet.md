# Session Start Cheatsheet

<!-- prompt-meta:start -->
- Number: `02`
- Kind: `navigation`
- Tier: `navigation`
- Status: `active`
- Use when: you need a quick decision aid for choosing a task prompt or deciding whether to start a new session.
- Avoid when: the session already has a clear, stable task prompt.
- Overlaps with: `01-prompt-index.md`, `03-master-session-template.md`
- Owner intent: Reduce session churn and prompt sprawl by steering users to one clear work mode.
<!-- prompt-meta:end -->

Use one prompt per meaningful objective. Keep the session focused on a single workstream until the files, goal, or subsystem materially change.

## Which Prompt To Use

- Project setup: use [16-project-setup-prompt.md](<PROMPT_HOME>\16-project-setup-prompt.md)
- Quick setup: use [17-project-setup-prompt-short.md](<PROMPT_HOME>\17-project-setup-prompt-short.md)
- Bug fix: use [18-bug-fix-prompt.md](<PROMPT_HOME>\18-bug-fix-prompt.md)
- Feature work: use [19-feature-work-prompt.md](<PROMPT_HOME>\19-feature-work-prompt.md)
- Code review: use [20-code-review-prompt.md](<PROMPT_HOME>\20-code-review-prompt.md)

## Keep The Same Session When

- You are still working on the same bug, feature, or refactor
- The same files or subsystem are still central
- Prior decisions from the thread still matter
- The follow-up task is directly downstream of the current one

## Start A New Session When

- You switch to a different subsystem
- You move from implementation to brainstorming or architecture
- The thread has accumulated a lot of irrelevant history
- You want a cleaner, tighter handoff for a new task
- The relevant files and goal have materially changed

## High-Efficiency Session Rules

- Name the exact goal
- Provide exact errors when debugging
- Point to the relevant files
- Ask for the smallest safe change
- Avoid mixing unrelated tasks in one thread
- Ask for targeted validation instead of full-suite work unless needed
- Keep explanations brief unless you want teaching

## Fast Rule Of Thumb

One meaningful objective per session:

- Good: "Fix auth redirect loop"
- Good: "Add export button to report page"
- Good: "Review this payment retry diff"
- Bad: "Help with my whole app"
