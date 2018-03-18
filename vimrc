"Comments are set with a -> "

" Theming
set background=dark
set termguicolors
colorscheme material-monokai  "Color scheme for terminal


" Tab Control
set shiftwidth=4 
set softtabstop=4   "Number of spaces for a tab when editing/inserted
set expandtab       "Turns tabs into spaces (i.e. inserts four spaces)
set smarttab

" Syntax
filetype on
filetype plugin on
syntax enable               "Enables processing of syntax
set grepprg=grep\ -nH\ $*
set showmatch               "Enables highlight matching of ([{}])
set autoindent              "Auto indentation

" Searching
set incsearch       "Searches as characters are entered
set hlsearch        "Highlight matches searched for
set smartcase       "Uses CaSe is any captilizations are used

" Etc
set number      "Enables line numbers in files
set cursorline  "Highlights current line you're editing
set wildmenu    "Visual autocomplete in the command menu on <tab>
set mouse=a     "Enables mouse support
set backspace=2 "Enables backspace to work as assumed (not weird)

" Set backup stuff
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

