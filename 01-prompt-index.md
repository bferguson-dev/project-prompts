# Prompt Index

Use this index when starting a session by file reference instead of pasting
large prompt blocks. The intent is to let the agent read only the minimum
relevant files.

## Core Files

- [04-general-session-policy-prompt.md](<PROMPT_HOME>\04-general-session-policy-prompt.md)
  Use for almost every coding session.
- [05-project-governance-prompt.md](<PROMPT_HOME>\05-project-governance-prompt.md)
  Use when you want senior-engineer ownership and QA-level output.
- [06-coding-standards-prompt.md](<PROMPT_HOME>\06-coding-standards-prompt.md)
  Use as the baseline coding-quality standard.
- [07-github-workflow-prompt.md](<PROMPT_HOME>\07-github-workflow-prompt.md)
  Use as the baseline Git and review workflow standard.
- [08-credentials-and-secrets-prompt.md](<PROMPT_HOME>\08-credentials-and-secrets-prompt.md)
  Use as the baseline secret-handling standard.
- [09-test-strategy-prompt.md](<PROMPT_HOME>\09-test-strategy-prompt.md)
  Use as the baseline test-planning standard.
- [10-tooling-and-lint-prompt.md](<PROMPT_HOME>\10-tooling-and-lint-prompt.md)
  Use as the baseline validation and tooling standard.
- [11-adversarial-testing-prompt.md](<PROMPT_HOME>\11-adversarial-testing-prompt.md)
  Use when the work should be tested like someone is actively trying to break it.
- [12-reliability-and-recovery-prompt.md](<PROMPT_HOME>\12-reliability-and-recovery-prompt.md)
  Use when restart safety, retries, partial failure, or rollback matter.
- [13-security-review-prompt.md](<PROMPT_HOME>\13-security-review-prompt.md)
  Use when trust boundaries, secrets, auth, or exposure risk matter.
- [14-ship-readiness-prompt.md](<PROMPT_HOME>\14-ship-readiness-prompt.md)
  Use when deciding whether work is actually ready to ship.
- [15-compatibility-and-migration-prompt.md](<PROMPT_HOME>\15-compatibility-and-migration-prompt.md)
  Use when config, APIs, schemas, env vars, or workflows may break consumers.
- [02-session-start-cheatsheet.md](<PROMPT_HOME>\02-session-start-cheatsheet.md)
  Use to decide whether to keep the current session or start a new one.

## Task Prompts

- [16-project-setup-prompt.md](<PROMPT_HOME>\16-project-setup-prompt.md)
- [17-project-setup-prompt-short.md](<PROMPT_HOME>\17-project-setup-prompt-short.md)
- [18-bug-fix-prompt.md](<PROMPT_HOME>\18-bug-fix-prompt.md)
- [19-feature-work-prompt.md](<PROMPT_HOME>\19-feature-work-prompt.md)
- [20-code-review-prompt.md](<PROMPT_HOME>\20-code-review-prompt.md)
- [22-debugging-handoff-prompt.md](<PROMPT_HOME>\22-debugging-handoff-prompt.md)
- [21-refactor-prompt.md](<PROMPT_HOME>\21-refactor-prompt.md)
- [09-test-strategy-prompt.md](<PROMPT_HOME>\09-test-strategy-prompt.md)

## Process And Constraints

- [06-coding-standards-prompt.md](<PROMPT_HOME>\06-coding-standards-prompt.md)
- [10-tooling-and-lint-prompt.md](<PROMPT_HOME>\10-tooling-and-lint-prompt.md)
- [23-dependency-install-prompt.md](<PROMPT_HOME>\23-dependency-install-prompt.md)
- [24-environment-constraints-prompt.md](<PROMPT_HOME>\24-environment-constraints-prompt.md)
- [08-credentials-and-secrets-prompt.md](<PROMPT_HOME>\08-credentials-and-secrets-prompt.md)
- [07-github-workflow-prompt.md](<PROMPT_HOME>\07-github-workflow-prompt.md)

## Documentation

- [25-documentation-standards-prompt.md](<PROMPT_HOME>\25-documentation-standards-prompt.md)
- [26-readme-authoring-prompt.md](<PROMPT_HOME>\26-readme-authoring-prompt.md)
- [27-legal-disclaimer-prompt.md](<PROMPT_HOME>\27-legal-disclaimer-prompt.md)
- [29-portfolio-project-page-prompt.md](<PROMPT_HOME>\29-portfolio-project-page-prompt.md)
- [28-github-pages-repo-style-prompt.md](<PROMPT_HOME>\28-github-pages-repo-style-prompt.md)

## Recommended Usage

For baseline repo work, tell the agent to read at least:

1. [04-general-session-policy-prompt.md](<PROMPT_HOME>\04-general-session-policy-prompt.md)
2. [05-project-governance-prompt.md](<PROMPT_HOME>\05-project-governance-prompt.md)
3. [06-coding-standards-prompt.md](<PROMPT_HOME>\06-coding-standards-prompt.md)
4. [07-github-workflow-prompt.md](<PROMPT_HOME>\07-github-workflow-prompt.md)
5. [08-credentials-and-secrets-prompt.md](<PROMPT_HOME>\08-credentials-and-secrets-prompt.md)
6. [09-test-strategy-prompt.md](<PROMPT_HOME>\09-test-strategy-prompt.md)
7. [10-tooling-and-lint-prompt.md](<PROMPT_HOME>\10-tooling-and-lint-prompt.md)
8. One task prompt
9. Add [11-adversarial-testing-prompt.md](<PROMPT_HOME>\11-adversarial-testing-prompt.md), [12-reliability-and-recovery-prompt.md](<PROMPT_HOME>\12-reliability-and-recovery-prompt.md), [13-security-review-prompt.md](<PROMPT_HOME>\13-security-review-prompt.md), [14-ship-readiness-prompt.md](<PROMPT_HOME>\14-ship-readiness-prompt.md), and [15-compatibility-and-migration-prompt.md](<PROMPT_HOME>\15-compatibility-and-migration-prompt.md) for high-risk or shippable work
10. Optional constraint or documentation prompts only if relevant

This is the repo's default high-assurance baseline.
