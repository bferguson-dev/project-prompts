#!/usr/bin/env python3
"""Generate prompt metadata blocks and repo docs from prompt_catalog.json."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


REPO = Path(__file__).resolve().parents[1]
CATALOG_PATH = REPO / "prompt_catalog.json"
VERSION_PATH = REPO / "VERSION"
INDEX_PATH = REPO / "01-prompt-index.md"
README_PATH = REPO / "README.md"
LEGAL_PROMPT_PATH = REPO / "27-legal-disclaimer-prompt.md"

META_START = "<!-- prompt-meta:start -->"
META_END = "<!-- prompt-meta:end -->"


def load_catalog() -> dict:
    return json.loads(CATALOG_PATH.read_text(encoding="utf-8"))


def grouped_prompts(prompts: list[dict]) -> dict[str, list[dict]]:
    groups = {
        "navigation": [],
        "core": [],
        "risk-overlay": [],
        "task": [],
        "process": [],
        "documentation": [],
    }
    for prompt in sorted(prompts, key=lambda item: item["number"]):
        groups[prompt["kind"]].append(prompt)
    return groups


def prompt_metadata_block(prompt: dict) -> str:
    overlaps = ", ".join(f"`{name}`" for name in prompt["overlaps_with"])
    return "\n".join(
        [
            META_START,
            f"- Number: `{prompt['number']:02d}`",
            f"- Kind: `{prompt['kind']}`",
            f"- Tier: `{prompt['tier']}`",
            f"- Status: `{prompt['status']}`",
            f"- Use when: {prompt['use_when']}.",
            f"- Avoid when: {prompt['avoid_when']}.",
            f"- Overlaps with: {overlaps}",
            f"- Owner intent: {prompt['owner_intent']}",
            META_END,
        ]
    )


def rendered_prompt_text(prompt: dict) -> str:
    path = REPO / prompt["filename"]
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()
    if not lines or not lines[0].startswith("# "):
        raise SystemExit(f"{path.name} must start with an H1 heading.")

    metadata = prompt_metadata_block(prompt)
    if META_START in text and META_END in text:
        start = text.index(META_START)
        end = text.index(META_END) + len(META_END)
        updated = text[:start].rstrip() + "\n\n" + metadata + text[end:]
    else:
        body = "\n".join(lines[1:]).lstrip("\n")
        updated = lines[0] + "\n\n" + metadata + "\n\n" + body
    return updated.rstrip() + "\n"


def render_index(catalog: dict) -> str:
    prompts = sorted(catalog["prompts"], key=lambda item: item["number"])
    groups = grouped_prompts(prompts)
    index_prompt = prompts[0]

    def entry(prompt: dict, with_desc: bool = True) -> str:
        link = f"- [{prompt['filename']}](<PROMPT_HOME>\\{prompt['filename']})"
        if not with_desc:
            return link
        return link + f"\n  Use when {prompt['use_when']}."

    lines = [
        "# Prompt Index",
        "",
        prompt_metadata_block(index_prompt),
        "",
        "Use this index when starting a session by file reference instead of pasting",
        "large prompt blocks. The intent is to let the agent read only the minimum",
        "relevant files.",
        "",
        "## Navigation And Session Start",
        "",
    ]
    for prompt in groups["navigation"][1:]:
        lines.extend([entry(prompt), ""])
    lines.extend(
        [
            "## Core Files",
            "",
        ]
    )
    for prompt in groups["core"] + groups["risk-overlay"]:
        lines.extend([entry(prompt), ""])
    lines.extend(
        [
            "## Task Prompts",
            "",
        ]
    )
    for prompt in groups["task"]:
        lines.append(entry(prompt, with_desc=False))
    lines.extend(
        [
            "",
            "## Process And Constraints",
            "",
        ]
    )
    for prompt in groups["process"]:
        lines.append(entry(prompt, with_desc=False))
    lines.extend(
        [
            "",
            "## Documentation",
            "",
        ]
    )
    for prompt in groups["documentation"]:
        lines.append(entry(prompt, with_desc=False))
    lines.extend(
        [
            "",
            "## Recommended Usage",
            "",
            "For baseline repo work, tell the agent to read at least:",
            "",
            "1. [04-general-session-policy-prompt.md](<PROMPT_HOME>\\04-general-session-policy-prompt.md)",
            "2. [05-project-governance-prompt.md](<PROMPT_HOME>\\05-project-governance-prompt.md)",
            "3. [06-coding-standards-prompt.md](<PROMPT_HOME>\\06-coding-standards-prompt.md)",
            "4. [07-github-workflow-prompt.md](<PROMPT_HOME>\\07-github-workflow-prompt.md)",
            "5. [08-credentials-and-secrets-prompt.md](<PROMPT_HOME>\\08-credentials-and-secrets-prompt.md)",
            "6. [09-test-strategy-prompt.md](<PROMPT_HOME>\\09-test-strategy-prompt.md)",
            "7. [10-tooling-and-lint-prompt.md](<PROMPT_HOME>\\10-tooling-and-lint-prompt.md)",
            "8. One task prompt from `16` to `22`",
            "9. Add `11` to `15` for high-risk or shippable work",
            "10. Add process or documentation prompts only when they are directly relevant",
            "",
            "This is the repo's default high-assurance baseline.",
        ]
    )
    return "\n".join(lines) + "\n"


def render_readme(catalog: dict) -> str:
    version = catalog["current_version"]
    groups = grouped_prompts(
        sorted(catalog["prompts"], key=lambda item: item["number"])
    )

    def bullet(prompt: dict) -> list[str]:
        return [
            f"- `{prompt['filename']}`",
            f"  Use when {prompt['use_when']}.",
        ]

    lines = [
        "# Prompt Kit For Making Shit Good",
        "",
        "This repo is a practical prompt kit for running engineering work with better",
        "judgment, tighter QA, and less avoidable mess.",
        "",
        f"Current prompt-kit version: `{version}`.",
        "",
        "The goal is not to load everything at once. The goal is to load the minimum",
        "set of prompts that gives a coding agent the right operating rules for the",
        "task in front of it.",
        "",
        "## Start Here",
        "",
        "For baseline repo work, use this core pack:",
        "",
        "1. `04-general-session-policy-prompt.md`",
        "2. `05-project-governance-prompt.md`",
        "3. `06-coding-standards-prompt.md`",
        "4. `07-github-workflow-prompt.md`",
        "5. `08-credentials-and-secrets-prompt.md`",
        "6. `09-test-strategy-prompt.md`",
        "7. `10-tooling-and-lint-prompt.md`",
        "8. Add `11` to `15` when risk, compatibility, or release readiness matter",
        "9. Add one task prompt from `16` to `22`",
        "",
        "If you want a file-based entry point, start with `01-prompt-index.md`.",
        "",
        "The leading numbers indicate recommended load order and relative importance:",
        "",
        "- `01` to `03`: navigation and session-start helpers",
        "- `04` to `10`: baseline operating rules",
        "- `11` to `15`: risk-focused overlays for stronger review depth",
        "- `16` to `22`: task-specific prompts",
        "- `23` to `24`: process and environment constraints",
        "- `25` to `29`: documentation and presentation prompts",
        "",
        "## Compatibility Table",
        "",
        "| Range | Role | Default |",
        "|---|---|---|",
        "| `01-03` | Navigation helpers | Optional |",
        "| `04-10` | Baseline operating rules | Default for most repo work |",
        "| `11-15` | Risk overlays | Add for higher-risk or shippable work |",
        "| `16-22` | Task prompts | Choose one per objective |",
        "| `23-24` | Constraints | Add only when directly relevant |",
        "| `25-29` | Documentation and presentation | Add only when docs or presentation are in scope |",
        "",
        "## Core Files",
        "",
    ]
    for prompt in groups["navigation"] + groups["core"] + groups["risk-overlay"]:
        lines.extend(bullet(prompt))
    lines.extend(
        [
            "",
            "## Task Prompts",
            "",
            "Use the task prompt that matches the current objective:",
            "",
        ]
    )
    for prompt in groups["task"]:
        lines.append(f"- `{prompt['filename']}`")
    lines.extend(
        [
            "",
            "Then add only the relevant supporting prompts for standards, workflow,",
            "secrets, environment constraints, docs, or repo style.",
            "",
            "## Prompt Bundles",
            "",
            "- Small bug fix: `04`, `06`, `09`, `10`, `18`",
            "- Security-sensitive feature: `04`, `05`, `08`, `09`, `10`, `11`, `13`, `19`",
            "- Ship-readiness pass: `04`, `05`, `09`, `10`, `12`, `14`, `15`, `20`",
            "- Documentation refresh: `04`, `25`, `26`, `27`",
            "",
            "## Anti-Patterns",
            "",
            "- Loading every prompt by default instead of choosing a scoped bundle",
            "- Using multiple task prompts for one objective instead of picking one work mode",
            "- Treating overlays as baseline requirements for trivial changes",
            "- Rewriting the canonical legal disclaimer instead of reusing it verbatim",
            "- Renaming numbered files without updating the catalog, index, README, and changelog together",
            "",
            "## Update Safely",
            "",
            "1. Edit `prompt_catalog.json` first.",
            "2. Run `python scripts/sync_prompt_docs.py`.",
            "3. Run `python scripts/lint_prompts.py`.",
            "4. Run `./check.sh`.",
            "5. Review `git diff --cached`.",
            "6. Record policy-level changes in `CHANGELOG.md`.",
            "",
            "## Prompt Lifecycle",
            "",
            "- `active`: current and recommended",
            "- `deprecated`: still present for compatibility, but not preferred for new usage",
            "- `archived`: retained for history only",
            "",
            "See `PROMPT_POLICY.md` for numbering, deprecation, breaking-change, and",
            "downstream-sync rules.",
            "",
            "## Secret Scanning",
            "",
            "This repo includes `.gitleaks.toml` and `.githooks/pre-commit` so staged",
            "changes can be scanned consistently.",
            "",
            "One-time setup:",
            "",
            "```bash",
            "git config core.hooksPath .githooks",
            "```",
            "",
            "`check.sh` also uses `gitleaks` for staged and optional history-aware secret",
            "scanning. This repo does not rely on `git-secrets`.",
            "",
            "## Workflow Defaults",
            "",
            "This repo assumes:",
            "",
            "- working software comes first",
            "- minimal context loading",
            "- small safe changes",
            "- longer tasks include concise bulleted progress updates every 60 seconds",
            "- progress updates use short, concrete `Now:`, `Done:`, `Found:`, `Blocker:`, and `Next:` lines when relevant",
            "- progress updates explicitly say `Blocker: none` when there is no blocker",
            "- QA-first execution",
            "- non-destructive Git usage",
            "- no secrets committed, ever",
            "- no false passes on broken or skipped validation",
            "- usability and operator clarity matter, not just raw correctness",
            "- assumptions, regressions, and what was not verified must be surfaced",
            "- rollback, recovery, compatibility, and observability matter for real releases",
            "",
            "## Downstream Consumer Checklist",
            "",
            "1. Record the prompt-kit version or commit you are using.",
            "2. Reuse the canonical disclaimer text from `27-legal-disclaimer-prompt.md` verbatim.",
            "3. Keep numbered filenames intact when referencing prompt files.",
            "4. Treat local prompt changes as explicit deviations.",
            "5. Re-run downstream validation after sync.",
            "",
            "## `check.sh`",
            "",
            "`check.sh` is the repo's all-around QA gate. It is meant to be a practical",
            "single entry point, not a narrow lint wrapper.",
            "",
            "Its purpose is to support shipping code that actually works, not to create a",
            "false sense of quality from clean syntax or green lint alone.",
            "",
            "It currently covers:",
            "",
            "- staged Git hygiene and patch quality checks",
            "- formatting and linting",
            "- static security scanning",
            "- secret scanning",
            "- dependency auditing",
            "- shell-script linting when available",
            "- Markdown style and relative-link checks when available",
            "- prompt-catalog generation and lint checks",
            "- test-layer reporting for unit, integration, system, acceptance, regression,",
            "  performance/load, usability, and security concerns",
            "- Git hygiene checks around staged diffs, secret exposure, and file modes",
            "- staged-diff heuristics for merge markers, debug prints, task-note markers,",
            "  suspicious local paths, secret-like additions, and accidental artifacts",
            "- config syntax validation for JSON, YAML, and TOML",
            "- case-collision detection for case-insensitive filesystem safety",
            "- executable-file sanity checks for shebangs and suspicious executable files",
            "- optional strict-mode behavior that can fail when key doc or shell tools are",
            "  missing",
            "",
            "## Placeholder Convention",
            "",
            "`<PROMPT_HOME>` is a neutral placeholder for the local directory where these",
            "prompt files live. Use it in docs and examples instead of machine-specific",
            "user paths.",
            "",
            "## Regression Fixtures",
            "",
            "The repo includes `tests/check_sh_selftest.sh` plus fixture files under",
            "`tests/fixtures/check-sh/` so `check.sh` can be regression-tested, not just",
            "syntax-checked.",
            "",
            "## Changelog",
            "",
            "Policy-level changes to the prompt kit are tracked in `CHANGELOG.md`.",
            "",
            "## Failure-Mode Reference",
            "",
            "Use `QA_FAILURE_MODES.md` as the consolidated reference for the bug",
            "classes, failure modes, and review blind spots this kit is meant to",
            "cover.",
            "",
            "## Intent",
            "",
            "This repo is for making agent-driven engineering work sharper, safer, and more",
            "reviewable without turning every task into process theater.",
        ]
    )
    return "\n".join(lines) + "\n"


def rendered_legal_prompt(catalog: dict) -> str:
    path = LEGAL_PROMPT_PATH
    text = path.read_text(encoding="utf-8")
    prefix, _, _ = text.partition("Exact disclaimer text:")
    replacement = (
        "Exact disclaimer text:\n"
        f'"{catalog["canonical_legal_disclaimer"]}"\n\n'
        "Usage rules:\n"
        "- Use that exact wording in every repository disclaimer.\n"
        "- The README may add formatting for visibility, but the sentence wording must\n"
        "  remain identical.\n"
        "- A dedicated disclaimer file may add a heading, but the disclaimer body must\n"
        "  remain identical.\n"
        "- If a repository needs a different disclaimer, flag it as an exception rather\n"
        "  than silently rewriting the standard text.\n\n"
        "Output:\n"
        "1. Exact disclaimer text reused verbatim\n"
        "2. Files updated to use it\n"
        "3. Any exception that would require legal review\n"
        "```\n"
    )
    return prefix + replacement


def check_or_write(path: Path, expected: str, check: bool) -> bool:
    current = path.read_text(encoding="utf-8") if path.exists() else ""
    if check:
        return current == expected
    path.write_text(expected, encoding="utf-8")
    return True


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    catalog = load_catalog()
    ok = True
    for prompt in catalog["prompts"]:
        ok = (
            check_or_write(
                REPO / prompt["filename"], rendered_prompt_text(prompt), args.check
            )
            and ok
        )
    ok = check_or_write(INDEX_PATH, render_index(catalog), args.check) and ok
    ok = check_or_write(README_PATH, render_readme(catalog), args.check) and ok
    ok = (
        check_or_write(LEGAL_PROMPT_PATH, rendered_legal_prompt(catalog), args.check)
        and ok
    )
    ok = (
        check_or_write(VERSION_PATH, catalog["current_version"] + "\n", args.check)
        and ok
    )

    if args.check and not ok:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
