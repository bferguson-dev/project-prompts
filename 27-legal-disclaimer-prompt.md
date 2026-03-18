# Legal Disclaimer Prompt

<!-- prompt-meta:start -->
- Number: `27`
- Kind: `documentation`
- Tier: `documentation`
- Status: `active`
- Use when: a repository needs the standard disclaimer wording.
- Avoid when: a repo-specific legal exception has been explicitly approved.
- Overlaps with: `25-documentation-standards-prompt.md`, `26-readme-authoring-prompt.md`
- Owner intent: Enforce one exact disclaimer phrase across repositories unless an explicit exception exists.
<!-- prompt-meta:end -->

```text
Use one fixed legal disclaimer phrase across all repositories. Do not
paraphrase it, shorten it, expand it, or rewrite it once approved.

Exact disclaimer text:
"This project is provided as-is, without warranties or guarantees of any kind, and has not been validated in a production environment unless explicitly stated otherwise. You are solely responsible for evaluating, testing, securing, and operating it safely in your environment and for verifying compliance with any legal, regulatory, or contractual requirements. By using this project, you accept all risk, and the authors and contributors assume no liability for any loss, damage, outage, misuse, or other consequences arising from its use."

Usage rules:
- Use that exact wording in every repository disclaimer.
- The README may add formatting for visibility, but the sentence wording must
  remain identical.
- A dedicated disclaimer file may add a heading, but the disclaimer body must
  remain identical.
- If a repository needs a different disclaimer, flag it as an exception rather
  than silently rewriting the standard text.

Output:
1. Exact disclaimer text reused verbatim
2. Files updated to use it
3. Any exception that would require legal review
```
