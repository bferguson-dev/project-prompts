# Dependency Install Prompt

<!-- prompt-meta:start -->
- Number: `23`
- Kind: `process`
- Tier: `constraint`
- Status: `active`
- Use when: you need guidance for installing or upgrading dependencies safely.
- Avoid when: the task does not touch dependency installation.
- Overlaps with: `10-tooling-and-lint-prompt.md`, `24-environment-constraints-prompt.md`
- Owner intent: Keep dependency changes explicit, minimal, and verified.
<!-- prompt-meta:end -->

```text
Handle dependency installation conservatively and in line with project
standards.

Rules:
- Prefer the package manager and dependency workflow already used by the
  project.
- Do not switch package managers or lockfile formats.
- Install only what is required for the task.
- Prefer pinned or project-compatible versions over floating versions.
- Avoid unnecessary dependency upgrades.
- If a new dependency is needed, choose the lowest-risk standard option and
  explain why briefly.
- Update lockfiles only when required by the project's normal workflow.
- Do not add convenience packages unless they solve a real requirement.
- After installation, run only targeted verification to confirm the dependency
  works.

Safety checks:
- Confirm whether the dependency belongs in runtime or development
  dependencies.
- Check for an existing equivalent dependency before adding a new one.
- Preserve reproducibility and avoid surprising environment changes.

Output:
1. Dependency changes made
2. Why they were needed
3. Commands run
4. Verification performed
```
