# Test Strategy Prompt

<!-- prompt-meta:start -->
- Number: `09`
- Kind: `core`
- Tier: `baseline`
- Status: `active`
- Use when: you need explicit test-scope reasoning and layered validation choices.
- Avoid when: the task is purely documentation or policy work with no behavior change.
- Overlaps with: `10-tooling-and-lint-prompt.md`, `11-adversarial-testing-prompt.md`
- Owner intent: Make test scope intentional instead of defaulting to broad or shallow validation.
<!-- prompt-meta:end -->

```text
Add or update tests with a QA-oriented and scope-controlled workflow.

Rules:
- Prioritize validation that proves the software actually works for the
  requested behavior before expanding into secondary quality checks.
- Use this as the general testing baseline; add the adversarial, reliability,
  or security prompts when deeper risk-specific review is needed.
- Focus on tests that prove the requested behavior or bug fix.
- Prefer the smallest set of high-value tests over broad speculative coverage.
- Match the project's existing test style, fixtures, helpers, and naming.
- Do not rewrite unrelated tests.
- Choose the right test layers for the task instead of defaulting to one type
  of test.
- Consider these test types when relevant:
  - Unit testing: test individual functions or components.
  - Integration testing: test interactions between modules.
  - System testing: test the application as a whole.
  - Acceptance testing: confirm the software meets business requirements.
  - Regression testing: ensure new changes do not break existing behavior.
  - Performance or load testing: evaluate speed and stability under load.
  - Usability testing: evaluate user experience where workflow or UI quality
    matters.
  - Security testing: check for vulnerabilities where trust boundaries,
    secrets, auth, input handling, or permissions are involved.
- If the code is hard to test, identify the narrowest practical seam rather
  than pushing a large refactor by default.
- Cover the main success path, the key regression path, and important edge
  cases when warranted by risk.
- For auth, trust-boundary, or permissions changes, include negative-path and
  denial-path testing where relevant.
- For user-facing changes, include usability or accessibility validation when
  the task materially affects interaction quality.
- Run only the relevant tests first.
- State which test types are in scope, which are out of scope, and why.
- Do not imply coverage you did not actually run or verify.
- If broader coverage is still missing, note it as a follow-up risk.

Output:
1. Tests added or updated
2. Behavior covered
3. Commands run
4. Remaining test gaps
```
