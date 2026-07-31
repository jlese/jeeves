---
description: Stage, commit with a Conventional Commit message, push, and open a PR.
---

# /git-flow:ship

Full ship pipeline. Assumes you're on a feature branch with uncommitted changes.

1. `git status` — confirm the working tree state with the user.
2. `git add -A` unless the user specified paths.
3. Invoke the `conventional-commits` skill to produce a message; confirm with user.
4. `git commit -m "<message>"`.
5. `git push -u origin HEAD`.
6. Invoke the `pr-writeup` skill; confirm with user.
7. `gh pr create --title "<title>" --body "<body>"` if `gh` is available; otherwise
   print the URL from `git push` output and the body for manual paste.
