---
name: conventional-commits
description: Write a Conventional Commits message from a staged diff. Use when the user asks to "commit", "write a commit message", or after making changes ready to be committed.
---

# conventional-commits

## When to use

- User has staged changes and wants a commit message.
- User asks for a "conventional commit" or references `feat:` / `fix:` style.

## What to do

1. Run `git diff --staged` (or `git diff` if nothing is staged) and read the changes.
2. Pick the type: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `perf`, `build`, `ci`, `style`.
3. Pick a scope if one clearly applies (single package/module name in `kebab-case`).
4. Write the subject: imperative mood, no trailing period, ≤ 72 chars.
   Format: `<type>(<scope>): <subject>` — omit `(<scope>)` if none.
5. If the change is non-trivial, add a blank line then a body: what + why, not how.
6. If it's a breaking change, add `BREAKING CHANGE: <description>` in the footer.
7. Show the message to the user before running `git commit`.

## How to verify

- Subject ≤ 72 chars, lowercase after the colon, imperative.
- Body wrapped at 72 chars.
- `git log --oneline -1` shows the expected line after commit.
