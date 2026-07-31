---
name: doc-discipline
description: Keep docs in sync with code contracts. Use when creating a new module, changing observable behavior, or writing a feature plan with acceptance criteria.
---

# doc-discipline

## When to use

- Creating a new Python module.
- Changing observable behavior of an existing module (Postconditions changed).
- Writing a feature plan before implementation.

## What to do

### Docstrings are source of truth

The docstring is authoritative. `docs/` files contain human-readable summaries
of module contracts — not implementation details. If docs and docstring
disagree, the docstring wins and the docs are stale.

### New module → new doc file

Create `docs/<area>/<module>.md` with three sections:

1. **Purpose** — one paragraph on the problem this module solves.
2. **Public contract summary** — for each public function, copy the one-liner
   and Postconditions bullets from the docstring.
3. **Usage example** — a minimal, working code snippet.

Example for `src/data/fetchers/naip.py`:

```markdown
## naip.py

Fetches NAIP imagery for a given geometry and writes it to storage.

### fetch_naip(geometry, storage, job_id)
- Returns the storage path of the written GeoTIFF.
- Output covers the bounding box of geometry at highest available NAIP resolution.
- Raises `GEEAuthError` if credentials are missing.

### Usage
storage = LocalStorage(base_dir="/tmp/jobs")
path = fetch_naip(geometry=polygon, storage=storage, job_id="abc123")
```

### Behavior change → docs update

If Postconditions changed, update the docs in the same PR. Stale docs are a bug.

### Feature plan → acceptance criteria file

Before implementing a planned feature:

1. Create `docs/acceptance/<feature>.md`.
2. List each acceptance criterion as a checkbox.
3. Next to each, write the `test_ac_*` test name that will prove it.
4. Mark checkboxes only when the test passes — not when the feature "looks right."

Example `docs/acceptance/job-status-polling.md`:

```markdown
# Acceptance: Job Status Polling

- [ ] `test_ac_job_status_returns_pending_before_start`
- [ ] `test_ac_job_status_returns_running_during_analysis`
- [ ] `test_ac_job_status_returns_complete_with_results`
- [ ] `test_ac_job_status_returns_failed_on_error`
```

## How to verify

- Every module has a matching `docs/<area>/<module>.md`.
- Every public function's Postconditions bullets appear in the docs summary.
- Every acceptance file has a checkbox for every criterion, with a `test_ac_*` name.
- No checkbox is checked without the corresponding test passing.

## Notes

- Pairs with `contract-first-code` (docstring drives docs) and `test-discipline`
  (acceptance file names tests).
