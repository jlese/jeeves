---
description: "Turn a branch diff into a PR title and description. Use when opening a PR, writing a PR description, or about to push a branch."
---

Produce a PR title and body for the current branch.

1. Determine the base branch: `git merge-base --fork-point main HEAD` or ask.
2. Read the diff: `git log --oneline <base>..HEAD` and `git diff <base>...HEAD`.
3. Title: Conventional Commit style — `<type>(<scope>): <subject>`.
4. Body sections, in order:
   - **What** — one paragraph, plain language.
   - **Why** — one paragraph. Link the issue or context if known.
   - **How to verify** — commands or steps a reviewer can run.
   - **Risk / rollback** — one line each, only if non-trivial.
5. If `gh` is installed and the user confirms: `gh pr create --title "..." --body "..."`.
   Otherwise print the title and body for the user to paste.
