---
name: check-commit-errors
description: Check files in git staged/changed for syntax errors or lint issues before committing. Use when asked to check commit, validate changes, or review files before git commit.
---

## Steps

1. Get list of changed files:
```bash
git diff --name-only --cached
```