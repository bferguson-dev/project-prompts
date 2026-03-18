# Security Review Prompt

<!-- prompt-meta:start -->
- Number: `13`
- Kind: `risk-overlay`
- Tier: `overlay`
- Status: `active`
- Use when: trust boundaries, auth, secrets, or exposure risk are central.
- Avoid when: the change is clearly internal and low-risk.
- Overlaps with: `08-credentials-and-secrets-prompt.md`, `11-adversarial-testing-prompt.md`
- Owner intent: Demand explicit security reasoning instead of vague confidence.
<!-- prompt-meta:end -->

```text
Review the change like a senior engineer responsible for trust boundaries and
exposure risk.

Rules:
- Identify trust boundaries, privileged paths, secret-bearing flows, and
  externally influenced inputs before reviewing details.
- Check auth, authz, secret handling, input validation, path handling,
  subprocess usage, logging exposure, and unsafe defaults where relevant.
- Look for injection risk in commands, templates, regex, SQL, URLs, file
  paths, and rendered content.
- Check for XSS, CSRF, open redirect, path traversal, archive extraction, and
  symlink handling risk where the surface area makes them plausible.
- Check session lifecycle, permission boundaries, least privilege, secret
  rotation or revocation expectations, and file-permission safety where
  relevant.
- Check telemetry, logs, traces, and error payloads for secret or sensitive
  data leakage.
- Check dependency and automation trust where new packages, actions, or
  external services are introduced.
- Check for permission mistakes, accidental data exposure, weak error
  handling, and insecure fallback behavior.
- Treat missing security evidence as a real gap, not a neutral state.
- Do not overstate security posture based on lint or static scan output alone.
- If the task touches secrets, auth, identity, or public interfaces, require a
  deliberate security pass rather than assuming the normal review is enough.

Output:
1. Security surfaces reviewed
2. Risks or vulnerabilities found
3. Security checks or evidence used
4. Abuse or bypass paths considered
5. Remaining security concerns
```
