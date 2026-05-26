#!/bin/bash
# Backup of dot files

# Vim
cp ~/.vim/colors/* vim/colors
cp ~/.vimrc vimrc

# Git
cp ~/.gitignore_global gitignore_global
cp ~/.gitconfig gitconfig

# Bash
cp ~/.bash_aliases bash/bash_aliases
cp ~/.bash_profile bash/bash_profile

# SSH (config only — never back up private keys)
cp ~/.ssh/config ssh/config

# mise — tool version definitions
mkdir -p mise
cp ~/.config/mise/config.toml mise/mise_config_backup.toml

# macOS
cp ~/.hushlogin .hushlogin

# iTerm2 — preferences auto-saved directly to iTerm2/ by iTerm2 itself
# (iTerm2 > Settings > General > Preferences > custom folder = this repo)
# No manual copy needed — just git commit after changing iTerm2 settings
