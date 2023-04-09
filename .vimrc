" https://github.com/AlphaKeks

set autoindent
set breakindent
set colorcolumn=100
set completeopt=menu,menuone,preview,noinsert,noselect
set confirm
set cursorline
set expandtab
set fillchars+=fold:\ 
set formatoptions=crqn2lj
set nofoldenable
set foldlevel=1
set foldmethod=indent
set guicursor=a:block-blinkwait0-blinkoff300-blinkon150,i:ver20,v:hor20-blinkon0,r:hor20
set nohlsearch
set ignorecase
set laststatus=2
set list
set listchars=tab:│\ ,trail:-
set mouse=
set number
set nocompatible
set path+=**
set relativenumber
set scrolloff=12
set shiftwidth=4
set signcolumn=yes
set smartcase
set smartindent
set splitbelow
set splitright
set noswapfile
set tabstop=4
set termguicolors
set textwidth=100
set undodir=~/.vim/undo
set undofile
set updatetime=100
set wildmenu

let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_bufsettings='rnu'

colorscheme habamax

let g:mapleader=' '

nnoremap <leader>e :Ex<cr>
nnoremap <c-s> :write<cr>
nnoremap <c-w> :close<cr>
nnoremap U <c-r>
nnoremap x "_x
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>Y "+y$
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap J V:m '>+1<cr>gv=gv<esc>
nnoremap K V:m '<-2<cr>gv=gv<esc>
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
nnoremap < <gv
nnoremap > >gv
