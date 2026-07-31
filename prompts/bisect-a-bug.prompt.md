---
description: "Run git bisect to find the commit that introduced a regression. Use when a test or behavior worked before and is broken now."
argument-hint: "Known-good SHA and check command..."
---

Bisect the regression:

1. Confirm the check command with the user. Example: `pytest tests/test_x.py::test_y`.
2. Confirm the good commit (`<good-sha>`) and bad commit (default `HEAD`).
3. Start:
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

Notes:
- Flaky check → `git bisect skip` for uncertain commits.
- Build-only regression → wrap: `sh -c 'make && ./check'`.
