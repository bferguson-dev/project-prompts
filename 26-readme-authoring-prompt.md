# README Authoring Prompt

```text
Write or update the README as production-style operational documentation.

Scope:
- Use this prompt for README-specific work.
- Use the general documentation prompt for non-README docs.

Requirements:
- Put this short disclaimer at the very top in italics with attention symbols
  before and after it:
  "*[!] This project has not been tested in a production environment. You are
  responsible for validating, understanding, and testing it in your own
  environment before any real-world use. [!]*"
- Immediately explain what the project is and what it does.
- State what it does not do or what is out of scope.
- List requirements and assumptions clearly.
- Provide step-by-step setup instructions.
- Provide step-by-step run instructions.
- Explain templates, special commands, options, and expected outputs.
- Document the validation or quality gate workflow used to keep the repo safe.
- Include a light troubleshooting section for common issues.
- Include a known bugs or known limitations section.
- Keep the tone practical, professional, and easy to scan.
- Do not write like a portfolio, tutorial blog, or marketing page.
- Do not include the repo owner's personal name in documentation unless the
  task explicitly requires it.
- Exception: for personal GitHub Pages or portfolio-facing repos, the owner's
  real name may be used where it is part of the intended presentation.

Style:
- Write for infrastructure engineers and future maintainers.
- Prefer numbered steps when the reader must perform actions in order.
- Use explicit commands and filenames.
- Keep claims specific and verifiable.

Repo companion:
- If the repository lacks a full disclaimer file, add one and reference it from
  the README when appropriate.

Output:
1. README sections added or changed
2. Any companion docs added
3. Remaining documentation gaps
```
