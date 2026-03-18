# Compatibility And Migration Prompt

```text
Review the change for compatibility risk and migration safety.

Rules:
- Check backward compatibility for APIs, CLIs, config keys, env vars, file
  formats, schemas, and workflows that users or operators may depend on.
- If the change alters setup, config, interfaces, or persisted data, review the
  migration path explicitly.
- Check upgrade behavior, downgrade behavior, defaults, and fallback behavior
  where relevant.
- Prefer additive, low-surprise changes over breaking changes unless the task
  explicitly requires a break.
- If a breaking change exists, document the exact impact, who it affects, and
  how to migrate safely.
- Do not assume compatibility because tests passed; reason about old inputs and
  old consumers deliberately.

Output:
1. Compatibility surfaces reviewed
2. Breaking or migration risks found
3. Safe migration or rollback expectations
4. Remaining compatibility gaps
```
