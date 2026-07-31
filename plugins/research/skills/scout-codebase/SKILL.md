---
name: scout-codebase
description: Send a subagent to reconnoiter an unfamiliar codebase or module and report back a map. Use when the user asks "where does X live", "how does Y work in this repo", or before a non-trivial change in unfamiliar code.
---

# scout-codebase

## When to use

- Starting work in an unfamiliar repo or module.
- Before a refactor that spans files the user hasn't read.
- User asks "how does this app do X" or "where is Y wired up".

## What to do

1. Clarify the target with one question if ambiguous ("the API layer or the DB layer?").
2. Dispatch a read-only subagent (or, if none available, work sequentially):
   - Run `git ls-files | head -50` and read the top-level structure.
   - `README.md`, `AGENTS.md`, `package.json` / `pyproject.toml` / `Cargo.toml`.
   - Grep for the target concept: entry points, route registrations, main types.
3. Produce a **map**, not a summary:
   - Entry points (files + line numbers).
   - Key types / functions and where they live.
   - Data flow: request → handler → service → store (or equivalent).
   - "If you're changing X, touch these files" list.
4. Keep it under one screen. Link to files with `path:line`.

## How to verify

- User can navigate to any listed file:line and see what you described.
- Every claim has a file reference; no hand-waving.

## Notes

- Do not read every file. Stop when the map is coherent.
- Prefer `grep` + `git ls-files` over recursive reads.
