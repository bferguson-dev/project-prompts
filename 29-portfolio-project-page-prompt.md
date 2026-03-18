# Portfolio Project Page Prompt

<!-- prompt-meta:start -->
- Number: `29`
- Kind: `documentation`
- Tier: `documentation`
- Status: `active`
- Use when: the work is a hiring-facing project page or portfolio artifact.
- Avoid when: the repo documentation should remain purely operational.
- Overlaps with: `28-github-pages-repo-style-prompt.md`, `25-documentation-standards-prompt.md`
- Owner intent: Allow presentation-focused writing only where portfolio goals explicitly justify it.
<!-- prompt-meta:end -->

```text
When a project is complete enough to serve as a portfolio piece, create or
update a subpage for it in my GitHub Pages resume site.

Scope:
- Use this prompt for one specific project page within the portfolio site.
- Use the GitHub Pages repo style prompt for site-wide style and structure.

Audience and purpose:
- Write for hiring managers and recruiters first.
- The page should let a new reader understand almost immediately what the
  project is, why it matters, what it does, and why they should care.
- Treat the page like an appetizer for the main course of the repository.
- The repository remains the full technical source of truth; the project page
  is the fast, polished overview.

Style and repo rules:
- Follow the established structure, components, visual language, and tone in
  the GitHub Pages repo.
- Do not introduce a new design system or inconsistent page pattern.
- Inspect only the relevant page templates, styles, and nearby project-page
  examples first.
- Keep the page concise, scannable, and credible.
- Avoid portfolio fluff, inflated claims, or vague buzzwords.

Content goals:
- Explain what the project is in plain language.
- State the problem it solves or the operational need it addresses.
- Summarize what it does and, where useful, what it does not do.
- Call out the most relevant technical or operational highlights.
- Mention requirements or assumptions only if they matter to a quick reader.
- Link clearly to the main repository for full setup, usage, and technical
  documentation.
- If appropriate, include screenshots, outputs, or short examples already used
  in the site.

Recommended structure:
1. Short project summary
2. Why it exists or what problem it solves
3. Key capabilities
4. Technical highlights or stack
5. Constraints, assumptions, or notable limitations
6. Link to repository and full documentation

Writing rules:
- Make the first screen useful.
- Prefer short sections and high-signal language.
- Write so a recruiter can understand the value quickly without reading the
  repository.
- Write so a technical reviewer can still see that the work is real and
  credible.

Output:
1. Pages repo files changed
2. Style patterns followed
3. Project-page summary added
4. Any missing content or assets still needed
```
