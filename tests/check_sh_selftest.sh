#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
VENV_TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR" "$VENV_TMP_DIR"' EXIT

cp "$REPO_DIR/check.sh" "$TMP_DIR/check.sh"
cp "$REPO_DIR/tests/fixtures/check-sh/valid.json" "$TMP_DIR/config.json"
cp "$REPO_DIR/tests/fixtures/check-sh/valid.yaml" "$TMP_DIR/config.yaml"
cp "$REPO_DIR/tests/fixtures/check-sh/valid.toml" "$TMP_DIR/config.toml"
cat >"$TMP_DIR/README.md" <<'EOF'
# check.sh self-test
EOF

git -C "$TMP_DIR" init -b main >/dev/null
git -C "$TMP_DIR" config user.name "selftest"
git -C "$TMP_DIR" config user.email "selftest@example.invalid"
git -C "$TMP_DIR" add .

(
  cd "$TMP_DIR"
  VENV_DIR="$VENV_TMP_DIR/primary-venv" \
  ENABLE_SHELLCHECK_IF_AVAILABLE=0 \
  ENABLE_MARKDOWNLINT_IF_AVAILABLE=0 \
  FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS=0 \
  RUN_GIT_SECRETS_HISTORY=0 \
  RUN_PROMPT_CHECKS=0 \
  ./check.sh >/dev/null
)

cat >"$TMP_DIR/config.json" <<'EOF'
{
  "name": "broken",
EOF
git -C "$TMP_DIR" add config.json

set +e
(
  cd "$TMP_DIR"
  VENV_DIR="$VENV_TMP_DIR/primary-venv" \
  ENABLE_SHELLCHECK_IF_AVAILABLE=0 \
  ENABLE_MARKDOWNLINT_IF_AVAILABLE=0 \
  FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS=0 \
  RUN_GIT_SECRETS_HISTORY=0 \
  RUN_PROMPT_CHECKS=0 \
  ./check.sh >/dev/null 2>&1
)
rc=$?
set -e

if [[ "$rc" == "0" ]]; then
  echo "FAIL: check.sh accepted invalid JSON during self-test."
  exit 1
fi

if ! command -v shellcheck >/dev/null 2>&1 && ! command -v markdownlint >/dev/null 2>&1 && ! command -v markdownlint-cli2 >/dev/null 2>&1; then
  cat >"$TMP_DIR/test.sh" <<'EOF'
#!/usr/bin/env bash
echo strict
EOF
  chmod +x "$TMP_DIR/test.sh"
  git -C "$TMP_DIR" add test.sh

  set +e
  (
    cd "$TMP_DIR"
    VENV_DIR="$VENV_TMP_DIR/strict-venv" \
    ENABLE_SHELLCHECK_IF_AVAILABLE=1 \
    ENABLE_MARKDOWNLINT_IF_AVAILABLE=1 \
    FAIL_ON_MISSING_OPTIONAL_TOOLS=1 \
    FAIL_ON_SUSPICIOUS_STAGED_ARTIFACTS=0 \
    RUN_GIT_SECRETS_CACHED=0 \
    RUN_GIT_SECRETS_HISTORY=0 \
    RUN_PROMPT_CHECKS=0 \
    ./check.sh >/dev/null 2>&1
  )
  strict_rc=$?
  set -e

  if [[ "$strict_rc" == "0" ]]; then
    echo "FAIL: check.sh strict mode did not fail when shell/docs tools were missing."
    exit 1
  fi
fi

echo "OK: check.sh self-test passed"
