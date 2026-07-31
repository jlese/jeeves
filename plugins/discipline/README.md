# discipline

Portable code-quality rules for any project. Language-focused: Python (but the
philosophy — contracts, docs, tests — is language-agnostic).

## Skills

- `contract-first-code` — write Preconditions/Postconditions before the body,
  enforce size and complexity limits.
- `doc-discipline` — docstrings are source of truth; `docs/` summarizes contracts.
- `test-discipline` — every contract bullet has a test; acceptance criteria are
  named tests (`test_ac_*`).

## When to install

Install into any repo where you want agents to follow contract-first / TDD /
docs-as-truth conventions. The three skills reference each other and are
designed to be used together.
