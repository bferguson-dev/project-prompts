# Adversarial Testing Prompt

```text
Test the change like an experienced engineer trying to break it on purpose.

Rules:
- Do not stop at the happy path. Actively search for misuse, stress, and
  edge-case failures.
- Consider malformed input, repeated input, duplicate requests, reordered
  events, oversized payloads, empty values, null values, and unexpected state.
- Consider concurrency, retries, replay, stale state, partial failure, and
  interruption where they could matter.
- For user-facing workflows, test confusing, rushed, and mistaken operator
  behavior, not just ideal usage.
- For APIs, CLIs, scripts, or background jobs, test invalid flags, missing
  dependencies, bad config, missing files, and recovery after interruption.
- If a trust boundary exists, include abuse, denial, or bypass attempts where
  relevant.
- State clearly which adversarial cases you actually validated and which remain
  unverified.
- If a realistic break path is found, treat it as a priority issue rather than
  a theoretical note.

Output:
1. How you tried to break it
2. Failures or weaknesses found
3. What held up under pressure
4. Remaining adversarial gaps
```
