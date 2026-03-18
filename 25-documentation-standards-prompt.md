# Documentation Standards Prompt

<!-- prompt-meta:start -->
- Number: `25`
- Kind: `documentation`
- Tier: `documentation`
- Status: `active`
- Use when: the task is writing or reviewing operational repository documentation.
- Avoid when: the work is portfolio or GitHub Pages presentation rather than operational docs.
- Overlaps with: `26-readme-authoring-prompt.md`, `27-legal-disclaimer-prompt.md`
- Owner intent: Keep documentation operational, scannable, and useful for maintainers.
<!-- prompt-meta:end -->

```text
Write documentation like production documentation for infrastructure
engineers, not like a portfolio or marketing page.

Scope:
- Use this prompt for general repository and operational documentation.
- Use the README-specific prompt for README details.
- Use the GitHub Pages and portfolio prompts for hiring-facing presentation.

Audience and tone:
- Assume the primary reader is an infrastructure engineer, operator, or future
  maintainer.
- Use direct, operational language.
- Be easy to scan and easy to execute.
- Avoid portfolio tone, hype, and vague claims.

Documentation rules:
- Prefer step-by-step instructions over descriptive prose when explaining setup
  or usage.
- Make the documentation readable enough that a new reader can quickly learn:
  what the project is, what it does, what it does not do, what is required,
  assumptions, how to run it, how to use it, and expected output.
- Include concrete commands, file names, inputs, and outputs when available.
- Document templates, special commands, flags, modes, and operational options.
- Add a light troubleshooting section covering the most common failure modes.
- Include rollback, recovery, compatibility, or migration notes when the system
  can fail or change state in non-obvious ways.
- Add a known bugs or known limitations section when relevant.
- Keep links, filenames, example commands, and referenced outputs current with
  the repository as it actually exists.
- Do not include real secrets, personal data, or the repo owner's personal
  name unless the task explicitly requires it.
- Keep the README concise but complete; move fuller legal or policy language to
  dedicated files when appropriate.

Timing:
- Defer heavy documentation work until near the end of the project so it is not
  rewritten repeatedly.
- Defer broad code-comment passes until implementation is stable.

README requirements:
- At the very top, include a short, high-visibility disclaimer in italics with
  symbols before and after it.
- The short disclaimer should be about two sentences and clearly state that the
  project has not been tested in a production environment and that users must
  perform their own due diligence and testing before use.
- The README should include clear sections for overview, non-goals or what it
  does not do, requirements, assumptions, setup, usage, expected output,
  troubleshooting, and known bugs.

Repo requirements:
- Add a fuller disclaimer file in the repository with stronger legal language,
  including use-at-your-own-risk and no-responsibility language.

Output:
1. Documentation files changed
2. Audience assumptions used
3. Key sections added or updated
4. Any documentation or troubleshooting gaps left open
```
