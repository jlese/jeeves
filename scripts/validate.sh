#!/usr/bin/env bash
# Lint every SKILL.md: must have YAML frontmatter with `name` and `description`.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
fail=0

while IFS= read -r file; do
  first_line=$(head -n1 "$file")
  if [[ "$first_line" != "---" ]]; then
    echo "MISSING frontmatter: $file"
    fail=1
    continue
  fi
  if ! awk '/^---$/{n++} n==1 && /^name:/{ok=1} END{exit ok?0:1}' "$file"; then
    echo "MISSING name: $file"
    fail=1
  fi
  if ! awk '/^---$/{n++} n==1 && /^description:/{ok=1} END{exit ok?0:1}' "$file"; then
    echo "MISSING description: $file"
    fail=1
  fi
done < <(find "$root/plugins" -name SKILL.md)

if [[ $fail -eq 0 ]]; then
  echo "ok"
fi
exit $fail
