---
name: test-discipline
description: Every code change requires a test change. Use when writing, modifying, or reviewing Python source. Maps Preconditions/Postconditions bullets to tests and enforces acceptance-criteria naming.
---

# test-discipline

## When to use

- Writing or modifying any Python function.
- Reviewing a diff that changes behavior.
- Closing out a planned feature (all `test_ac_*` must pass).

## What to do

### Every change requires a test change

If you write or modify a function, you also write or update its test file. Not
optional.

### Tests mirror source tree

```
src/core/analyzer.py          →  tests/core/test_analyzer.py
src/data/fetchers/naip.py     →  tests/data/fetchers/test_naip.py
src/platform/job_store.py     →  tests/platform/test_job_store.py
```

Every `tests/` subdirectory has an `__init__.py`.

### What to test

For every function with a Preconditions/Postconditions docstring:

**Postconditions proof** — one test per bullet, asserting the guarantee holds:

```python
def test_clip_to_zone_returns_subset_of_input():
    clipped = clip_to_zone(geometry, zone_radius_m=100)
    assert clipped.within(geometry)
```

**Preconditions violation** — one test per bullet, asserting the documented
exception is raised:

```python
def test_clip_to_zone_raises_for_nonpositive_radius():
    with pytest.raises(ValueError, match="zone_radius_m"):
        clip_to_zone(geometry, zone_radius_m=0)
```

**No bullet is "done" until it has a test.**

### Acceptance criteria tests

When implementing a planned feature:

1. Each acceptance criterion becomes one test.
2. Name: `test_ac_<feature>_<criterion>` (e.g.
   `test_ac_job_status_returns_running_while_processing`).
3. Decorate with `@pytest.mark.acceptance`.
4. Body encodes the exact acceptance statement: "Given X, when Y, assert Z."
5. Feature is not complete until every `test_ac_*` passes.

Example:

```python
@pytest.mark.acceptance
def test_ac_send_geometry_returns_job_id_immediately():
    """AC: POST /send-geometry returns a job_id without waiting for analysis."""
    response = client.post("/send-geometry", json=valid_payload)
    assert response.status_code == 202
    assert "job_id" in response.json()
```

### Test naming

| Test type | Pattern |
|---|---|
| Normal behavior | `test_<function>_<scenario>` |
| Precondition violation | `test_<function>_raises_for_<condition>` |
| Acceptance criterion | `test_ac_<feature>_<criterion>` |

### Running

```
pytest tests/
pytest tests/ -m acceptance          # acceptance tests only
pytest tests/ -m "not acceptance"    # unit/integration only
```

## How to verify

- Every Preconditions/Postconditions bullet in changed code has a matching test.
- Every acceptance criterion in `docs/acceptance/<feature>.md` has a passing
  `test_ac_*` test.
- `pytest tests/` passes.
- Never bypass pre-commit hooks (`--no-verify` is not allowed).

## Notes

- Pairs with `contract-first-code` (bullets to prove) and `doc-discipline`
  (acceptance file lists tests).
