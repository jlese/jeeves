#!/usr/bin/env bash
# Scaffold a new customization from templates/. Supports prompt, instructions, agent, skill.
# Usage: ./scripts/new.sh <kind> <name>
#   kind: prompt | instructions | agent | skill
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <prompt|instructions|agent|skill> <name>" >&2
  exit 1
fi

kind="$1"
name="$2"
root="$(cd "$(dirname "$0")/.." && pwd)"

case "$kind" in
  prompt)
    dest="$root/prompts/$name.prompt.md"
    tmpl="$root/templates/prompt.md.tmpl"
    ;;
  instructions)
    dest="$root/instructions/$name.instructions.md"
    tmpl="$root/templates/instructions.md.tmpl"
    ;;
  agent)
    dest="$root/agents/$name.agent.md"
    tmpl="$root/templates/agent.md.tmpl"
    ;;
  skill)
    mkdir -p "$root/skills/$name"
    dest="$root/skills/$name/SKILL.md"
    tmpl="$root/templates/SKILL.md.tmpl"
    ;;
  *)
    echo "unknown kind: $kind" >&2
    exit 1
    ;;
esac

if [[ -e "$dest" ]]; then
  echo "error: already exists at $dest" >&2
  exit 1
fi

sed "s/SKILL_NAME/$name/g" "$tmpl" > "$dest"
echo "created $dest"
