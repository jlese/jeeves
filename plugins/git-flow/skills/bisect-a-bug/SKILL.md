---
name: bisect-a-bug
description: Run `git bisect` to find the commit that introduced a regression. Use when the user says a test or behavior worked before and is broken now, and wants to find the offending commit.
---

# bisect-a-bug

## When to use

- A regression exists: known-good commit + known-bad commit (usually HEAD).
- The user has a repeatable check (a command that exits 0 if good, non-zero if bad).

## What to do

1. Confirm the check command with the user. Example: `pytest tests/test_x.py::test_y`.
2. Confirm the good commit (`<good-sha>`) and bad commit (default `HEAD`).
3. Start bisect:
   ```
   git bisect start
   git bisect bad
   git bisect good <good-sha>
   ```
4. Automate if the check is scriptable:
   ```
   git bisect run <check-command>
   ```
   Otherwise step manually: run the check, then `git bisect good` or `git bisect bad`.
5. When bisect reports the first bad commit, `git show <sha>` and summarize the change.
6. `git bisect reset` to return to the original branch.

## How to verify

- `git bisect log` shows a clean sequence ending in "first bad commit: <sha>".
- Reverting or fixing that commit makes the check pass.

## Notes

- If the check is flaky, use `git bisect skip` for uncertain commits.
- For build-only regressions, wrap the check: `sh -c 'make && ./check'`.
