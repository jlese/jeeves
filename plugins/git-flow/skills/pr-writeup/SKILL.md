---
name: pr-writeup
description: Turn a branch diff into a PR title and description. Use when the user asks to "open a PR", "write a PR description", or is about to push a branch.
---

# pr-writeup

## When to use

- Branch is ready to push and needs a PR title/body.
- User asks for a "PR description" or "changelog entry" for a branch.

## What to do

1. Determine the base branch: `git merge-base --fork-point main HEAD` or ask.
2. Read the diff: `git log --oneline <base>..HEAD` and `git diff <base>...HEAD`.
3. Title: same style as a Conventional Commit subject (`<type>(<scope>): <subject>`).
4. Body, in this order:
   - **What** — one paragraph, plain language.
   - **Why** — one paragraph. Link the issue or context if known.
   - **How to verify** — commands or steps a reviewer can run.
   - **Risk / rollback** — one line each, only if non-trivial.
5. If `gh` is installed and the user confirms: `gh pr create --title "..." --body "..."`.
   Otherwise print the title and body for the user to paste.

## How to verify

- Title parses as a Conventional Commit.
- Body has all four sections when non-trivial, only What+Why when trivial.
- `gh pr view` shows the created PR (if created via `gh`).
