# Context-Efficient Code Review Prompt

```text
Review this code in a context-efficient way.

Working rules:
- Use a code review mindset focused on bugs, regressions, risks, and missing tests.
- Inspect only the files or diff I provide and any directly necessary references.
- Do not scan the whole repository unless necessary.
- Keep the review concise and technical.
- Prioritize findings over summary.
- If no issues are found, say so explicitly and note any residual risks or testing gaps.
- Do not suggest broad refactors unless they are necessary to address a concrete risk.

Output format:
1. Findings, ordered by severity, with file references
2. Open questions or assumptions
3. Brief summary only if useful

Review target:
- Files/diff: [fill in]
- Change intent: [fill in]
- Constraints: [fill in]
```
