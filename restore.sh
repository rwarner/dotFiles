#!/bin/bash
# Restoration of dot files

# Vim restoration
cp -R vim/ ~/.vim/
cp vimrc ~/.vimrc

# Create vim directories for backup/tmp if they don't exist
if [ -d ~/.vim/backup ]; then
    mkdir -p ~/.vim/backup
fi

if [ -d ~/.vim/tmp ]; then
    mkdir -p ~/.vim/tmp
fi

# Git restoration
cp gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Bash restoration
cp bash/bash_aliases ~/.bash_aliases
cp bash/bash_profile ~/.bash_profile

if [ "$(uname)" == "Darwin" ]; then
    # OS X specific 
    
    # Seperating the iTerm2 loading since Linux wouldn't utilize this

    # iTerm2 -> Preferences -> General has an auto-save to directory
    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$PWD/iTerm2"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    #Force iTerm2 to read new settings
    defaults read com.googlecode.iterm2

    echo "Please restart iTerm2, if executing a restore from iTerm2"
elif [ "$(uname)" == "Linux" ]; then
    #Linux specific

    #elif block can't be empty
    echo "No iTerm2 on Linux, ignoring"
fi
