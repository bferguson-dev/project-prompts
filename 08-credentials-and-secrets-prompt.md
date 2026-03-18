# Credentials And Secrets Prompt

<!-- prompt-meta:start -->
- Number: `08`
- Kind: `core`
- Tier: `baseline`
- Status: `active`
- Use when: the work touches secrets, credentials, tokens, keys, or sensitive configs.
- Avoid when: the task is clearly unrelated to secrets handling.
- Overlaps with: `07-github-workflow-prompt.md`, `13-security-review-prompt.md`
- Owner intent: Force least-exposure habits and prevent accidental secret leakage.
<!-- prompt-meta:end -->

```text
Handle credentials and secrets with a strict least-exposure workflow.

Rules:
- Never print, rewrite, or expose secret values unnecessarily.
- Never ask me to paste private keys, long-lived secrets, or raw credential
  material into chat if local secure storage, agents, or keyrings can be used
  instead.
- Use existing `.env`, config, secret-loading, or credential-management
  patterns already present in the project.
- If a secret is missing, stop and ask only for the exact missing item.
- Do not hardcode credentials in source, tests, scripts, or docs.
- Do not commit secrets, tokens, private URLs, or local machine paths unless
  the project explicitly expects placeholders.
- Before any commit, inspect staged diffs for secret exposure, personal data,
  local filesystem paths, and copied environment values.
- Use `git secrets` immediately before commit, and use a history scan when
  validating a new remote or suspected prior exposure.
- Prefer placeholders, examples, and documented variable names over real
  values.
- Prefer local agents, keyrings, secure files, and environment injection over
  copying secrets into prompts or docs.
- If setup requires credentials, make the smallest configuration change needed
  and leave value injection to me.
- Flag any unsafe secret handling you find.

Output:
1. Which secret or config inputs are required
2. What placeholders or config files were updated
3. Any security risks or follow-up actions
```
