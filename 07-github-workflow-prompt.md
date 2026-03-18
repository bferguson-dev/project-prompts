# GitHub Workflow Prompt

<!-- prompt-meta:start -->
- Number: `07`
- Kind: `core`
- Tier: `baseline`
- Status: `active`
- Use when: you want default Git, PR, and review workflow expectations.
- Avoid when: Git or review workflow is out of scope for the task.
- Overlaps with: `05-project-governance-prompt.md`, `08-credentials-and-secrets-prompt.md`
- Owner intent: Keep Git usage safe, reviewable, and compatible with a normal team workflow.
<!-- prompt-meta:end -->

```text
Work with Git and GitHub using a safe, professional, review-friendly process.

Rules:
- Use non-destructive Git commands only unless I explicitly ask otherwise.
- Never discard or overwrite unrelated local changes.
- Keep commits scoped to one meaningful objective.
- Prefer small, reviewable diffs over broad mixed changes.
- Follow the project's existing branch and commit conventions if they are
  visible.
- Use commit messages that describe the real change, not vague placeholders.
- Stage changes intentionally; do not commit an accidental subset or
  unexplained mix of staged and unstaged work.
- If preparing a PR, summarize behavior changes, risk areas, and verification.
- If reviewing changes, focus first on bugs, regressions, and missing tests.
- Do not rewrite history unless I explicitly ask for it.
- If the worktree is dirty, work carefully around unrelated edits.
- When uncertain whether a file was intentionally changed by me, preserve it
  and call out the risk.
- Before every commit, review `git diff --cached` for accidental secrets,
  personal data, machine paths, generated noise, and unrelated files.
- Before every commit, run `git diff --cached --check` and stop on whitespace,
  conflict-marker, or patch-application problems.
- Immediately before every commit, run `git secrets` against the pending
  changes and stop if it reports a problem.
- Before every commit, inspect file-mode changes and fix unexpected
  executable-bit changes.
- Before every commit, check for accidental binaries, large files, local notes,
  exported data, screenshots, archives, and machine-specific artifacts.
- If dependency manifests or lockfiles changed, run the relevant dependency
  vulnerability audit before committing.
- Before the first push to a new remote or after suspected exposure, run a
  history-aware secret scan such as `git secrets --scan-history`.
- Before pushing, verify the target branch and remote are the intended ones.
- Before pushing, confirm the remote branch history and push style are safe for
  the repo's workflow.
- Never treat a broken secret scan or broken quality gate as a pass.

Output:
1. Git-relevant actions taken
2. Files changed
3. Suggested commit or PR summary
4. Verification and review risks
```
