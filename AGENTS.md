# AGENTS.md — Jeeves

Conventions for agents working in this repo. Follows [agents.md](https://agents.md/).

## What this repo is

A personal library of Copilot customizations — instructions, prompts, custom
agents, and skills. Primary target: Claude in GitHub Copilot (VS Code). Every
unit is Markdown with YAML frontmatter. No build step, no runtime.

## Universal principles

Apply to every file in this repo *and* to any code an installed agent writes.

1. **Contract first.** State what a unit guarantees before writing its body.
   Code: Preconditions/Postconditions in the docstring. Customization: `description`
   frontmatter with trigger keywords.
2. **Single responsibility.** If a unit guarantees more than three things, split it.
3. **Description is the discovery surface.** For prompts/instructions/agents/skills,
   the `description` field is how the agent finds it. Include the trigger words
   users will actually say ("Use when...").
4. **Every guarantee has a proof.** Code: a test per Postconditions bullet. Skill:
   a verifiable step in "How to verify".
5. **Limits are design signals, not ceilings.** 60-line functions, 3-level nesting,
   ~300-line skills. Exceeded = split, not raise.
6. **No silent bypasses.** No `# noqa` without a comment. No `--no-verify`. No
   suppressed lints. No skipped tests without a link.
7. **Blunt tone.** Point out bad assumptions and likely bugs, don't just agree.
   Plain text in terminal instructions.

The `instructions/` files carry the Python-specific enforcement. Non-Python
projects still inherit rules 1–7.

## Commands

- `./scripts/new.sh <kind> <name>` — scaffold from templates. `kind`: `prompt`,
  `instructions`, `agent`, `skill`.
- `./scripts/validate.sh` — lint frontmatter in every file. Run before committing.
- `./scripts/install-user.sh` — install into VS Code user profile (idempotent).
- `./scripts/install-workspace.sh <repo> [--copy|--link]` — install into a
  specific project's `.github/`.

## Frontmatter cheat sheet

**Prompt** (`prompts/<name>.prompt.md`):

```yaml
---
description: "Trigger phrase + use-when scenarios."
argument-hint: "Optional input hint"
---
```

**Instructions** (`instructions/<name>.instructions.md`):

```yaml
---
description: "Keyword-rich trigger phrase."
applyTo: "**/*.py"   # scope to specific files (do not use `**` — burns context)
---
```

**Agent** (`agents/<name>.agent.md`):

```yaml
---
description: "Trigger phrase for subagent discovery."
tools: [read, search]                # least-privilege
model: "Claude Sonnet 4.5 (copilot)"
user-invocable: false                # subagent only
---
```

**Skill** (`skills/<name>/SKILL.md`, folder name must match `name`):

```yaml
---
name: skill-name
description: "What + when. Max 1024 chars."
---
```

## Style

- Voice: direct, terse, no filler.
- No emojis in customization bodies.
- No blanket `applyTo: "**"` — always scope by extension or path.
- Keep skills under ~300 lines; put long assets in sibling files with `[link](./file)`.

## What not to do

- Don't add tests, CI, or a package.json here. This repo is Markdown.
- Don't invent frontmatter fields not documented by Copilot / VS Code.
- Don't commit anything from `~/Library/Application Support/Code/User/`.
- Don't organize by language. Group by situation. Language rules go in
  `instructions/` with an `applyTo` glob.
