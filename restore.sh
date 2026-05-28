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

# ── Zsh ────────────────────────────────────────────────────────────────────────

cp zsh/zprofile ~/.zprofile
cp zsh/zshrc ~/.zshrc
cp zsh/zaliases ~/.zaliases

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

    # ── Keyboard ───────────────────────────────────────────────────────────────
    # Fastest key repeat (System Settings > Keyboard)
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10

    # Disable press-and-hold for accented characters (enables key repeat in apps)
    defaults write -g ApplePressAndHoldEnabled -bool false

    # Disable auto spelling correction
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Disable auto capitalization
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

    # ── Dock ───────────────────────────────────────────────────────────────────
    # Move dock to left side
    defaults write com.apple.dock orientation -string "left"

    # Disable recent applications section in dock
    defaults write com.apple.dock show-recents -bool false

    # ── Mission Control ────────────────────────────────────────────────────────
    # Disable automatically rearranging spaces based on recent use
    defaults write com.apple.dock mru-spaces -bool false

    # ── Finder ─────────────────────────────────────────────────────────────────
    # Show path bar at bottom of Finder window
    defaults write com.apple.finder ShowPathbar -bool true

    # Show all file extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # ── General ────────────────────────────────────────────────────────────────
    # Keep windows when quitting an app (uncheck "close windows when quitting")
    defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool true

    # Disable shake mouse pointer to locate (accessibility)
    defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true

    # Show date in menu bar clock
    defaults write com.apple.menuextra.clock ShowDate -int 1

    # Dark mode
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'

    # ── Trackpad ───────────────────────────────────────────────────────────────
    # Tracking speed — 2.5 approximates 8/10 in System Settings
    defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

    # Disable natural (reverse) scroll direction
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

    # Disable App Exposé gesture (swipe down with three fingers)
    defaults write com.apple.dock showAppExposeGestureEnabled -bool false

    # ── Dock ───────────────────────────────────────────────────────────────────
    # Dock size
    defaults write com.apple.dock tilesize -int 54

    # ── Spotlight ──────────────────────────────────────────────────────────────
    # Disable Cmd+Space Spotlight shortcut — use Alfred instead
    /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null

    # ── Gatekeeper ─────────────────────────────────────────────────────────────
    # Allow apps downloaded from anywhere (requires sudo)
    if [ "$EUID" -eq 0 ] || sudo -n true 2>/dev/null; then
        sudo spctl --master-disable
    else
        echo "⚠️  Skipping Gatekeeper — run manually: sudo spctl --master-disable"
    fi

    # ── Apply changes ──────────────────────────────────────────────────────────
    killall Dock
    killall Finder
    killall SystemUIServer

    # ── iTerm2 ─────────────────────────────────────────────────────────────────
    # Point to dotfiles folder so prefs auto-save back here
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$PWD/iTerm2"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    defaults read com.googlecode.iterm2

    echo ""
    echo "✓ macOS defaults applied — please restart iTerm2 if running from within it"

elif [ "$(uname)" == "Linux" ]; then
    echo "No iTerm2 on Linux, ignoring macOS steps"
fi
