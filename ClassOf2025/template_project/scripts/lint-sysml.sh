#!/usr/bin/env bash
set -euo pipefail
CHEATSHEET_PATH=".keio/cheatsheets/sysml-v2-cheatsheets.md"
paths=("$@"); [[ ${#paths[@]} -eq 0 ]] && paths=(".");
mapfile -t files < <(find "${paths[@]}" -type f -name "*.sysml" -not -path "*/.git/*" 2>/dev/null || true)
[[ ${#files[@]} -eq 0 ]] && { echo "ℹ️ No .sysml files found under: ${paths[*]}"; exit 0; }
echo "🔎 Linting ${#files[@]} SysML file(s)..."
errors=0
for f in "${files[@]}"; do
  echo "— $f"
  [[ ! -s "$f" ]] && { echo "  ❌ Empty file."; ((errors++)); }
  ob=$(grep -o "{" "$f" | wc -l | tr -d ' '); cb=$(grep -o "}" "$f" | wc -l | tr -d ' ')
  [[ "$ob" != "$cb" ]] && { echo "  ❌ Unbalanced braces: {=$ob }=$cb"; ((errors++)); }
  grep -Eqs '(^|[^[:alnum:]_])class[[:space:]]+' "$f" && echo "  ⚠️ 'class' keyword found — check SysML v2 terms."
  grep -Eqs '->' "$f" && echo "  ⚠️ '->' found — verify notation; avoid UML carryovers."
  col_ops=$(grep -oE '(::>|:>>|:>)' "$f" | sort | uniq -c | sed 's/^/      /' || true)
  if [[ -n "${col_ops:-}" ]]; then echo "  ℹ️ Colon-operators seen:"; echo "$col_ops"; fi
done
if (( errors > 0 )); then
  echo ""; echo "❌ Lint finished with $errors error(s). See $CHEATSHEET_PATH"; exit 1
else
  echo ""; echo "✅ Lint finished with no errors. Tips: $CHEATSHEET_PATH"
fi
