# template_project (self-contained)

This is the **starting folder** for your project. It contains everything you need:
- `.keio/` — methodology, prompts, SysML cheat-sheets
- `.cursor/` — rules that guide Cursor to follow the methodology
- `scripts/` — helpers (e.g., SysML linter)
- `create_project.sh` — **run once**; if still named `template_project`, it asks for a new name and renames automatically (no manual `mv` needed)
- `save_project.sh` — commits **only this folder** and pushes it to the repo

## Workflow
```bash
# inside ClassOf2025/template_project
./create_project.sh      # prompts & renames, sets up structure
# ...work on your models...
./save_project.sh        # prompts for commit message, validates meaningful changes, pushes only your folder
```

Tips:
- Use the prompts in `.keio/prompts/` to generate Concepts → PoCs → Analysis → Designs.
- Check `.keio/cheatsheets/sysml-v2-cheatsheets.md` to avoid SysML v2 syntax mistakes.
