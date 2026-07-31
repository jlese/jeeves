# AGENTS.md — Jeeves

Conventions for agents working in this repo. Follows [agents.md](https://agents.md/).

## What this repo is

A personal library of Claude Code / Codex / Cursor skills, subagents, and
commands. Every unit is Markdown. No build step. No runtime.

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
