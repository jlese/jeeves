---
description: "Write a Conventional Commit message from a staged diff. Use when the user asks to commit, write a commit message, or after making changes ready to be committed."
argument-hint: "Optional scope hint..."
---

Write a Conventional Commit message for the current staged changes.

1. Run `git diff --staged` (or `git diff` if nothing is staged) and read the changes.
2. Pick a type: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `perf`, `build`, `ci`, `style`.
3. Pick a scope only if one clearly applies (single package/module name in kebab-case).
4. Write the subject: imperative mood, no trailing period, ≤ 72 chars.
   Format: `<type>(<scope>): <subject>` — omit `(<scope>)` if none.
5. If non-trivial, add a blank line then a body: what + why, not how (wrapped at 72 chars).
6. For breaking changes, add `BREAKING CHANGE: <description>` in the footer.
7. Show the message to the user before running `git commit`.

Do not commit until the user confirms.
