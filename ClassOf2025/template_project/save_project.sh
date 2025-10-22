#!/usr/bin/env bash
set -euo pipefail
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "$repo_root" ]]; then echo "❌ Not inside a git repository. Run this from a folder within the repo."; exit 1; fi
project_dir="$PWD"; base_name="$(basename "$project_dir")"
if [[ "$base_name" == "template_project" ]]; then
  echo "❌ Refusing to push from template_project."
  echo "Detected folder: $base_name"
  echo "Try: ./create_project.sh  # it will prompt for a new name and rename automatically"
  exit 1
fi
echo "Enter a short commit message."
echo "Examples: 'concept: initial draft', 'poc: add auth PoC', 'analysis: gap table v2', 'design: API spec updates'"
read -rp "Commit message: " msg
if [[ -z "${msg// }" ]]; then msg="checkpoint: $(date -u +'%Y-%m-%d %H:%M:%SZ')"; echo "ℹ️ Using default message: $msg"; fi
relpath="${project_dir#$repo_root/}"
default_upstream="$(git -C "$repo_root" symbolic-ref refs/remotes/origin/HEAD 2>/dev/null || true)"
if [[ -n "$default_upstream" ]]; then default_branch="${default_upstream##*/}"; else default_branch="main"; fi
echo "📍 Repo root: $repo_root"; echo "📁 Project folder to commit: $relpath"; echo "🌿 Target branch: $default_branch"
git -C "$repo_root" fetch origin
git -C "$repo_root" checkout "$default_branch" 2>/dev/null || git -C "$repo_root" checkout -b "$default_branch"
git -C "$repo_root" pull --rebase origin "$default_branch"
git -C "$repo_root" add "$relpath"
mapfile -t staged < <(git -C "$repo_root" diff --cached --name-only -- "$relpath")
if [[ ${#staged[@]} -eq 0 ]]; then echo "ℹ️ No changes to commit in $relpath."; exit 0; fi
echo "🔍 Staged files:"; printf ' - %s\n' "${staged[@]}"
meaningful=0
for f in "${staged[@]}"; do
  if [[ "$f" == "$relpath/concepts/"* ]] || [[ "$f" == "$relpath/pocs/"* ]] || [[ "$f" == "$relpath/analysis/"* ]] || [[ "$f" == "$relpath/designs/"* ]] || [[ "$f" == "$relpath/data/project_description.md" ]] || [[ "$f" == "$relpath/main.sysml" ]]; then meaningful=1; break; fi
done
if [[ $meaningful -eq 0 ]]; then
  cat <<'EOF'
❌ Validation failed.
Your staged changes do not include updates in:
  - concepts/
  - pocs/
  - analysis/
  - designs/
  - data/project_description.md
  - main.sysml
Please add or modify at least one of the above to save meaningful progress.
EOF
  exit 1
fi
git -C "$repo_root" commit -m "$msg"
git -C "$repo_root" push origin "$default_branch"
echo "✅ Saved and pushed changes for \"$relpath\"."
