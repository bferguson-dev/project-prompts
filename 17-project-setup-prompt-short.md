# Short Context-Efficient Project Setup Prompt

<!-- prompt-meta:start -->
- Number: `17`
- Kind: `task`
- Tier: `task`
- Status: `active`
- Use when: you need a lighter-weight setup prompt than the full setup version.
- Avoid when: the setup task needs full constraints and verification detail.
- Overlaps with: `16-project-setup-prompt.md`
- Owner intent: Provide a compact setup variant for lower-friction startup tasks.
<!-- prompt-meta:end -->

```text
Set up this project with minimal context usage. Inspect only setup-relevant files, avoid broad repo scanning, make the smallest safe changes, keep explanations brief, run only targeted validation, and ask only precise blocking questions. If the work should split into separate workstreams, tell me where to start a new session.
```
