---
description: "Enforce contract-first Python. Preconditions/Postconditions in the docstring before the body, hard limits on size and complexity."
applyTo: "**/*.py"
---

# Contract-First Python

## Contract before body

Before writing the function body, write:

```python
def function_name(param: Type) -> ReturnType:
    """One-line summary of what this function does (not how).

    Preconditions:
        - <what must be true about each input>
        - <any state the function depends on>

    Postconditions:
        - <what the return value guarantees>
        - <what side effects occur, if any>
        - (max 3 bullets — if you need more, split the function)

    Args:
        param: Description and type constraints.

    Returns:
        Description of the return value.

    Raises:
        ValueError: When <specific condition>.
    """
```

If Postconditions exceed 3 bullets, split the function. Do not raise the limit.

## Hard limits

| Constraint | Limit |
|---|---|
| Function body lines | 60 (docstring excluded) |
| Cyclomatic complexity (C901) | 8 |
| Nesting depth | 3 |
| Postconditions bullets | 3 |

Exceeding a limit is a design signal, not a ceiling to negotiate. Extract helpers.

## Also

- Single responsibility: function does exactly what its Postconditions state. If
  the name doesn't match, rename.
- Full type annotations on every public signature.
- Private helpers (`_name`) need one-liner + Preconditions/Postconditions when
  they encode non-obvious logic.
- No `# noqa` without a comment explaining why the specific rule doesn't apply.
