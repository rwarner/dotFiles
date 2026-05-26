#!/bin/bash
# Restoration of dot files

# ── Vim ────────────────────────────────────────────────────────────────────────

cp -R vim/ ~/.vim
cp vimrc ~/.vimrc

# Create vim backup/tmp directories if they don't exist
if [ ! -d ~/.vim/backup ]; then
    mkdir -p ~/.vim/backup
fi

if [ ! -d ~/.vim/tmp ]; then
    mkdir -p ~/.vim/tmp
fi

# ── Git ────────────────────────────────────────────────────────────────────────

cp gitignore_global ~/.gitignore_global
# gitconfig is gitignored (contains personal info) — copy only if present locally
if [ -f gitconfig ]; then
    cp gitconfig ~/.gitconfig
fi

# ── Bash ───────────────────────────────────────────────────────────────────────

cp bash/bash_aliases ~/.bash_aliases
cp bash/bash_profile ~/.bash_profile

# ── SSH ────────────────────────────────────────────────────────────────────────

# ssh/config is gitignored (contains personal info) — copy only if present locally
if [ -f ssh/config ]; then
    mkdir -p ~/.ssh
    cp ssh/config ~/.ssh/config
    chmod 600 ~/.ssh/config
fi

# ── mise ───────────────────────────────────────────────────────────────────────

# Install mise if not already present
if [ ! -x "$HOME/.local/bin/mise" ]; then
    echo "Installing mise..."
    curl https://mise.run | sh
fi

# Restore tool version config
mkdir -p ~/.config/mise
cp mise/mise_config_backup.toml ~/.config/mise/config.toml

# Install all tools defined in config
~/.local/bin/mise install

# ── macOS specific ─────────────────────────────────────────────────────────────

if [ "$(uname)" == "Darwin" ]; then

    # Silence ZSH upgrade prompt
    cp .hushlogin ~/.hushlogin

    # iTerm2 — point to dotfiles folder so prefs auto-save back here
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$PWD/iTerm2"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    defaults read com.googlecode.iterm2

    echo "Please restart iTerm2 if running this from within iTerm2"

elif [ "$(uname)" == "Linux" ]; then
    echo "No iTerm2 on Linux, ignoring macOS steps"
fi
