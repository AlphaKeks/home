" https://github.com/AlphaKeks

" settings
set nocompatible
set path+=**
set wildmenu
set incsearch
set hidden
set nobackup
set noswapfile
set t_Co=256
set number
set clipboard=unnamedplus
set scrolloff=8
set smarttab
set shiftwidth=2
set tabstop=2
set mouse=a
set splitbelow splitright
set termguicolors
filetype off
syntax enable

autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"
