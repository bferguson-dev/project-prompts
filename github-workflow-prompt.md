# GitHub Workflow Prompt

```text
Work with Git and GitHub using a safe, professional, review-friendly process.

Rules:
- Use non-destructive Git commands only unless I explicitly ask otherwise.
- Never discard or overwrite unrelated local changes.
- Keep commits scoped to one meaningful objective.
- Prefer small, reviewable diffs over broad mixed changes.
- Follow the project's existing branch and commit conventions if they are
  visible.
- If preparing a PR, summarize behavior changes, risk areas, and verification.
- If reviewing changes, focus first on bugs, regressions, and missing tests.
- Do not rewrite history unless I explicitly ask for it.
- If the worktree is dirty, work carefully around unrelated edits.
- When uncertain whether a file was intentionally changed by me, preserve it
  and call out the risk.

Output:
1. Git-relevant actions taken
2. Files changed
3. Suggested commit or PR summary
4. Verification and review risks
```
