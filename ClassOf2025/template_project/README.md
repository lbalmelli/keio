# template_project (self-contained)

This folder includes everything needed for your project:
- `.keio/` — methodology, prompts, SysML cheat-sheets
- `.cursor/` — rules that guide Cursor to follow the methodology
- `scripts/` — helpers (e.g., SysML linter)
- `create_project.sh` — **run once**; if still named `template_project`, it asks for a new name and renames automatically
- `save_project.sh` — commits **only this folder** and pushes to the repo

## Workflow
```bash
# inside ClassOf2025/template_project
./create_project.sh      # prompts & renames, sets up structure
# (follow the printed hint to 'cd .. && cd "<newname>"')
# ...work on your models...
./save_project.sh        # prompts for commit message, validates, pushes only your folder
```

---

## 🧩 SysML Linter

A helper script `scripts/lint-sysml.sh` is provided to quickly check for common mistakes in SysML v2 files (e.g., unbalanced braces, UML carryovers like `class` or `->`).

### 🔍 Run the linter manually
```bash
bash scripts/lint-sysml.sh
```

Or use the Makefile helper:
```bash
make lint-sysml
```

### 💡 Tips
- Lint a specific path:
  ```bash
  make lint-sysml PATHS=concepts
  ```
- The linter reports:
  - **Errors** (e.g., missing braces)
  - **Warnings** for suspicious syntax
  - **Hints** about `:>`, `::>`, or `:>>` operators
- At the end, it points you to the cheat-sheet:
  `.keio/cheatsheets/sysml-v2-cheatsheets.md`
  (Sensmetry’s SysML v2 quick reference and the official textual notation tutorial)
