#!/bin/bash
# Backup of dot files

# Vim restoration
cp -R ~/.vim/ vim/
cp ~/.vimrc vimrc 

# Git restoration
cp ~/.gitignore_global gitignore_global

# Bash restoration
cp ~/.bash_aliases bash/bash_aliases
cp ~/.bash_profile bash/bash_profile
