---
description: "Reconnoiter an unfamiliar codebase or module and produce a map. Use when starting work in an unfamiliar repo, before a refactor spanning unfamiliar files, or answering 'where does X live'."
---

Map the target area of the codebase.

1. Clarify the target with one question if ambiguous ("the API layer or the DB layer?").
2. Reconnoitre (use a read-only subagent if available):
   - `git ls-files | head -50` and read the top-level structure.
   - `README.md`, `AGENTS.md`, `package.json` / `pyproject.toml` / `Cargo.toml`.
   - Grep for the target concept: entry points, route registrations, main types.
3. Return a **map**, not a summary:
   - Entry points (file:line).
   - Key types / functions and where they live.
   - Data flow: request → handler → service → store (or equivalent).
   - "If you're changing X, touch these files."
4. Keep it under one screen. Link with `path:line`.

Rules:
- Do not read every file. Stop when the map is coherent.
- Every claim has a file reference; no hand-waving.
- Prefer `grep` + `git ls-files` over recursive reads.
