#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

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
  ENABLE_SHELLCHECK_IF_AVAILABLE=0 \
  ENABLE_MARKDOWNLINT_IF_AVAILABLE=0 \
  RUN_GIT_SECRETS_HISTORY=0 \
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
  ENABLE_SHELLCHECK_IF_AVAILABLE=0 \
  ENABLE_MARKDOWNLINT_IF_AVAILABLE=0 \
  RUN_GIT_SECRETS_HISTORY=0 \
  ./check.sh >/dev/null 2>&1
)
rc=$?
set -e

if [[ "$rc" == "0" ]]; then
  echo "FAIL: check.sh accepted invalid JSON during self-test."
  exit 1
fi

echo "OK: check.sh self-test passed"
