---
description: "Stage, write a Conventional Commit, push, and open a PR. Full ship pipeline for a feature branch."
---

Ship the current branch:

1. `git status` — confirm working tree state with the user.
2. `git add -A` unless the user specifies paths.
3. Run the `conventional-commit` prompt to produce a message; confirm with user.
4. `git commit -m "<message>"`.
5. `git push -u origin HEAD`.
6. Run the `pr-writeup` prompt; confirm with user.
7. `gh pr create --title "<title>" --body "<body>"` if `gh` is available;
   otherwise print the URL from `git push` output and the body for manual paste.
