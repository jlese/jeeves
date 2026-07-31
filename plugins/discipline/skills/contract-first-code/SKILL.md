---
name: contract-first-code
description: Enforce contract-first Python development. Use when writing, reviewing, or modifying any Python function, method, or module. Requires Preconditions/Postconditions in the docstring before the body, and enforces size and complexity limits.
---

# contract-first-code

## When to use

- Writing a new Python function, method, or class.
- Modifying an existing function's behavior.
- Reviewing a diff that touches Python source.

## What to do

1. **Write the docstring first.** Before the function body, write:

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

2. **If Postconditions exceeds 3 bullets, split the function.** Do not raise the
   limit. A function that guarantees more than three things does more than one thing.

3. **Enforce hard limits:**

   | Constraint | Limit |
   |---|---|
   | Function body lines | 60 (docstring excluded) |
   | Cyclomatic complexity (C901) | 8 |
   | Nesting depth | 3 |
   | Postconditions bullets | 3 |

   When exceeded, extract helpers. A limit exceeded is a design signal, not a
   ceiling to negotiate.

4. **Single responsibility.** The function does exactly what its Postconditions
   state. If the name doesn't match the Postconditions, rename it.

5. **Type annotations.** Full annotations on all public function signatures.
   Private helpers annotate any non-obvious types.

6. **Private helpers (`_name`)** need at minimum a one-liner plus
   Preconditions/Postconditions if they encode non-obvious logic.

7. **No blanket lint suppressions.** `# noqa` requires a comment explaining
   why the specific rule doesn't apply.

## How to verify

- Every public function has a docstring with `Preconditions:` and `Postconditions:` sections.
- `ruff check --select=C901,PLR --statistics` reports no violations for changed files.
- Function bodies are ≤ 60 lines (docstring excluded).
- Postconditions bullets are ≤ 3 per function.
- Every bullet has a corresponding test (see `test-discipline`).

## Notes

- These rules are non-negotiable per change. Do not request an exception.
- Rules pair with `doc-discipline` and `test-discipline` — the docstring feeds both.
