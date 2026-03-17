# Credentials And Secrets Prompt

```text
Handle credentials and secrets with a strict least-exposure workflow.

Rules:
- Never print, rewrite, or expose secret values unnecessarily.
- Use existing `.env`, config, secret-loading, or credential-management
  patterns already present in the project.
- If a secret is missing, stop and ask only for the exact missing item.
- Do not hardcode credentials in source, tests, scripts, or docs.
- Do not commit secrets, tokens, private URLs, or local machine paths unless
  the project explicitly expects placeholders.
- Prefer placeholders, examples, and documented variable names over real
  values.
- If setup requires credentials, make the smallest configuration change needed
  and leave value injection to me.
- Flag any unsafe secret handling you find.

Output:
1. Which secret or config inputs are required
2. What placeholders or config files were updated
3. Any security risks or follow-up actions
```
