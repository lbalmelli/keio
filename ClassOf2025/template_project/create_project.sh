#!/usr/bin/env bash
set -euo pipefail
folder_name="$(basename "$PWD")"
if [[ "$folder_name" == "template_project" ]]; then
  echo "Detected folder: $folder_name"
  read -rp "Please enter a new project folder name (e.g., keio-2025-yourid): " newname
  newname="${newname//[[:space:]]/}"
  if [[ -z "$newname" ]]; then echo "❌ A non-empty name is required. Aborting."; exit 1; fi
  if [[ -e "../$newname" ]]; then echo "❌ A sibling folder named '$newname' already exists. Choose a different name."; exit 1; fi
  parent_dir="$(dirname "$PWD")"; mv "$PWD" "$parent_dir/$newname"; cd "$parent_dir/$newname"; folder_name="$newname"; echo "✅ Folder renamed to $folder_name"
fi
for d in data concepts pocs analysis designs; do mkdir -p "$d"; touch "$d/.gitkeep"; done
if [[ ! -f "data/project_description.md" ]]; then
cat > data/project_description.md <<'EOF'
# Project Description
- **Title:** 
- **Team & Roles:** 
- **Problem Statement:** 
- **Goals / Success Criteria:** 
EOF
fi
echo "📘 Using local methodology at .keio/methodology.md"
echo "💡 Prompts available at .keio/prompts/"
echo "✅ Project structure verified for \"$folder_name\"."
