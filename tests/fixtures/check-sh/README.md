# `check.sh` Self-Test Fixture

These fixture files exist so `tests/check_sh_selftest.sh` can regression-test
the config syntax checks in `check.sh`.

The fixture currently proves:

- valid JSON passes
- valid YAML passes
- valid TOML passes
- intentionally broken JSON is rejected
