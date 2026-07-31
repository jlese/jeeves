#!/usr/bin/env bash
# Install Jeeves customizations into the VS Code user profile.
# Symlinks prompts/, instructions/, agents/ into ~/Library/Application Support/Code/User/prompts/
# and skills/ into ~/.copilot/skills/. Re-run safely (removes existing links first).
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"

user_root="$HOME/Library/Application Support/Code/User/prompts"
skills_root="$HOME/.copilot/skills"

mkdir -p "$user_root" "$skills_root"

link() {
  local src="$1" dst="$2"
  [[ -L "$dst" || -e "$dst" ]] && rm -rf "$dst"
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

# Flat files land in user prompts folder
for f in "$root"/prompts/*.prompt.md \
         "$root"/instructions/*.instructions.md \
         "$root"/agents/*.agent.md; do
  [[ -f "$f" ]] || continue
  link "$f" "$user_root/$(basename "$f")"
done

# Skills are folders — link each individually
for d in "$root"/skills/*/; do
  [[ -d "$d" ]] || continue
  name="$(basename "$d")"
  [[ "$name" == _* ]] && continue   # skip _SUPERPOWERS-* meta files
  link "$d" "$skills_root/$name"
done

echo "done"
