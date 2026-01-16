# AGENTS.md

This document provides guidelines for agentic coding assistants working on this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for Linux/Unix systems. The repository follows a bare git approach where `$HOME` is the worktree.

## Build/Test/Lint Commands

### Shell Scripts
- **Syntax check**: `bash -n <script.sh>` - Check syntax without executing
- **Shellcheck**: `shellcheck <script.sh>` - Lint shell scripts (requires shellcheck)
- **Test single function**: Source the script and test specific functions manually

### Configuration Files
- Most config files (vim, zsh, etc.) can be validated by their respective applications
- **Vim**: `vim -u <vimrc> -c "quit"` - Test vim configuration
- **Zsh**: `zsh -n <zshrc>` - Syntax check zsh configuration

### Git Operations
- Bare git alias: `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME`
- Common workflow: Use the `dotfiles` alias defined in README

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

### Configuration Files
- Follow application-specific conventions
- Group related settings with comments as separators
- Use descriptive variable names
- Keep user-specific settings in separate files when possible
- Document complex configurations with inline comments

### Imports and Source Files
- Source files using relative or absolute paths: `source ~/.config/app/config`
- Use guard patterns to prevent double-sourcing: `[[ -n "$LOADED_CONFIG" ]] && return`
- Place environment variables in `~/.profile` or `~/.zshenv`
- Place aliases in shell-specific config files

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

### Git Workflow
- Commit related changes together
- Use clear commit messages: "vim: add statusline configuration"
- Test configs in a safe environment before committing
- Be careful with sensitive data (never commit API keys, passwords)
- Use `.gitignore` for machine-specific files

### Testing
- Test shell scripts with `-n` flag first
- Test configs by applications in a test environment
- Verify bare git checkout works correctly
- Check for syntax errors before committing
- Test on fresh system when possible

### Security Considerations
- Never commit secrets or credentials
- Use environment variables for sensitive data
- Check file permissions for sensitive configs
- Be cautious with executable scripts in $PATH
- Validate external inputs in scripts

### Platform Specificity
- This repository targets Arch Linux (based on README)
- Note distribution-specific commands (pacman vs apt)
- Use conditional logic for cross-platform compatibility when needed
- Document OS requirements for each config
