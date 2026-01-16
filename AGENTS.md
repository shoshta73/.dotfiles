# AGENTS.md

This document provides guidelines for agentic coding assistants working on this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for Linux/Unix systems. The repository follows a bare git approach where `$HOME` is the worktree.

### Repository Structure
- `.bash/` - Bash-specific configurations (aliases, prompt)
- `.bashrc`, `.bash_profile`, `.profile` - Shell initialization files
- `.vscode/` - VS Code settings and configurations
- `.editorconfig` - Editor formatting rules (repository-wide)

### Key Features
- Bare git workflow: All files are tracked in `$HOME` with git dir at `$HOME/.dotfiles/`
- Arch Linux focused (uses `pacman` for package management)
- Modular bash configuration with separate files in `.bash/` directory
- VS Code configured to recognize dotfiles as shell scripts

## Build/Test/Lint Commands

### Shell Scripts
- **Syntax check**: `bash -n <script.sh>` - Check syntax without executing
- **Shellcheck**: `shellcheck <script.sh>` - Lint shell scripts (requires shellcheck)
- **Run single script**: `./install.sh` - Main installation script (uses set -euo pipefail)

### Configuration Files
- **Bash**: `bash -n ~/.bashrc` - Syntax check bashrc
- **Bash**: `bash -c 'source ~/.bashrc; type dotfiles'` - Verify alias works
- **Test source file**: `source ~/.bash/colors && echo "$COLOR_RESET"` - Test config loads

### Git Operations (Bare Repository)
- **Add**: `dotfiles add <path>` (alias from ~/.bash/aliases)
- **Commit**: `dotfiles commit -m "message"`
- **Status**: `dotfiles status`
- **Diff**: `dotfiles diff`
- **Checkout**: `dotfiles checkout`

### Installation
- Run `./install.sh` after initial bare git checkout to set up directories and tools
- **No unit tests**: This is a dotfiles repo - test by sourcing configs and verifying functionality

## Code Style Guidelines

### General Formatting (from .editorconfig)
- **Indentation**: 2 spaces (no tabs)
- **Line length**: Maximum 120 characters
- **Line endings**: LF (Unix style)
- **Final newline**: Required
- **Trailing whitespace**: Trim (except in markdown files)
- **Charset**: UTF-8

### Shell Scripts
- Use POSIX-compliant syntax when possible for portability
- Quote all variable expansions: `"$VAR"` instead of `$VAR`
- Use `set -euo pipefail` at the top of scripts for safety
- Function names: `snake_case` with descriptive names
- Comments: Use `#` for single-line, explain non-obvious logic
- Shebang: Use `#!/usr/bin/env bash` for better portability
- Constants: Use `readonly` keyword: `readonly VERSION="1.0"`
- Log with color: `echo -e "[${COLOR_GREEN}INFO${COLOR_RESET}] Message"`

### Configuration Files
- Follow application-specific conventions
- Group related settings with comments as separators
- Use descriptive variable names
- Document complex configurations with inline comments

### Imports and Source Files
- Source files using absolute paths: `source ~/.bash/aliases`
- Use guard patterns: `[[ -n "$LOADED_CONFIG" ]] && return`

### Naming Conventions
- **Files**: `snake_case` or `kebab-case` for scripts, `.` prefix for configs
- **Variables**: `UPPER_SNAKE_CASE` for constants, `lower_snake_case` for variables
- **Functions**: `lower_snake_case` verbs (e.g., `install_packages`)
- **Aliases**: Keep short and memorable (e.g., `ll` for `ls -la`)

### Error Handling
- Always check command exit codes: `command || { echo "Error"; exit 1; }`
- Use conditional execution: `command && success || failure`
- Provide meaningful error messages
- Use `trap` for cleanup on script exit
- Validate dependencies before execution
- Check for directory existence: `[ -d "$dir" ] && echo "exists" || echo "not found"`
- Check for command existence: `command -v "$pkg" &> /dev/null`

### Documentation
- Add header comments to complex scripts explaining purpose and dependencies
- Document non-standard configurations
- Use README sections to organize setup instructions
- Include install/usage examples
- Note OS-specific requirements

### File Organization
- Keep application configs in `~/.config/<app>/` following XDG Base Directory
- Shell configs in `~/.zshrc`, `~/.bashrc`, etc.
- System-wide configs in appropriate `/etc/` locations (document separately)
- Use subdirectories for related configs (e.g., `~/.config/nvim/lua/`)
- **This repo**: Bash configs split into `.bash/` subdirectory (aliases, ps1)
- **VS Code**: Settings in `.vscode/settings.json` with file associations for shell scripts

### Git Workflow
- Commit related changes together
- Use clear commit messages: "vim: add statusline configuration"
- Test configs in a safe environment before committing
- Be careful with sensitive data (never commit API keys, passwords)
- Use `.gitignore` for machine-specific files
- **This repo**: Uses bare git setup with `.dotfiles` as git dir (see .gitignore)
- Aliases defined in `~/.bash/aliases` use the dotfiles alias for convenience

### Testing
- Test shell scripts with `-n` flag first
- Test configs by applications in a test environment
- Verify bare git checkout works correctly
- Check for syntax errors before committing
- Test on fresh system when possible
- **For bash configs**: Source file and verify aliases/functions work: `source ~/.bashrc`

### Security Considerations
- Never commit secrets or credentials
- Use environment variables for sensitive data
- Check file permissions for sensitive configs
- Be cautious with executable scripts in $PATH
- Validate external inputs in scripts

### Platform Specificity
- This repository targets Arch Linux (uses pacman)

## Common Patterns

### Bare Git Setup
This repository uses a bare git setup with the following pattern:
```bash
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME <command>
```

### Modular Bash Configuration
The `.bashrc` sources files from `.bash/` directory for modularity:
 - `~/.bash/aliases` - Git aliases and other shortcuts
 - `~/.bash/ps1` - Custom prompt configuration
 - `~/.bash/colors` - ANSI color variables for logging
 - `~/.bash/variables` - Environment variable exports
 - `~/.bash/path` - PATH manipulation

## Troubleshooting

### Bare Git Issues
- If `dotfiles checkout` conflicts: Move existing files to `.dotfiles-backup/`
- If dotfiles alias doesn't work: Source `~/.bash/aliases` or restart shell
- To verify setup: Run `dotfiles status` to check repository state

### Configuration Loading Issues
- Test bash config: `bash -c 'source ~/.bashrc; echo OK'`
- Check file paths: Ensure sourced files exist before sourcing
- Verify permissions: Ensure shell scripts are readable
