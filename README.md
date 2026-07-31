# Jeeves

Personal marketplace of reusable agent skills, subagents, and slash commands.
Named after the butler — quiet, competent, remembers what you like.

Portable across Claude Code, Codex CLI, Cursor, Gemini CLI (everything's just
Markdown). Primary target is Claude Code's plugin marketplace format.

## Install (Claude Code)

```
/plugin marketplace add <owner>/jeeves
/plugin install git-flow@jeeves
/plugin install research@jeeves
```

## Install (other harnesses / manual)

```
git clone https://github.com/<owner>/jeeves ~/jeeves
ln -s ~/jeeves/plugins/git-flow/skills  ~/.claude/skills/git-flow
ln -s ~/jeeves/plugins/research/skills  ~/.claude/skills/research
```

## Recommended companions

- **[obra/superpowers](https://github.com/obra/superpowers)** — SDLC skills
  (planning, brainstorming, debugging, refactoring). Drop in `~/.claude/skills/`.
- **[ccusage](https://github.com/ryoppippi/ccusage)** — spend visibility
  (`npx ccusage@latest` or install globally).
- **[caveman](https://github.com/gnomeba/caveman)** — aggressive context
  compression. Optional; add if you're brushing token limits.

## Layout

```
.claude-plugin/marketplace.json    # marketplace manifest
plugins/<name>/                     # one plugin per situation
  .claude-plugin/plugin.json
  skills/<skill>/SKILL.md
  commands/<name>.md
  agents/<name>.md
templates/                          # copy-paste starters
snippets/                           # non-skill prompts
scripts/                            # new-skill, validate
```

## Adding a skill

```
./scripts/new-skill.sh <plugin> <skill-name>
```

Then edit the generated `SKILL.md`. Run `./scripts/validate.sh` before pushing.

## Conventions

See [AGENTS.md](AGENTS.md).
