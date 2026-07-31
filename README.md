# Jeeves

Personal marketplace of reusable Copilot customizations — instructions, prompts,
custom agents, and skills. Aimed at Claude in GitHub Copilot (VS Code), but the
files work in any harness that consumes the same Markdown formats.

Named after the butler — quiet, competent, remembers what you like.

## Layout

```
instructions/  *.instructions.md   scoped guidelines (applyTo globs)
prompts/       *.prompt.md         slash-command tasks
agents/        *.agent.md          custom subagents
skills/        <name>/SKILL.md     multi-step workflows with bundled assets
templates/     *.tmpl              copy-paste starters
scripts/       install / validate  install and lint helpers
```

## Install

### Once per machine (user profile — roams via Settings Sync)

```
git clone https://github.com/jlese/jeeves ~/jeeves
~/jeeves/scripts/install-user.sh
```

Symlinks every `*.prompt.md`, `*.instructions.md`, `*.agent.md` into
`~/Library/Application Support/Code/User/prompts/` and every skill into
`~/.copilot/skills/`. Re-run any time to resync.

### Per repo (project-scoped `.github/`)

```
~/jeeves/scripts/install-workspace.sh ~/path/to/repo         # symlink
~/jeeves/scripts/install-workspace.sh ~/path/to/repo --copy  # independent copies
```

Populates `.github/{prompts,instructions,agents,skills}/`. Also seeds a starter
`AGENTS.md` if the repo doesn't have one.

## What's included

### Instructions (`applyTo: **/*.py`)

- `contract-first-code` — Preconditions/Postconditions in the docstring before
  the body, 60-line function limit, complexity ≤ 8.
- `doc-discipline` — docstrings are source of truth; `docs/` summarizes contracts.
- `test-discipline` — every contract bullet has a test; `test_ac_*` for
  acceptance criteria.

### Prompts

- `/conventional-commit` — Conventional Commit from a staged diff.
- `/pr-writeup` — PR title + body from a branch diff.
- `/ship` — full stage → commit → push → PR pipeline.
- `/bisect-a-bug` — guided `git bisect`.
- `/scout-codebase` — recon an unfamiliar area, return a file:line map.

### Agents

- `code-reviewer` — read-only pre-PR reviewer, ranks findings blocker/warning/nit.

### Skills

- 14 SDLC skills vendored from [obra/superpowers](https://github.com/obra/superpowers)
  (planning, brainstorming, debugging, TDD, code review, worktrees). MIT.
  See [NOTICE](NOTICE) for attribution.

## Adding a new customization

```
./scripts/new.sh prompt       my-task
./scripts/new.sh instructions my-lang-rules
./scripts/new.sh agent        my-specialist
./scripts/new.sh skill        my-workflow
```

Edit, then `./scripts/validate.sh` before pushing.

## Recommended companions (not bundled)

- **[ccusage](https://github.com/ryoppippi/ccusage)** — spend visibility
  (`npx ccusage@latest`).
- **[caveman](https://github.com/gnomeba/caveman)** — aggressive context
  compression if you're brushing token limits.

## Conventions

See [AGENTS.md](AGENTS.md).
