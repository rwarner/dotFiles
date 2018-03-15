set shiftwidth=4 softtabstop=4

" Line numbers
set number

" auto indent
set autoindent

" Spaces over tabs
set expandtab
set smarttab

" Mouse support
set mouse=a

set backspace=2

" AI
set smartcase

" Syntax highlighting
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Set backup stuff
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

