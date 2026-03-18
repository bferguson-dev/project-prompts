# Prompt Index

Use this index when starting a session by file reference instead of pasting
large prompt blocks. The intent is to let the agent read only the minimum
relevant files.

## Core Files

- [general-session-policy-prompt.md](<PROMPT_HOME>\general-session-policy-prompt.md)
  Use for almost every coding session.
- [project-governance-prompt.md](<PROMPT_HOME>\project-governance-prompt.md)
  Use when you want senior-engineer ownership and QA-level output.
- [coding-standards-prompt.md](<PROMPT_HOME>\coding-standards-prompt.md)
  Use as the baseline coding-quality standard.
- [github-workflow-prompt.md](<PROMPT_HOME>\github-workflow-prompt.md)
  Use as the baseline Git and review workflow standard.
- [credentials-and-secrets-prompt.md](<PROMPT_HOME>\credentials-and-secrets-prompt.md)
  Use as the baseline secret-handling standard.
- [test-strategy-prompt.md](<PROMPT_HOME>\test-strategy-prompt.md)
  Use as the baseline test-planning standard.
- [tooling-and-lint-prompt.md](<PROMPT_HOME>\tooling-and-lint-prompt.md)
  Use as the baseline validation and tooling standard.
- [adversarial-testing-prompt.md](<PROMPT_HOME>\adversarial-testing-prompt.md)
  Use when the work should be tested like someone is actively trying to break it.
- [reliability-and-recovery-prompt.md](<PROMPT_HOME>\reliability-and-recovery-prompt.md)
  Use when restart safety, retries, partial failure, or rollback matter.
- [security-review-prompt.md](<PROMPT_HOME>\security-review-prompt.md)
  Use when trust boundaries, secrets, auth, or exposure risk matter.
- [session-start-cheatsheet.md](<PROMPT_HOME>\session-start-cheatsheet.md)
  Use to decide whether to keep the current session or start a new one.

## Task Prompts

- [project-setup-prompt.md](<PROMPT_HOME>\project-setup-prompt.md)
- [project-setup-prompt-short.md](<PROMPT_HOME>\project-setup-prompt-short.md)
- [bug-fix-prompt.md](<PROMPT_HOME>\bug-fix-prompt.md)
- [feature-work-prompt.md](<PROMPT_HOME>\feature-work-prompt.md)
- [code-review-prompt.md](<PROMPT_HOME>\code-review-prompt.md)
- [debugging-handoff-prompt.md](<PROMPT_HOME>\debugging-handoff-prompt.md)
- [refactor-prompt.md](<PROMPT_HOME>\refactor-prompt.md)
- [test-strategy-prompt.md](<PROMPT_HOME>\test-strategy-prompt.md)

## Process And Constraints

- [coding-standards-prompt.md](<PROMPT_HOME>\coding-standards-prompt.md)
- [tooling-and-lint-prompt.md](<PROMPT_HOME>\tooling-and-lint-prompt.md)
- [dependency-install-prompt.md](<PROMPT_HOME>\dependency-install-prompt.md)
- [environment-constraints-prompt.md](<PROMPT_HOME>\environment-constraints-prompt.md)
- [credentials-and-secrets-prompt.md](<PROMPT_HOME>\credentials-and-secrets-prompt.md)
- [github-workflow-prompt.md](<PROMPT_HOME>\github-workflow-prompt.md)

## Documentation

- [documentation-standards-prompt.md](<PROMPT_HOME>\documentation-standards-prompt.md)
- [readme-authoring-prompt.md](<PROMPT_HOME>\readme-authoring-prompt.md)
- [legal-disclaimer-prompt.md](<PROMPT_HOME>\legal-disclaimer-prompt.md)
- [portfolio-project-page-prompt.md](<PROMPT_HOME>\portfolio-project-page-prompt.md)
- [github-pages-repo-style-prompt.md](<PROMPT_HOME>\github-pages-repo-style-prompt.md)

## Recommended Usage

For baseline repo work, tell the agent to read at least:

1. [general-session-policy-prompt.md](<PROMPT_HOME>\general-session-policy-prompt.md)
2. [project-governance-prompt.md](<PROMPT_HOME>\project-governance-prompt.md)
3. [coding-standards-prompt.md](<PROMPT_HOME>\coding-standards-prompt.md)
4. [github-workflow-prompt.md](<PROMPT_HOME>\github-workflow-prompt.md)
5. [credentials-and-secrets-prompt.md](<PROMPT_HOME>\credentials-and-secrets-prompt.md)
6. [test-strategy-prompt.md](<PROMPT_HOME>\test-strategy-prompt.md)
7. [tooling-and-lint-prompt.md](<PROMPT_HOME>\tooling-and-lint-prompt.md)
8. One task prompt
9. Add [adversarial-testing-prompt.md](<PROMPT_HOME>\adversarial-testing-prompt.md), [reliability-and-recovery-prompt.md](<PROMPT_HOME>\reliability-and-recovery-prompt.md), and [security-review-prompt.md](<PROMPT_HOME>\security-review-prompt.md) for high-risk or shippable work
10. Optional constraint or documentation prompts only if relevant

This is the repo's default high-assurance baseline.
