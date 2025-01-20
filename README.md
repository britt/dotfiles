# Dotfiles

My personal dotfiles and system configuration for macOS development environment.

## Overview

This repository contains my configuration files and setup scripts for a consistent development environment. It includes:

- Shell configuration with ZSH
- Git configuration and global ignores
- Homebrew packages and applications
- System setup automation

## Quick Start

```bash
git clone https://github.com/brittcraw/dotfiles.git
cd dotfiles
./setup.sh
```

## What's Included

### Shell Configuration
- `.zshrc` - ZSH configuration with custom aliases and settings

### Git Configuration
- `.gitconfig` - Git aliases and user settings
- `.gitignore` - Global git ignore patterns

### Package Management
- `Brewfile` - Manages Homebrew packages, casks, and Mac App Store apps

### Setup
- `setup.sh` - Automated setup script that:
  - Installs Homebrew and packages
  - Creates symlinks for dotfiles
  - Configures system preferences

## Maintenance

To update packages and configurations:

```bash
# Update Homebrew packages
brew bundle

# Re-run setup script (it's idempotent)
./setup.sh
```
