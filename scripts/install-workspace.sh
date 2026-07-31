#!/usr/bin/env bash
# Install Jeeves customizations into a specific workspace's .github/ folder.
# Usage: ./scripts/install-workspace.sh <path-to-repo> [--copy|--link]
# Default: --link (symlink; --copy makes independent copies).
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <path-to-repo> [--copy|--link]" >&2
  exit 1
fi

target="$1"
mode="${2:---link}"
root="$(cd "$(dirname "$0")/.." && pwd)"

if [[ ! -d "$target" ]]; then
  echo "error: target directory does not exist: $target" >&2
  exit 1
fi

gh="$target/.github"
mkdir -p "$gh"/{prompts,instructions,agents,skills}

place() {
  local src="$1" dst="$2"
  [[ -L "$dst" || -e "$dst" ]] && rm -rf "$dst"
  if [[ "$mode" == "--copy" ]]; then
    if [[ -d "$src" ]]; then cp -R "$src" "$dst"; else cp "$src" "$dst"; fi
    echo "copied $dst"
  else
    ln -s "$src" "$dst"
    echo "linked $dst -> $src"
  fi
}

for f in "$root"/prompts/*.prompt.md;           do [[ -f "$f" ]] && place "$f" "$gh/prompts/$(basename "$f")";           done
for f in "$root"/instructions/*.instructions.md; do [[ -f "$f" ]] && place "$f" "$gh/instructions/$(basename "$f")"; done
for f in "$root"/agents/*.agent.md;              do [[ -f "$f" ]] && place "$f" "$gh/agents/$(basename "$f")";              done

for d in "$root"/skills/*/; do
  [[ -d "$d" ]] || continue
  name="$(basename "$d")"
  [[ "$name" == _* ]] && continue
  place "$d" "$gh/skills/$name"
done

# Drop a copilot-instructions.md if the workspace doesn't have one yet.
if [[ ! -f "$gh/copilot-instructions.md" && ! -f "$target/AGENTS.md" ]]; then
  cp "$root/templates/AGENTS.md.tmpl" "$target/AGENTS.md"
  echo "seeded AGENTS.md (edit it)"
fi

echo "done"
