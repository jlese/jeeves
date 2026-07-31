#!/usr/bin/env bash
# Scaffold a new skill from templates/SKILL.md.tmpl.
# Usage: ./scripts/new-skill.sh <plugin> <skill-name>
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <plugin> <skill-name>" >&2
  exit 1
fi

plugin="$1"
skill="$2"
root="$(cd "$(dirname "$0")/.." && pwd)"
dest="$root/plugins/$plugin/skills/$skill"

if [[ ! -d "$root/plugins/$plugin" ]]; then
  echo "error: plugin '$plugin' not found at $root/plugins/$plugin" >&2
  exit 1
fi

if [[ -d "$dest" ]]; then
  echo "error: skill already exists at $dest" >&2
  exit 1
fi

mkdir -p "$dest"
sed "s/SKILL_NAME/$skill/g" "$root/templates/SKILL.md.tmpl" > "$dest/SKILL.md"
echo "created $dest/SKILL.md"
