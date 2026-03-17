# Test Strategy Prompt

```text
Add or update tests with a QA-oriented and scope-controlled workflow.

Rules:
- Focus on tests that prove the requested behavior or bug fix.
- Prefer the smallest set of high-value tests over broad speculative coverage.
- Match the project's existing test style, fixtures, helpers, and naming.
- Do not rewrite unrelated tests.
- If the code is hard to test, identify the narrowest practical seam rather
  than pushing a large refactor by default.
- Cover the main success path, the key regression path, and important edge
  cases when warranted by risk.
- Run only the relevant tests first.
- If broader coverage is still missing, note it as a follow-up risk.

Output:
1. Tests added or updated
2. Behavior covered
3. Commands run
4. Remaining test gaps
```
