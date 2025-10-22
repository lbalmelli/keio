# ClassOf2025 — KEIO SysML + AI Course

This folder contains the **self-contained project template** for the 2025 cohort.
Students should work *only* inside their own renamed copy of `template_project/`.

## 👣 Quick Start (recommended)
```bash
# 1) Shallow clone the course repo (fast, minimal history)
git clone --depth 1 https://github.com/lbalmelli/keio.git
cd keio/ClassOf2025/template_project

# 2) Initialize (auto-rename + structure)
./create_project.sh    # prompts for your project name (e.g., keio-2025-teamA)

# 3) Work inside the new folder (created by the script)
#    e.g., keio/ClassOf2025/keio-2025-teamA

# 4) Save & push ONLY your folder
./save_project.sh      # asks for a commit message and pushes just your folder
```

## 📦 What’s inside
- `template_project/` — a **self-contained** template: includes its own `.keio/` methodology, `.cursor` rules, and helper scripts
- **No need** to edit anything outside your renamed folder

## 🚫 Guardrails
- The push script commits **only your folder**.
- CI on the repo rejects changes outside your team’s folder.
