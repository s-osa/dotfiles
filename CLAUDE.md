# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal dotfiles repository managed with **chezmoi**. Files are deployed to the home directory; chezmoi handles the mapping from repo paths to target paths.

## Key Commands

```bash
# Apply changes to the home directory
chezmoi apply

# Preview what chezmoi would change
chezmoi diff

# List all files managed by chezmoi
chezmoi managed

# Pull latest and apply
chezmoi update

# Install all Homebrew packages
brew bundle --global
```

## Architecture

### File Naming Conventions (chezmoi)

| Prefix | Behavior |
|---|---|
| `dot_` | Deployed as a dotfile (e.g. `dot_vimrc` → `~/.vimrc`) |
| `create_once_dot_` | Created once, never overwritten again |
| `run_onchange_*.sh.tmpl` | Script run whenever its content changes |

### Two-tier Config Pattern

The `.common` suffix pattern (e.g. `dot_zshrc.common`, `dot_gitconfig.common`) is intentional:
- `create_once_dot_zshrc` → `~/.zshrc` (entry point, created once, allows machine-specific additions and external tool auto-appends)
- `dot_zshrc.common` → `~/.zshrc.common` (always synced from this repo, sourced by `~/.zshrc`)

This allows tools like Rancher Desktop and `mise` to append to `~/.zshrc` without conflicting with chezmoi.

### Claude Code Configuration

- `dot_claude/settings.json` → `~/.claude/settings.json`: User-level settings with permission allow/deny lists and audio hooks
- `dot_claude/commands/`: Custom slash commands (written in Japanese)
- `.claude/settings.local.json`: Repo-local permissions (not deployed by chezmoi; symlinked into git worktrees by `gwt()`)

### Git Worktrees

The `.wt/` directory is the container for git worktrees (its `.gitignore` excludes all contents). The `gwt()` shell function creates/selects worktrees and auto-symlinks `.claude/settings.local.json` into each worktree.

## Local Settings File

`.claude/settings.local.json` is listed in the global gitignore (`dot_config/git/ignore`). It exists in this repo for Claude Code permissions but is not tracked by chezmoi. It gets symlinked into new worktrees automatically by `gwt()`.
