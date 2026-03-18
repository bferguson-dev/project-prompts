#!/usr/bin/env python3
"""Validate prompt catalog, generated docs, and canonical prompt metadata."""

from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path


REPO = Path(__file__).resolve().parents[1]
CATALOG_PATH = REPO / "prompt_catalog.json"
VERSION_PATH = REPO / "VERSION"
META_START = "<!-- prompt-meta:start -->"
META_END = "<!-- prompt-meta:end -->"


def fail(message: str) -> None:
    sys.stdout.write(f"FAIL: {message}\n")
    sys.exit(1)


def main() -> None:
    catalog = json.loads(CATALOG_PATH.read_text(encoding="utf-8"))
    prompts = sorted(catalog["prompts"], key=lambda item: item["number"])

    expected_numbers = list(range(1, len(prompts) + 1))
    actual_numbers = [prompt["number"] for prompt in prompts]
    if actual_numbers != expected_numbers:
        fail("prompt numbers must be contiguous starting at 1")

    filenames = [prompt["filename"] for prompt in prompts]
    if len(filenames) != len(set(filenames)):
        fail("duplicate filenames found in prompt_catalog.json")

    for prompt in prompts:
        path = REPO / prompt["filename"]
        if not path.exists():
            fail(f"missing prompt file: {prompt['filename']}")
        text = path.read_text(encoding="utf-8")
        if META_START not in text or META_END not in text:
            fail(f"metadata block missing in {prompt['filename']}")
        if not text.startswith("# "):
            fail(f"{prompt['filename']} must start with an H1 heading")

    version = VERSION_PATH.read_text(encoding="utf-8").strip()
    if version != catalog["current_version"]:
        fail("VERSION does not match prompt_catalog.json current_version")

    legal_text = catalog["canonical_legal_disclaimer"]
    legal_prompt = (REPO / "27-legal-disclaimer-prompt.md").read_text(encoding="utf-8")
    if legal_text not in legal_prompt:
        fail(
            "canonical legal disclaimer text is missing from 27-legal-disclaimer-prompt.md"
        )

    result = subprocess.run(
        [sys.executable, "scripts/sync_prompt_docs.py", "--check"],
        cwd=REPO,
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        sys.stdout.write(result.stdout)
        sys.stderr.write(result.stderr)
        fail("sync_prompt_docs.py failed")

    sys.stdout.write("OK: prompt catalog and generated docs are consistent\n")


if __name__ == "__main__":
    main()
