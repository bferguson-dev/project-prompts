from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path


REPO = Path(__file__).resolve().parents[1]


def run(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, *args],
        cwd=REPO,
        text=True,
        capture_output=True,
        check=False,
    )


def test_prompt_linter_passes() -> None:
    result = run("scripts/lint_prompts.py")
    assert result.returncode == 0, result.stdout + result.stderr


def test_catalog_numbers_are_contiguous() -> None:
    catalog = json.loads((REPO / "prompt_catalog.json").read_text(encoding="utf-8"))
    numbers = [prompt["number"] for prompt in catalog["prompts"]]
    assert numbers == list(range(1, len(numbers) + 1))


def test_all_prompt_files_have_metadata_block() -> None:
    catalog = json.loads((REPO / "prompt_catalog.json").read_text(encoding="utf-8"))
    for prompt in catalog["prompts"]:
        text = (REPO / prompt["filename"]).read_text(encoding="utf-8")
        assert "<!-- prompt-meta:start -->" in text
        assert "<!-- prompt-meta:end -->" in text
