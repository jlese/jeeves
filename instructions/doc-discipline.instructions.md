---
description: "Keep docs in sync with code contracts. Docstrings are source of truth, docs/ summarizes contracts, feature plans list acceptance-criteria test names."
applyTo: "**/*.py"
---

# Documentation Discipline

## Source of truth

The docstring is authoritative. `docs/` contains human-readable summaries of
module contracts — never implementation details. If they disagree, the
docstring wins and docs are stale.

## New module → new doc file

Create `docs/<area>/<module>.md` with:

1. **Purpose** — one paragraph on the problem this module solves.
2. **Public contract summary** — for each public function, the one-liner and
   Postconditions bullets copied from the docstring.
3. **Usage example** — a minimal, working code snippet.

## Behavior change → docs update

If Postconditions changed, update `docs/` in the same PR. Stale docs are a bug.

## Feature plans → acceptance criteria

Before implementation:

1. Create `docs/acceptance/<feature>.md`.
2. List each acceptance criterion as a checkbox.
3. Next to each, write the `test_ac_*` test name that will prove it.
4. Check the box only when the test passes — never when the feature "looks right."

Example:

```markdown
# Acceptance: Job Status Polling

- [ ] `test_ac_job_status_returns_pending_before_start`
- [ ] `test_ac_job_status_returns_running_during_analysis`
- [ ] `test_ac_job_status_returns_complete_with_results`
- [ ] `test_ac_job_status_returns_failed_on_error`
```
