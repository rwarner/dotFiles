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

# TODO - Update iTerm2 preferences
