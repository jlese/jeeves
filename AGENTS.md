# AGENTS.md — Jeeves

Conventions for agents working in this repo. Follows [agents.md](https://agents.md/).

## What this repo is

A personal library of Claude Code / Codex / Cursor skills, subagents, and
commands. Every unit is Markdown. No build step. No runtime.

## Universal principles (apply to every skill and to code any Jeeves-installed agent writes)

Distilled from the `discipline` plugin. Apply everywhere.

1. **Contract first.** State what a unit guarantees before writing its body.
   For code: Preconditions/Postconditions in the docstring. For a skill:
   "when to use" and "how to verify" in `SKILL.md`.
2. **Single responsibility.** If a unit guarantees more than three things, split it.
3. **Docs summarize contracts; contracts live at the source.** Docstring is
   truth for code. `SKILL.md` frontmatter is truth for skills.
4. **Every guarantee has a proof.** Code: a test per Postconditions bullet.
   Skill: a verifiable step in "how to verify".
5. **Limits are design signals, not ceilings.** 60-line functions, 3-level
   nesting, ~300-line skills. Exceeded = split, not raise.
6. **No silent bypasses.** No `# noqa` without justification. No `--no-verify`.
   No suppressed lints. No skipped tests without an issue link.
7. **Assistant tone.** Blunt, point out bad assumptions and likely bugs. Do not
   just agree. Plain text in terminal instructions unless code is being written.

Agents working on a Python codebase should invoke `discipline/contract-first-code`,
`discipline/doc-discipline`, and `discipline/test-discipline` for the full rules.

## Commands

- `./scripts/new-skill.sh <plugin> <skill-name>` — scaffold a new skill from
  `templates/SKILL.md.tmpl`.
- `./scripts/validate.sh` — lint YAML frontmatter and cross-links in every
  `SKILL.md`. Run before committing.
- `make new-skill PLUGIN=<p> NAME=<n>` and `make validate` — same, via Make.

## Style

- **Skills**: one folder per skill under `plugins/<plugin>/skills/<name>/`.
  Each has a `SKILL.md` with YAML frontmatter (`name`, `description` only).
  Body is: **when to use**, **what to do**, **how to verify**. Keep under
  ~300 lines; put long references in sibling files.
- **Subagents**: single Markdown file under `plugins/<plugin>/agents/`.
  Frontmatter: `name`, `description`, `tools` (least-privilege), `model`
  (`opus` / `sonnet` / `haiku` / `inherit`).
- **Commands**: single Markdown file under `plugins/<plugin>/commands/`.
  Invoked as `/<plugin>:<name>`.
- **Voice**: direct, terse, no filler. Match how a good pair-programmer talks.
- **No emojis** in skill bodies.
- **No MCP** unless a task genuinely can't be done via CLI + skill.

## How to run a task

There are no runnable programs here. To use a skill:

1. Install the plugin (see [README.md](README.md)) or symlink `skills/` into
   `~/.claude/skills/`.
2. In your agent session, ask the task; the harness auto-discovers the skill
   by matching your prompt against the `description` frontmatter.

## Adding a new plugin

1. `mkdir -p plugins/<name>/{skills,commands,agents}`
2. Copy `templates/plugin.json.tmpl` to `plugins/<name>/.claude-plugin/plugin.json`.
3. Add the plugin to `.claude-plugin/marketplace.json`.
4. Add at least one skill via `./scripts/new-skill.sh`.
5. `./scripts/validate.sh`.

## What not to do

- Don't add tests, CI, or a package.json. This repo is Markdown.
- Don't add per-language plugins (`python`, `typescript`). Group by
  situation (`git-flow`, `writing`, `research`) — situations are what you
  install, languages are what you already have.
- Don't invent new frontmatter fields. If Claude Code / agents.md don't
  document it, don't use it.
- Don't commit anything from `~/.claude/` (secrets, session state).
