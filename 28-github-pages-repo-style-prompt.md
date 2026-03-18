# GitHub Pages Repo Style Prompt

<!-- prompt-meta:start -->
- Number: `28`
- Kind: `documentation`
- Tier: `documentation`
- Status: `active`
- Use when: the repo is a GitHub Pages or public-facing presentation site.
- Avoid when: the repo is internal or operational rather than presentation-focused.
- Overlaps with: `29-portfolio-project-page-prompt.md`, `25-documentation-standards-prompt.md`
- Owner intent: Provide public-site style rules without contaminating operational repo docs.
<!-- prompt-meta:end -->

```text
When working in a personal GitHub Pages portfolio repo, follow the established
site style and page structure instead of inventing a new pattern.

Scope:
- Use this prompt for portfolio-site repo style and structure.
- Use the portfolio project page prompt for the content of a specific project
  page inside that site.

Observed site conventions:
- The site presents an infrastructure automation and operations portfolio.
- Writing is direct, restrained, and credible.
- Claims are narrow and evidence-based.
- Project summaries are concise and easy to scan.
- The tone is professional and hiring-facing, not flashy or portfolio-hyped.
- Project pages act as a fast overview and link readers to the full repository
  for technical depth.
- Current project pages use section-based layouts such as:
  summary, what it does, maturity, validation status, why it is worth
  featuring, at-a-glance facts, and links.

Working rules:
- Inspect the existing homepage, nearby project pages, shared templates, and
  styles before editing.
- Match the site's existing structure, typography, spacing, and content rhythm.
- Do not introduce a new content model unless the repo already supports it.
- Keep the first screen immediately useful to a recruiter or hiring manager.
- Preserve the site's honest-scope positioning.
- Separate implemented facts, validation status, and future work clearly.
- Link back to the repository for setup, usage, and detailed documentation.
- Prefer high-signal sections over long narrative prose.

Writing rules:
- Write for hiring managers, recruiters, and technical reviewers.
- Explain the project in plain language quickly.
- State what operational problem it solves or what workflow it supports.
- Keep technology mentions concrete and relevant.
- Avoid inflated claims, broad platform language, and vague buzzwords.
- If validation is limited, say so directly.
- If future scope exists, distinguish it clearly from shipped capability.

Recommended page structure:
1. Short summary
2. What it does
3. Current maturity or shipped scope
4. Validation status
5. Why it is worth featuring
6. At-a-glance facts
7. Links

Output:
1. Pages repo files changed
2. Existing page patterns followed
3. Any style or content assumptions made
4. Missing assets or inputs still needed
```
