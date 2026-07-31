#!/usr/bin/env bash
# Validate frontmatter of every customization file. Fails on missing description or bad structure.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
fail=0

check_frontmatter() {
  local file="$1" required_field="$2"
  local first_line
  first_line=$(head -n1 "$file")
  if [[ "$first_line" != "---" ]]; then
    echo "MISSING frontmatter: $file"
    fail=1
    return
  fi
  if ! awk -v field="$required_field" '/^---$/{n++} n==1 && $0 ~ "^"field":"{ok=1} END{exit ok?0:1}' "$file"; then
    echo "MISSING $required_field: $file"
    fail=1
  fi
}

for f in "$root"/prompts/*.prompt.md;           do [[ -f "$f" ]] && check_frontmatter "$f" description; done
for f in "$root"/instructions/*.instructions.md; do [[ -f "$f" ]] && check_frontmatter "$f" description; done
for f in "$root"/agents/*.agent.md;              do [[ -f "$f" ]] && check_frontmatter "$f" description; done

while IFS= read -r file; do
  check_frontmatter "$file" name
  check_frontmatter "$file" description
  folder=$(basename "$(dirname "$file")")
  name=$(awk '/^---$/{n++} n==1 && /^name:/{sub("^name: *",""); gsub("[\"'\'']",""); print; exit}' "$file")
  if [[ -n "$name" && "$name" != "$folder" ]]; then
    echo "NAME/FOLDER mismatch: $file (name=$name folder=$folder)"
    fail=1
  fi
done < <(find "$root/skills" -name SKILL.md)

if [[ $fail -eq 0 ]]; then
  echo "ok"
fi
exit $fail
