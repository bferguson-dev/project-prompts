# Prompt Policy

This file defines how the prompt kit evolves without drifting into duplicate,
conflicting, or unreviewable guidance.

## Versioning

- The prompt kit version is stored in `VERSION`.
- The version format is `YYYY.MM.DD.REVISION`.
- Increment `REVISION` for same-day prompt-kit changes.
- Downstream repos that want reproducible prompt behavior should pin to a
  commit or recorded version number.

## Prompt Lifecycle

- `active`: the prompt is current and recommended.
- `deprecated`: the prompt still exists for compatibility, but new usage should
  move elsewhere.
- `archived`: the prompt is retained only for historical reference and should
  not be loaded by default.

Lifecycle status is tracked in `prompt_catalog.json`.

## Add Or Merge

Create a new prompt only when at least one of these is true:

- the task needs a distinct work mode that would otherwise make an existing
  prompt confusing or overloaded
- the new rules have a different audience or output shape
- the prompt is reused independently often enough to justify separate loading

Merge into an existing prompt when the new guidance is only:

- a small extension of an existing task mode
- a tighter example of a current rule
- a duplicate policy stated with different words

## Metadata Convention

Every numbered prompt file must contain a generated metadata block with:

- number
- kind
- tier
- status
- use when
- avoid when
- overlaps with
- owner intent

The source of truth for metadata is `prompt_catalog.json`.

## Numbering Convention

- `01` to `03`: navigation and session-start helpers
- `04` to `10`: baseline operating rules
- `11` to `15`: risk overlays
- `16` to `22`: task prompts
- `23` to `24`: process and environment constraints
- `25` to `29`: documentation and presentation prompts

Do not renumber existing prompts casually. Renumbering is a breaking change.

## Deprecation Convention

When deprecating a prompt:

1. Mark its status as `deprecated` in `prompt_catalog.json`.
2. Add a deprecation note in the prompt body and point to the replacement.
3. Record the change in `CHANGELOG.md`.
4. Keep the filename stable until downstream users have had a migration window.

## Breaking Change Policy

Treat these as breaking changes:

- renaming or removing a numbered prompt file
- changing the canonical legal disclaimer text
- moving prompt scope in a way that invalidates existing prompt bundles
- changing the numbering ranges or load-order expectations

Breaking changes must be called out explicitly in `CHANGELOG.md`.

## Canonical Disclaimer

The legal disclaimer text in `prompt_catalog.json` and
`27-legal-disclaimer-prompt.md` is canonical.

- It must be reused verbatim across repositories.
- Formatting may change for visibility.
- Wording may not change without an explicit prompt-kit policy decision.

## Update Safely

Before committing prompt-kit changes:

1. Update `prompt_catalog.json` first.
2. Run `python scripts/sync_prompt_docs.py`.
3. Run `python scripts/lint_prompts.py`.
4. Run `./check.sh`.
5. Review `git diff --cached`.
6. Record policy-level changes in `CHANGELOG.md`.

## Downstream Sync Checklist

When applying this prompt kit to another repo:

1. Record the prompt-kit version or commit.
2. Update the target repo to the canonical disclaimer text.
3. Verify any copied filenames still match the numbered prompt set.
4. Re-run local validation in the downstream repo.
5. Treat local exceptions as explicit deviations, not silent rewrites.
