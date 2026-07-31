---
description: "Every code change requires a test change. Map Preconditions/Postconditions bullets to tests, use test_ac_* for acceptance criteria."
applyTo: "**/*.py"
---

# Test Discipline

## Every change requires a test change

If you write or modify a function, write or update its test file. Not optional.

## Tests mirror source tree

```
src/core/analyzer.py       →  tests/core/test_analyzer.py
src/data/fetchers/naip.py  →  tests/data/fetchers/test_naip.py
```

Every `tests/` subdirectory has an `__init__.py`.

## What to test

For every function with a Preconditions/Postconditions docstring:

**Postconditions proof** — one test per bullet:

```python
def test_clip_to_zone_returns_subset_of_input():
    clipped = clip_to_zone(geometry, zone_radius_m=100)
    assert clipped.within(geometry)
```

**Preconditions violation** — one test per bullet asserting the documented exception:

```python
def test_clip_to_zone_raises_for_nonpositive_radius():
    with pytest.raises(ValueError, match="zone_radius_m"):
        clip_to_zone(geometry, zone_radius_m=0)
```

No bullet is "done" until it has a test.

## Acceptance criteria tests

1. Each acceptance criterion = one test.
2. Name: `test_ac_<feature>_<criterion>`.
3. Decorate `@pytest.mark.acceptance`.
4. Encode the exact statement: given X, when Y, assert Z.
5. Feature is not complete until every `test_ac_*` passes.

```python
@pytest.mark.acceptance
def test_ac_send_geometry_returns_job_id_immediately():
    response = client.post("/send-geometry", json=valid_payload)
    assert response.status_code == 202
    assert "job_id" in response.json()
```

## Naming

| Test type | Pattern |
|---|---|
| Normal behavior | `test_<function>_<scenario>` |
| Precondition violation | `test_<function>_raises_for_<condition>` |
| Acceptance criterion | `test_ac_<feature>_<criterion>` |

## Running

```
pytest tests/
pytest tests/ -m acceptance          # acceptance only
pytest tests/ -m "not acceptance"    # unit/integration
```

Never bypass pre-commit hooks (`--no-verify` is not allowed).
