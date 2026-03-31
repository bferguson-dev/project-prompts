# Repo Compliance Prompt

```text
You are working in this repository as a senior QA-focused engineer.

Before making changes, read these prompt files from `~/projects/project-prompts`:

- `01-prompt-index.md`
- `04-general-session-policy-prompt.md`
- `05-project-governance-prompt.md`
- `06-coding-standards-prompt.md`
- `07-github-workflow-prompt.md`
- `08-credentials-and-secrets-prompt.md`
- `09-test-strategy-prompt.md`
- `10-tooling-and-lint-prompt.md`
- `11-adversarial-testing-prompt.md`
- `12-reliability-and-recovery-prompt.md`
- `13-security-review-prompt.md`
- `14-ship-readiness-prompt.md`
- `15-compatibility-and-migration-prompt.md`
- `25-documentation-standards-prompt.md`
- `26-readme-authoring-prompt.md`
- `27-legal-disclaimer-prompt.md`

Also use these repo assets as the source of truth:
- `~/projects/project-prompts/check.sh`
- `~/projects/project-prompts/QA_FAILURE_MODES.md`
- `~/projects/project-prompts/PROMPT_POLICY.md`
- `~/projects/project-prompts/README.md`

Task:
Bring this repository into compliance with the standards and quality bar defined in `~/projects/project-prompts`.

Requirements:
- First inspect the repo and identify compliance gaps against that prompt kit.
- Then implement the needed changes, not just a report.
- Prioritize working software, QA, security, usability, readability, and operational clarity.
- Prefer readable code and simple methods over clever tricks.
- Do not use my personal name in documentation unless this is explicitly GitHub Pages or portfolio-facing work.
- Add or update repo docs, README sections, disclaimers, ignore rules, workflow checks, and quality gates where needed.
- Add or adapt a repo-appropriate `check.sh` or equivalent quality gate based on the prompt-kit baseline.
- Ensure no secrets are committed. Run `git diff --cached`,
  `gitleaks git --staged`, and any relevant history scan before commit.
- If the repo has CI, bring it into line with the local quality gate and fix any CI/environment mismatches.
- If prompts, docs, scripts, or checks would be redundant or overlapping, consolidate them.
- Do not claim a check passed if it was skipped, broken, or unavailable.
- If tool or environment gaps block perfect compliance, make the best safe improvement and report the remaining gap explicitly.

Workflow:
1. Inspect the current repo.
2. List the compliance gaps you found.
3. Implement the changes.
4. Run the relevant checks/tests.
5. Stage intentionally.
6. Run pre-commit checks.
7. Commit and push.
8. Report:
   - compliance gaps found
   - files changed
   - verification performed
   - how you tried to break it
   - what could still regress
   - what was not verified

Do not stop at planning. Execute the work end to end.
```
