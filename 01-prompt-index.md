# Prompt Index

<!-- prompt-meta:start -->
- Number: `01`
- Kind: `navigation`
- Tier: `navigation`
- Status: `active`
- Use when: you need the fastest file-based entry point into the prompt kit.
- Avoid when: the user already named the exact prompt files to load.
- Overlaps with: `02-session-start-cheatsheet.md`, `03-master-session-template.md`
- Owner intent: Provide the lowest-friction map for loading only the minimum useful prompt context.
<!-- prompt-meta:end -->

Use this index when starting a session by file reference instead of pasting
large prompt blocks. The intent is to let the agent read only the minimum
relevant files.

## Navigation And Session Start

- [02-session-start-cheatsheet.md](<PROMPT_HOME>\02-session-start-cheatsheet.md)
  Use when you need a quick decision aid for choosing a task prompt or deciding whether to start a new session.

- [03-master-session-template.md](<PROMPT_HOME>\03-master-session-template.md)
  Use when you want a structured handoff or repeatable session start template.

## Core Files

- [04-general-session-policy-prompt.md](<PROMPT_HOME>\04-general-session-policy-prompt.md)
  Use when you need the default engineering behavior for most coding sessions.

- [05-project-governance-prompt.md](<PROMPT_HOME>\05-project-governance-prompt.md)
  Use when you want stronger senior-engineer ownership and release-safety behavior.

- [06-coding-standards-prompt.md](<PROMPT_HOME>\06-coding-standards-prompt.md)
  Use when you need local-pattern-preserving implementation standards.

- [07-github-workflow-prompt.md](<PROMPT_HOME>\07-github-workflow-prompt.md)
  Use when you want default Git, PR, and review workflow expectations.

- [08-credentials-and-secrets-prompt.md](<PROMPT_HOME>\08-credentials-and-secrets-prompt.md)
  Use when the work touches secrets, credentials, tokens, keys, or sensitive configs.

- [09-test-strategy-prompt.md](<PROMPT_HOME>\09-test-strategy-prompt.md)
  Use when you need explicit test-scope reasoning and layered validation choices.

- [10-tooling-and-lint-prompt.md](<PROMPT_HOME>\10-tooling-and-lint-prompt.md)
  Use when you need validation-order discipline and project-tool alignment.

- [11-adversarial-testing-prompt.md](<PROMPT_HOME>\11-adversarial-testing-prompt.md)
  Use when you want break-it thinking for risky or exposed changes.

- [12-reliability-and-recovery-prompt.md](<PROMPT_HOME>\12-reliability-and-recovery-prompt.md)
  Use when restart safety, retries, rollback, or partial failure matter.

- [13-security-review-prompt.md](<PROMPT_HOME>\13-security-review-prompt.md)
  Use when trust boundaries, auth, secrets, or exposure risk are central.

- [14-ship-readiness-prompt.md](<PROMPT_HOME>\14-ship-readiness-prompt.md)
  Use when you need an evidence-based go/no-go judgment.

- [15-compatibility-and-migration-prompt.md](<PROMPT_HOME>\15-compatibility-and-migration-prompt.md)
  Use when interfaces, configs, schemas, or workflows might break consumers.

## Task Prompts

- [16-project-setup-prompt.md](<PROMPT_HOME>\16-project-setup-prompt.md)
- [17-project-setup-prompt-short.md](<PROMPT_HOME>\17-project-setup-prompt-short.md)
- [18-bug-fix-prompt.md](<PROMPT_HOME>\18-bug-fix-prompt.md)
- [19-feature-work-prompt.md](<PROMPT_HOME>\19-feature-work-prompt.md)
- [20-code-review-prompt.md](<PROMPT_HOME>\20-code-review-prompt.md)
- [21-refactor-prompt.md](<PROMPT_HOME>\21-refactor-prompt.md)
- [22-debugging-handoff-prompt.md](<PROMPT_HOME>\22-debugging-handoff-prompt.md)

## Process And Constraints

- [23-dependency-install-prompt.md](<PROMPT_HOME>\23-dependency-install-prompt.md)
- [24-environment-constraints-prompt.md](<PROMPT_HOME>\24-environment-constraints-prompt.md)

## Documentation

- [25-documentation-standards-prompt.md](<PROMPT_HOME>\25-documentation-standards-prompt.md)
- [26-readme-authoring-prompt.md](<PROMPT_HOME>\26-readme-authoring-prompt.md)
- [27-legal-disclaimer-prompt.md](<PROMPT_HOME>\27-legal-disclaimer-prompt.md)
- [28-github-pages-repo-style-prompt.md](<PROMPT_HOME>\28-github-pages-repo-style-prompt.md)
- [29-portfolio-project-page-prompt.md](<PROMPT_HOME>\29-portfolio-project-page-prompt.md)

## Recommended Usage

For baseline repo work, tell the agent to read at least:

1. [04-general-session-policy-prompt.md](<PROMPT_HOME>\04-general-session-policy-prompt.md)
2. [05-project-governance-prompt.md](<PROMPT_HOME>\05-project-governance-prompt.md)
3. [06-coding-standards-prompt.md](<PROMPT_HOME>\06-coding-standards-prompt.md)
4. [07-github-workflow-prompt.md](<PROMPT_HOME>\07-github-workflow-prompt.md)
5. [08-credentials-and-secrets-prompt.md](<PROMPT_HOME>\08-credentials-and-secrets-prompt.md)
6. [09-test-strategy-prompt.md](<PROMPT_HOME>\09-test-strategy-prompt.md)
7. [10-tooling-and-lint-prompt.md](<PROMPT_HOME>\10-tooling-and-lint-prompt.md)
8. One task prompt from `16` to `22`
9. Add `11` to `15` for high-risk or shippable work
10. Add process or documentation prompts only when they are directly relevant

This is the repo's default high-assurance baseline.
