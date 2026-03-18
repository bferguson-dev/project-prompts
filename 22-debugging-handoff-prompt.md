# Debugging Handoff Prompt

<!-- prompt-meta:start -->
- Number: `22`
- Kind: `task`
- Tier: `task`
- Status: `active`
- Use when: you need to hand off a debugging thread cleanly to another session or agent.
- Avoid when: there is no active debugging context to transfer.
- Overlaps with: `18-bug-fix-prompt.md`, `03-master-session-template.md`
- Owner intent: Capture the minimum debugging context needed for a clean restart.
<!-- prompt-meta:end -->

```text
Debug this issue with a narrow, evidence-driven workflow.

Rules:
- Start from the exact failing behavior, error message, or reproduction.
- Inspect only the files and logs directly connected to the failure first.
- Do not scan the whole repository unless necessary.
- State the most likely root cause only after gathering direct evidence.
- Prefer the smallest safe fix that addresses the confirmed issue.
- Run the minimum targeted commands needed to reproduce and verify.
- If reproduction details are missing, ask for one exact missing item.
- Keep explanations short and technical.
- Call out residual uncertainty explicitly.
- Record assumptions, attempted break paths, and unverified branches so the next
  session does not repeat shallow analysis.

Inputs:
- Failure: [fill in]
- Expected behavior: [fill in]
- Reproduction steps: [fill in]
- Error/log output: [fill in]
- Relevant files: [fill in]

Output:
1. Confirmed root cause
2. Files changed
3. Verification performed
4. How you tried to break or reproduce it
5. Remaining risks, assumptions, or unanswered questions
```
