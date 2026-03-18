#!/usr/bin/env bash
set -euo pipefail

# =========================
# Config (override via env)
# =========================
PYTHON_BIN="${PYTHON_BIN:-python3}"
VENV_DIR="${VENV_DIR:-.venv}"

# Bandit policy: fail on MEDIUM+ (treat as P2 or higher)
BANDIT_MIN_SEVERITY="${BANDIT_MIN_SEVERITY:-medium}"      # low|medium|high
BANDIT_MIN_CONFIDENCE="${BANDIT_MIN_CONFIDENCE:-medium}"  # low|medium|high

# pip-audit policy: fail if any vulnerability is found
PIP_AUDIT_FAIL_ON_VULNS="${PIP_AUDIT_FAIL_ON_VULNS:-1}"    # 1=yes, 0=no

# Ruff policy
RUFF_AUTO_FIX="${RUFF_AUTO_FIX:-1}"                        # 1=yes, 0=no

# Gitleaks policy
GITLEAKS_FAIL_ON_FINDINGS="${GITLEAKS_FAIL_ON_FINDINGS:-1}" # 1=yes, 0=no

# Git hygiene policy
RUN_GIT_CHECKS="${RUN_GIT_CHECKS:-1}"
RUN_GIT_SECRETS_CACHED="${RUN_GIT_SECRETS_CACHED:-1}"
RUN_GIT_SECRETS_HISTORY="${RUN_GIT_SECRETS_HISTORY:-0}"
FAIL_ON_EXECUTABLE_MARKDOWN="${FAIL_ON_EXECUTABLE_MARKDOWN:-1}"
FAIL_ON_UNSTAGED_CHANGES="${FAIL_ON_UNSTAGED_CHANGES:-1}"
FAIL_ON_DIFF_CHECK="${FAIL_ON_DIFF_CHECK:-1}"
FAIL_ON_BINARY_STAGED="${FAIL_ON_BINARY_STAGED:-1}"
FAIL_ON_LARGE_STAGED_FILES="${FAIL_ON_LARGE_STAGED_FILES:-1}"
MAX_STAGED_FILE_KB="${MAX_STAGED_FILE_KB:-1024}"
FAIL_ON_SUSPICIOUS_UNTRACKED="${FAIL_ON_SUSPICIOUS_UNTRACKED:-1}"
FAIL_ON_SUSPICIOUS_STAGED_PATHS="${FAIL_ON_SUSPICIOUS_STAGED_PATHS:-1}"
FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS="${FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS:-1}"
FAIL_ON_CRLF_STAGED="${FAIL_ON_CRLF_STAGED:-1}"
FAIL_ON_STAGED_MARKERS="${FAIL_ON_STAGED_MARKERS:-1}"
FAIL_ON_CASE_COLLISIONS="${FAIL_ON_CASE_COLLISIONS:-1}"
FAIL_ON_EXECUTABLE_WITHOUT_SHEBANG="${FAIL_ON_EXECUTABLE_WITHOUT_SHEBANG:-1}"

# Test strategy policy
UNIT_TEST_PATH="${UNIT_TEST_PATH:-tests/unit}"
INTEGRATION_TEST_PATH="${INTEGRATION_TEST_PATH:-tests/integration}"
SYSTEM_TEST_PATH="${SYSTEM_TEST_PATH:-tests/system}"
REGRESSION_TEST_PATH="${REGRESSION_TEST_PATH:-tests}"
PYTEST_FALLBACK_TARGET="${PYTEST_FALLBACK_TARGET:-tests}"
ACCEPTANCE_TEST_CMD="${ACCEPTANCE_TEST_CMD:-}"
PERFORMANCE_TEST_CMD="${PERFORMANCE_TEST_CMD:-}"
USABILITY_TEST_CMD="${USABILITY_TEST_CMD:-}"

# Optional quality checks
ENABLE_SHELLCHECK_IF_AVAILABLE="${ENABLE_SHELLCHECK_IF_AVAILABLE:-1}"
ENABLE_MARKDOWN_LINK_CHECKS="${ENABLE_MARKDOWN_LINK_CHECKS:-1}"
ENABLE_MARKDOWNLINT_IF_AVAILABLE="${ENABLE_MARKDOWNLINT_IF_AVAILABLE:-1}"
ENABLE_CONFIG_SYNTAX_CHECKS="${ENABLE_CONFIG_SYNTAX_CHECKS:-1}"
RUN_PROMPT_CHECKS="${RUN_PROMPT_CHECKS:-1}"
STRICT_MODE="${STRICT_MODE:-0}"
FAIL_ON_MISSING_OPTIONAL_TOOLS="${FAIL_ON_MISSING_OPTIONAL_TOOLS:-0}"

if [[ "$STRICT_MODE" == "1" ]]; then
  FAIL_ON_MISSING_OPTIONAL_TOOLS=1
  RUN_GIT_SECRETS_HISTORY=1
fi

# =========================
# Step: repo root + venv
# =========================
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  echo "ERROR: $PYTHON_BIN not found."
  exit 2
fi

if [[ ! -d "$VENV_DIR" ]]; then
  echo "[setup] Creating venv at $VENV_DIR"
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

if [[ ! -x "$VENV_DIR/bin/python" ]]; then
  echo "[setup] Recreating venv at $VENV_DIR for this platform"
  rm -rf "$VENV_DIR"
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

if [[ -x "$VENV_DIR/bin/python" ]]; then
  VENV_PYTHON="$VENV_DIR/bin/python"
elif [[ -x "$VENV_DIR/Scripts/python.exe" ]]; then
  VENV_PYTHON="$VENV_DIR/Scripts/python.exe"
elif [[ -x "$VENV_DIR/Scripts/python" ]]; then
  VENV_PYTHON="$VENV_DIR/Scripts/python"
else
  echo "ERROR: Could not find venv python in $VENV_DIR."
  exit 3
fi

if [[ -f "$VENV_DIR/bin/activate" ]]; then
  # shellcheck disable=SC1091
  source "$VENV_DIR/bin/activate"
  echo "[debug] VIRTUAL_ENV=$VIRTUAL_ENV"
  echo "[debug] which python: $(command -v python)"
  echo "[debug] python: $(python -V)"
  echo "[debug] which pip: $(command -v pip)"
  echo "[debug] pip: $(pip -V)"
  echo "[debug] which ruff: $(command -v ruff || true)"
  echo "[debug] which bandit: $(command -v bandit || true)"
  echo "[debug] which pip-audit: $(command -v pip-audit || true)"
  echo "[debug] which gitleaks: $(command -v gitleaks || true)"
fi

echo "[setup] Upgrading pip + installing tooling"
if ! "$VENV_PYTHON" -m pip install -U pip >/dev/null 2>&1; then
  echo "[setup] WARN: Could not upgrade pip (likely offline); continuing with existing pip."
fi
if ! "$VENV_PYTHON" -m pip install -U ruff bandit pip-audit pytest pyyaml >/dev/null 2>&1; then
  echo "[setup] WARN: Could not install tooling from index (likely offline); using locally available tools only."
fi

# Optional fallback for pre-provisioned site-packages (offline escape hatch).
# Disabled by default so legacy env content does not leak into lint/audit/tests.
if [[ "${READYCHECK_ENABLE_PYTHONPATH_FALLBACK:-0}" == "1" ]] && [[ -d "$REPO_DIR/.venv313/Lib/site-packages" ]]; then
  export PYTHONPATH="$REPO_DIR/.venv313/Lib/site-packages${PYTHONPATH:+:$PYTHONPATH}"
fi

have_tool() {
  local module="$1"
  "$VENV_PYTHON" -m "$module" --version >/dev/null 2>&1
}

have_path() {
  local target="$1"
  [[ -n "$target" && -e "$target" ]]
}

have_command() {
  command -v "$1" >/dev/null 2>&1
}

have_python_tool() {
  local module="$1"
  "$VENV_PYTHON" -m "$module" --help >/dev/null 2>&1
}

have_prompt_repo() {
  [[ -f "prompt_catalog.json" && -f "scripts/lint_prompts.py" && -f "scripts/sync_prompt_docs.py" ]]
}

run_optional_command() {
  local label="$1"
  local cmd="$2"
  if [[ -z "$cmd" ]]; then
    echo "[tests] ${label}: out of scope (no command configured)"
    return 0
  fi

  echo "[tests] ${label}: $cmd"
  bash -lc "$cmd"
}

run_pytest_target() {
  local label="$1"
  shift

  set +e
  "$VENV_PYTHON" -m pytest -q "$@"
  local rc=$?
  set -e

  if [[ "$rc" == "5" ]]; then
    echo "[tests] ${label}: no tests collected"
    return 0
  fi

  return "$rc"
}

list_staged_added_or_modified_files() {
  git diff --cached --name-only --diff-filter=AM
}

check_staged_file_sizes() {
  "$VENV_PYTHON" - <<PY
import os
import subprocess
import sys

limit_kb = int("${MAX_STAGED_FILE_KB}")
limit = limit_kb * 1024
proc = subprocess.run(
    ["git", "diff", "--cached", "--name-only", "--diff-filter=AM"],
    check=True,
    capture_output=True,
    text=True,
)
bad = []
for raw in proc.stdout.splitlines():
    path = raw.strip()
    if not path or not os.path.exists(path):
        continue
    size = os.path.getsize(path)
    if size > limit:
        bad.append((path, size))

if bad:
    print(f"FAIL: staged files exceed {limit_kb} KB:")
    for path, size in bad:
        print(f"- {path}: {size} bytes")
    sys.exit(1)
PY
}

check_case_collisions() {
  "$VENV_PYTHON" - <<'PY'
import subprocess
import sys

seen = {}
collisions = []
for cmd in (
    ["git", "ls-files"],
    ["git", "diff", "--cached", "--name-only", "--diff-filter=AM"],
):
    proc = subprocess.run(cmd, check=True, capture_output=True, text=True)
    for raw in proc.stdout.splitlines():
        path = raw.strip()
        if not path:
            continue
        lowered = path.lower()
        existing = seen.get(lowered)
        if existing is None:
            seen[lowered] = path
        elif existing != path:
            collisions.append((existing, path))

if collisions:
    print("FAIL: case-collision paths detected (unsafe on case-insensitive filesystems):")
    for left, right in collisions:
        print(f"- {left} <-> {right}")
    sys.exit(1)
PY
}

check_executable_files() {
  "$VENV_PYTHON" - <<'PY'
import os
import stat
import subprocess
import sys

proc = subprocess.run(["git", "ls-files"], check=True, capture_output=True, text=True)
bad_binary = []
bad_shebang = []
for raw in proc.stdout.splitlines():
    path = raw.strip()
    if not path or not os.path.isfile(path):
        continue
    mode = os.stat(path).st_mode
    if not (mode & stat.S_IXUSR):
        continue
    with open(path, "rb") as fh:
        data = fh.read(512)
    if b"\0" in data:
        bad_binary.append(path)
        continue
    if path.endswith(".md"):
        continue
    if not data.startswith(b"#!"):
        bad_shebang.append(path)

if bad_binary:
    print("FAIL: tracked executable files look binary or non-script:")
    for path in bad_binary:
        print(f"- {path}")
    sys.exit(1)

if bad_shebang:
    print("FAIL: executable text files are missing a shebang:")
    for path in bad_shebang:
        print(f"- {path}")
    sys.exit(1)
PY
}

check_staged_crlf() {
  "$VENV_PYTHON" - <<'PY'
import os
import subprocess
import sys

proc = subprocess.run(
    ["git", "diff", "--cached", "--name-only", "--diff-filter=AM"],
    check=True,
    capture_output=True,
    text=True,
)
bad = []
for raw in proc.stdout.splitlines():
    path = raw.strip()
    if not path or not os.path.isfile(path):
        continue
    data = open(path, "rb").read()
    if b"\0" in data:
        continue
    if b"\r\n" in data:
        bad.append(path)

if bad:
    print("FAIL: staged text files contain CRLF line endings:")
    for path in bad:
        print(f"- {path}")
    sys.exit(1)
PY
}

check_markdown_links() {
  "$VENV_PYTHON" - <<'PY'
import os
import re
import subprocess
import sys

root = os.getcwd()
pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
skip_prefixes = ("http://", "https://", "mailto:", "#")

proc = subprocess.run(
    ["git", "ls-files", "*.md"],
    check=True,
    capture_output=True,
    text=True,
)
bad = []
for path in [p for p in proc.stdout.splitlines() if p.strip()]:
    if not os.path.isfile(path):
        continue
    text = open(path, "r", encoding="utf-8").read()
    for target in pattern.findall(text):
        target = target.strip()
        if not target or target.startswith(skip_prefixes):
            continue
        if re.match(r"^[A-Za-z]:\\", target):
            continue
        if target.startswith("<PROMPT_HOME>"):
            continue
        if target.startswith("<") and target.endswith(">"):
            target = target[1:-1].strip()
            if not target or target.startswith(skip_prefixes):
                continue
        link_target = target.split("#", 1)[0]
        if not link_target:
            continue
        resolved = os.path.normpath(os.path.join(os.path.dirname(path), link_target))
        if not os.path.exists(os.path.join(root, resolved)):
            bad.append((path, target))

if bad:
    print("FAIL: broken relative Markdown links detected:")
    for path, target in bad:
        print(f"- {path}: {target}")
    sys.exit(1)
PY
}

check_staged_content_markers() {
  "$VENV_PYTHON" - <<'PY'
import re
import subprocess
import sys

diff = subprocess.run(
    ["git", "diff", "--cached", "--unified=0", "--no-color"],
    check=True,
    capture_output=True,
    text=True,
).stdout.splitlines()

patterns = [
    ("merge marker", re.compile(r"^\+(<{7}|={7}|>{7})")),
    ("todo marker", re.compile(r"^\+\s*.*\b(TODO|FIXME|HACK|XXX)\b")),
    ("debug print", re.compile(r"^\+\s*.*\b(console\.log|print\(|dbg!|debugger;|fmt\.Println|System\.out\.println)\b")),
    ("local path", re.compile(r"^\+\s*.*(/home/|C:\\\\Users\\\\|/mnt/c/Users/)")),
    ("private key marker", re.compile(r"^\+\s*.*(BEGIN [A-Z0-9 ]*PRIVATE KEY|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})")),
    ("confidential placeholder drift", re.compile(r"^\+\s*.*\b(password|passwd|token|secret|api[_-]?key)\b\s*[:=]\s*['\"]?[A-Za-z0-9/_+=.-]{8,}")),
]

hits = []
current_file = None
skip_exts = (".md", ".txt", ".rst")
skip_files = {"check.sh"}
for line in diff:
    if line.startswith("diff --git "):
        match = re.match(r"diff --git a/(.+) b/(.+)", line)
        current_file = match.group(2) if match else None
        continue
    if not line.startswith("+") or line.startswith("+++"):
        continue
    if current_file and (
        current_file in skip_files or current_file.endswith(skip_exts)
    ):
        continue
    for label, pattern in patterns:
        if pattern.search(line):
            hits.append((label, line[:200]))

if hits:
    print("FAIL: risky staged diff markers detected:")
    for label, line in hits[:40]:
        print(f"- {label}: {line}")
    if len(hits) > 40:
        print(f"... plus {len(hits) - 40} more.")
    sys.exit(1)
PY
}

check_staged_path_policy() {
  "$VENV_PYTHON" - <<'PY'
import os
import re
import subprocess
import sys

proc = subprocess.run(
    ["git", "diff", "--cached", "--name-only", "--diff-filter=AM"],
    check=True,
    capture_output=True,
    text=True,
)
dangerous = []
artifact_like = []
dangerous_re = re.compile(
    r"(^|/)(\.env($|\.)|.*\.pem$|.*\.key$|.*\.p12$|.*\.pfx$|.*\.kdbx$|.*:Zone\.Identifier$|.*\.local\..*|id_rsa(|\.pub)$|id_ed25519(|\.pub)$)",
    re.IGNORECASE,
)
artifact_re = re.compile(
    r"\.(zip|tar|tgz|gz|bz2|xz|7z|rar|sqlite|sqlite3|db|dump|bak|csv|tsv|parquet|png|jpg|jpeg|gif|bmp|pdf|doc|docx|xls|xlsx|ppt|pptx|mp4|mov|avi|mkv|wav|mp3)$",
    re.IGNORECASE,
)
for raw in proc.stdout.splitlines():
    path = raw.strip()
    if not path:
        continue
    if dangerous_re.search(path):
        dangerous.append(path)
    if artifact_re.search(path):
        artifact_like.append(path)

if dangerous:
    print("FAIL: suspicious staged secret-bearing or local-only paths detected:")
    for path in dangerous:
        print(f"- {path}")
    sys.exit(1)

if artifact_like and os.environ.get("FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS", "1") == "1":
    print("FAIL: suspicious staged artifact or export files detected:")
    for path in artifact_like:
        print(f"- {path}")
    sys.exit(2)
PY
}

check_shell_script_syntax() {
  local shell_files
  shell_files="$(find . -path './.git' -prune -o -type f -name '*.sh' -print)"
  if [[ -z "$shell_files" ]]; then
    echo "[shell] No shell scripts found; skipping shell syntax check."
    return 0
  fi

  echo "[shell] bash -n"
  while IFS= read -r file; do
    [[ -n "$file" ]] || continue
    bash -n "$file"
  done <<<"$shell_files"
}

check_markdown_text() {
  "$VENV_PYTHON" - <<'PY'
import os
import subprocess
import sys

proc = subprocess.run(
    ["git", "ls-files", "*.md"],
    check=True,
    capture_output=True,
    text=True,
)
bad_utf8 = []
bad_newline = []
for path in [p for p in proc.stdout.splitlines() if p.strip()]:
    if not os.path.isfile(path):
        continue
    data = open(path, "rb").read()
    try:
        data.decode("utf-8")
    except UnicodeDecodeError:
        bad_utf8.append(path)
        continue
    if data and not data.endswith(b"\n"):
        bad_newline.append(path)

if bad_utf8:
    print("FAIL: Markdown files are not valid UTF-8:")
    for path in bad_utf8:
        print(f"- {path}")
    sys.exit(1)

if bad_newline:
    print("FAIL: Markdown files do not end with a newline:")
    for path in bad_newline:
        print(f"- {path}")
    sys.exit(1)
PY
}

check_config_syntax() {
  "$VENV_PYTHON" - <<'PY'
import json
import os
import subprocess
import sys
import tomllib

try:
    import yaml  # type: ignore
except Exception:
    yaml = None

proc = subprocess.run(
    ["git", "ls-files", "*.json", "*.yaml", "*.yml", "*.toml"],
    check=True,
    capture_output=True,
    text=True,
)
failures = []
yaml_missing = []
for path in [p for p in proc.stdout.splitlines() if p.strip()]:
    if not os.path.isfile(path):
        continue
    try:
        if path.endswith(".json"):
            with open(path, "r", encoding="utf-8") as fh:
                json.load(fh)
        elif path.endswith((".yaml", ".yml")):
            if yaml is None:
                yaml_missing.append(path)
                continue
            with open(path, "r", encoding="utf-8") as fh:
                yaml.safe_load(fh)
        elif path.endswith(".toml"):
            with open(path, "rb") as fh:
                tomllib.load(fh)
    except Exception as exc:
        failures.append((path, str(exc)))

if yaml_missing:
    print("WARN: YAML files found but PyYAML is unavailable:")
    for path in yaml_missing:
        print(f"- {path}")
    if os.environ.get("FAIL_ON_MISSING_OPTIONAL_TOOLS") == "1":
        sys.exit(2)

if failures:
    print("FAIL: config syntax errors detected:")
    for path, message in failures:
        print(f"- {path}: {message}")
    sys.exit(1)
PY
}

have_git_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

run_git_checks() {
  if [[ "$RUN_GIT_CHECKS" != "1" ]]; then
    echo "[git] Git checks disabled"
    return 0
  fi

  if ! have_git_repo; then
    echo "[git] No Git repository detected; skipping Git checks."
    return 0
  fi

  echo "[git] status --short --branch"
  git status --short --branch

  echo "[git] current branch"
  git branch --show-current || true

  echo "[git] remotes"
  git remote -v || true

  if [[ "$FAIL_ON_UNSTAGED_CHANGES" == "1" ]] && ! git diff --quiet --exit-code; then
    echo "FAIL: unstaged changes are present. Stage intentionally before using this gate."
    return 23
  fi

  if [[ "$FAIL_ON_CASE_COLLISIONS" == "1" ]]; then
    check_case_collisions || return 33
  fi

  echo "[git] diff --cached --stat"
  git diff --cached --stat || true

  echo "[git] diff --cached --name-status"
  git diff --cached --name-status || true

  if [[ "$FAIL_ON_DIFF_CHECK" == "1" ]]; then
    echo "[git] diff --cached --check"
    git diff --cached --check
  fi

  if [[ "$FAIL_ON_EXECUTABLE_MARKDOWN" == "1" ]]; then
    local md_exec
    md_exec="$(find . -path './.git' -prune -o -type f -name '*.md' -perm /111 -print)"
    if [[ -n "$md_exec" ]]; then
      echo "FAIL: executable Markdown files detected:"
      printf '%s\n' "$md_exec"
      return 20
    fi
  fi

  if [[ "$FAIL_ON_BINARY_STAGED" == "1" ]]; then
    local binary_staged
    binary_staged="$(git diff --cached --numstat --diff-filter=AM | awk '$1 == "-" || $2 == "-" {print $3}')"
    if [[ -n "$binary_staged" ]]; then
      echo "FAIL: binary files are staged:"
      printf '%s\n' "$binary_staged"
      return 24
    fi
  fi

  if [[ "$FAIL_ON_LARGE_STAGED_FILES" == "1" ]]; then
    check_staged_file_sizes || return 25
  fi

  if [[ "$FAIL_ON_SUSPICIOUS_STAGED_PATHS" == "1" || "$FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS" == "1" ]]; then
    check_staged_path_policy || return 34
  fi

  if [[ "$FAIL_ON_SUSPICIOUS_UNTRACKED" == "1" ]]; then
    local suspicious_untracked
    suspicious_untracked="$(
      git ls-files --others --exclude-standard | grep -E \
        '(^|/)(\.env($|\.)|.*\.pem$|.*\.key$|.*\.p12$|.*\.pfx$|.*:Zone\.Identifier$|HANDOFF\.md$|RESUME_NOTE\.md$|SESSION_NOTES\.md$|.*\.local\..*)' \
        || true
    )"
    if [[ -n "$suspicious_untracked" ]]; then
      echo "FAIL: suspicious untracked local or secret-bearing files detected:"
      printf '%s\n' "$suspicious_untracked"
      return 26
    fi
  fi

  if [[ "$FAIL_ON_CRLF_STAGED" == "1" ]]; then
    check_staged_crlf || return 27
  fi

  if [[ "$FAIL_ON_STAGED_MARKERS" == "1" ]]; then
    check_staged_content_markers || return 28
  fi

  if [[ "$FAIL_ON_EXECUTABLE_WITHOUT_SHEBANG" == "1" ]]; then
    check_executable_files || return 35
  fi

  if [[ "$RUN_GIT_SECRETS_CACHED" == "1" ]]; then
    if have_command git-secrets; then
      if git secrets --scan --cached >/dev/null 2>&1; then
        echo "OK: git-secrets cached scan passed"
      else
        echo "FAIL: git-secrets cached scan found a problem."
        return 21
      fi
    elif [[ "$FAIL_ON_MISSING_OPTIONAL_TOOLS" == "1" ]]; then
      echo "FAIL: git-secrets is required in strict mode."
      return 31
    else
      echo "[git] WARN: git-secrets not installed; skipping cached scan."
    fi
  fi

  if [[ "$RUN_GIT_SECRETS_HISTORY" == "1" ]]; then
    if have_command git-secrets; then
      if git secrets --scan-history >/dev/null 2>&1; then
        echo "OK: git-secrets history scan passed"
      else
        echo "FAIL: git-secrets history scan found a problem."
        return 22
      fi
    elif [[ "$FAIL_ON_MISSING_OPTIONAL_TOOLS" == "1" ]]; then
      echo "FAIL: git-secrets is required in strict mode."
      return 32
    else
      echo "[git] WARN: git-secrets not installed; skipping history scan."
    fi
  fi
}

run_prompt_checks() {
  if [[ "$RUN_PROMPT_CHECKS" != "1" ]]; then
    echo "[prompts] Prompt checks disabled"
    return 0
  fi

  if ! have_prompt_repo; then
    echo "[prompts] No prompt catalog detected; skipping prompt-specific checks."
    return 0
  fi

  echo "[prompts] sync generated docs and metadata"
  "$VENV_PYTHON" scripts/sync_prompt_docs.py

  echo "[prompts] lint prompt catalog"
  "$VENV_PYTHON" scripts/lint_prompts.py
}

# =========================
# Step: git hygiene
# =========================
run_git_checks

# =========================
# Step: format (auto)
# =========================
echo "[format] ruff format"
if have_tool "ruff"; then
  "$VENV_PYTHON" -m ruff format .
else
  echo "[format] WARN: ruff unavailable; skipping format."
fi

# =========================
# Step: lint (auto-fix then enforce)
# =========================
if have_tool "ruff" && [[ "$RUFF_AUTO_FIX" == "1" ]]; then
  echo "[lint] ruff check (with auto-fix)"
  # Auto-fix what Ruff can. We ignore the return code on this pass because
  # the enforcement pass below is authoritative.
  "$VENV_PYTHON" -m ruff check . --fix || true
fi

if have_tool "ruff"; then
  echo "[lint] ruff check (enforce)"
  "$VENV_PYTHON" -m ruff check .
else
  echo "[lint] WARN: ruff unavailable; skipping lint."
fi

# =========================
# Step: security scan (Bandit)
# =========================
echo "[security] bandit (fail on ${BANDIT_MIN_SEVERITY}+ severity, ${BANDIT_MIN_CONFIDENCE}+ confidence)"
if have_tool "bandit"; then
  BANDIT_JSON="$(mktemp)"
  "$VENV_PYTHON" -m bandit -r . \
    -x "./.venv,./.venv*,./venv,./.git,./__pycache__,./.pytest_cache,./.ruff_cache,./build,./dist" \
    -f json -o "$BANDIT_JSON" >/dev/null || true

  "$VENV_PYTHON" - <<PY
import json, sys

path = r"$BANDIT_JSON"
min_sev = "$BANDIT_MIN_SEVERITY".lower()
min_conf = "$BANDIT_MIN_CONFIDENCE".lower()

order = {"low": 1, "medium": 2, "high": 3}
min_sev_n = order.get(min_sev, 2)
min_conf_n = order.get(min_conf, 2)

with open(path, "r", encoding="utf-8") as f:
    data = json.load(f)

results = data.get("results", [])
bad = []
for r in results:
    sev = (r.get("issue_severity") or "").lower()
    conf = (r.get("issue_confidence") or "").lower()
    if order.get(sev, 0) >= min_sev_n and order.get(conf, 0) >= min_conf_n:
        bad.append(r)

if bad:
    print(f"FAIL: Bandit found {len(bad)} issue(s) at severity>={min_sev} and confidence>={min_conf}.")
    for r in bad[:25]:
        print(f"- {r.get('filename')}:{r.get('line_number')} {r.get('test_id')} {r.get('issue_text')} "
              f"(sev={r.get('issue_severity')}, conf={r.get('issue_confidence')})")
    if len(bad) > 25:
        print(f"... plus {len(bad)-25} more.")
    sys.exit(10)

print("OK: Bandit policy passed")
PY

  rm -f "$BANDIT_JSON"
else
  echo "[security] WARN: bandit unavailable; skipping security scan."
fi

# =========================
# Step: secret scan (gitleaks)
# =========================
echo "[security] gitleaks"
if command -v gitleaks >/dev/null 2>&1; then
  run_gitleaks() {
    local args=(--no-banner --redact --source .)
    if [[ -f ".gitleaks.toml" ]]; then
      args+=(--config .gitleaks.toml)
    fi

    # Support current CLI first, then older `protect` style if available.
    if gitleaks detect "${args[@]}"; then
      return 0
    fi
    local rc=$?

    if gitleaks protect --help >/dev/null 2>&1; then
      if gitleaks protect --no-banner --redact --staged; then
        return 0
      fi
    fi

    return "$rc"
  }

  set +e
  GITLEAKS_OUTPUT="$(run_gitleaks 2>&1)"
  GITLEAKS_RC=$?
  set -e
  if [[ "$GITLEAKS_RC" != "0" ]]; then
    printf '%s\n' "$GITLEAKS_OUTPUT"
    if [[ "$GITLEAKS_FAIL_ON_FINDINGS" == "1" ]]; then
      echo "FAIL: gitleaks found potential secrets or could not complete successfully."
      exit 13
    fi
    echo "[security] WARN: gitleaks reported a problem, but failure is disabled."
  else
    printf '%s\n' "$GITLEAKS_OUTPUT"
    echo "OK: gitleaks found no secrets"
  fi
else
  echo "[security] WARN: gitleaks not installed; skipping secret scan."
fi

# =========================
# Step: dependency audit (pip-audit)
# =========================
echo "[deps] pip-audit"
if have_tool "pip_audit"; then
  run_pip_audit() {
    local output rc
    set +e
    output="$("$VENV_PYTHON" -m pip_audit "$@" 2>&1)"
    rc=$?
    set -e
    if [[ "$rc" != "0" ]] && grep -qiE \
      "ConnectionError|NameResolutionError|Failed to resolve|Max retries exceeded|Temporary failure in name resolution|No address associated with hostname" \
      <<<"$output"; then
      local reason=""
      reason="$(grep -m1 -E "ConnectionError|NameResolutionError|Failed to resolve|Max retries exceeded|Temporary failure in name resolution|No address associated with hostname" <<<"$output" || true)"
      echo "[deps] WARN: pip-audit could not reach vulnerability service (offline); skipping."
      if [[ -n "$reason" ]]; then
        echo "[deps] WARN: pip-audit detail: $reason"
      fi
      return 0
    fi
    printf "%s\n" "$output"
    return "$rc"
  }

  set +e
  run_pip_audit
  AUDIT_RC=$?
  set -e
  if [[ "$PIP_AUDIT_FAIL_ON_VULNS" == "1" && "$AUDIT_RC" != "0" ]]; then
    echo "FAIL: pip-audit reported vulnerabilities (treat as P1/P2)."
    exit 11
  fi

  for req in requirements.txt requirements-dev.txt; do
    if [[ -f "$req" ]]; then
      echo "[deps] pip-audit -r $req"
      set +e
      run_pip_audit -r "$req"
      RC=$?
      set -e
      if [[ "$PIP_AUDIT_FAIL_ON_VULNS" == "1" && "$RC" != "0" ]]; then
        echo "FAIL: pip-audit found vulnerabilities in $req (treat as P1/P2)."
        exit 12
      fi
    fi
  done

  echo "OK: Dependency audit policy passed"
else
  echo "[deps] WARN: pip-audit unavailable; skipping dependency audit."
fi

# =========================
# Step: shell/docs quality
# =========================
check_shell_script_syntax

if [[ "$ENABLE_SHELLCHECK_IF_AVAILABLE" == "1" ]]; then
  if have_command shellcheck; then
    shell_files="$(find . -path './.git' -prune -o -type f -name '*.sh' -print)"
    if [[ -n "$shell_files" ]]; then
      echo "[shell] shellcheck"
      # shellcheck disable=SC2086
      shellcheck $shell_files
    else
      echo "[shell] No shell scripts found; skipping shellcheck."
    fi
  elif [[ "$FAIL_ON_MISSING_OPTIONAL_TOOLS" == "1" ]] && find . -path './.git' -prune -o -type f -name '*.sh' -print | grep -q .; then
    echo "FAIL: shellcheck is required in strict mode when shell scripts exist."
    exit 29
  else
    echo "[shell] WARN: shellcheck not installed; skipping shell lint."
  fi
fi

if [[ "$ENABLE_MARKDOWNLINT_IF_AVAILABLE" == "1" ]]; then
  if have_command markdownlint; then
    md_files="$(find . -path './.git' -prune -o -type f -name '*.md' -print)"
    if [[ -n "$md_files" ]]; then
      echo "[docs] markdownlint"
      # shellcheck disable=SC2086
      markdownlint $md_files
    fi
  elif have_command markdownlint-cli2; then
    echo "[docs] markdownlint-cli2"
    markdownlint-cli2 '**/*.md' '#.venv' '#.git'
  elif [[ "$FAIL_ON_MISSING_OPTIONAL_TOOLS" == "1" ]] && find . -path './.git' -prune -o -type f -name '*.md' -print | grep -q .; then
    echo "FAIL: markdownlint is required in strict mode when Markdown files exist."
    exit 30
  else
    echo "[docs] WARN: markdownlint not installed; skipping Markdown style lint."
  fi
fi

echo "[docs] Markdown text sanity"
check_markdown_text

if [[ "$ENABLE_MARKDOWN_LINK_CHECKS" == "1" ]]; then
  echo "[docs] Markdown link check"
  check_markdown_links
fi

if [[ "$ENABLE_CONFIG_SYNTAX_CHECKS" == "1" ]]; then
  echo "[config] syntax check"
  check_config_syntax
fi

run_prompt_checks

# =========================
# Step: tests
# =========================
echo "[tests] strategy coverage"
echo "[tests] unit: $(have_path "$UNIT_TEST_PATH" && echo in scope || echo out of scope)"
echo "[tests] integration: $(have_path "$INTEGRATION_TEST_PATH" && echo in scope || echo out of scope)"
echo "[tests] system: $(have_path "$SYSTEM_TEST_PATH" && echo in scope || echo out of scope)"
echo "[tests] acceptance: $([[ -n "$ACCEPTANCE_TEST_CMD" ]] && echo in scope || echo out of scope)"
echo "[tests] regression: $(have_path "$REGRESSION_TEST_PATH" && echo in scope || echo out of scope)"
echo "[tests] performance/load: $([[ -n "$PERFORMANCE_TEST_CMD" ]] && echo in scope || echo out of scope)"
echo "[tests] usability: $([[ -n "$USABILITY_TEST_CMD" ]] && echo in scope || echo out of scope)"
echo "[tests] security: in scope via bandit, gitleaks, and pip-audit"

if have_tool "pytest"; then
  if have_path "$UNIT_TEST_PATH"; then
    echo "[tests] unit"
    run_pytest_target "unit" "$UNIT_TEST_PATH"
  fi

  if have_path "$INTEGRATION_TEST_PATH"; then
    echo "[tests] integration"
    run_pytest_target "integration" "$INTEGRATION_TEST_PATH"
  fi

  if have_path "$SYSTEM_TEST_PATH"; then
    echo "[tests] system"
    run_pytest_target "system" "$SYSTEM_TEST_PATH"
  fi

  if have_path "$REGRESSION_TEST_PATH"; then
    echo "[tests] regression"
    run_pytest_target "regression" "$REGRESSION_TEST_PATH"
  elif [[ -d "tests" || -f "pytest.ini" || -f "pyproject.toml" || -f "setup.cfg" ]]; then
    echo "[tests] regression (fallback)"
    run_pytest_target "regression (fallback)" "$PYTEST_FALLBACK_TARGET"
  else
    echo "[tests] regression: out of scope (no pytest targets found)"
  fi
else
  echo "[tests] WARN: pytest unavailable; skipping pytest-based test layers."
fi

run_optional_command "acceptance" "$ACCEPTANCE_TEST_CMD"
run_optional_command "performance/load" "$PERFORMANCE_TEST_CMD"
run_optional_command "usability" "$USABILITY_TEST_CMD"

echo "OK: checks passed"
