#!/bin/bash
# Restoration of dot files

# Vim restoration
cp -R vim/ ~/.vim/
cp vimrc ~/.vimrc

# Git restoration
cp gitignore_global ~/.gitignore_global

# Bash restoration
cp bash/bash_aliases ~/.bash_aliases

