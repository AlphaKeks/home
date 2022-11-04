" https://github.com/AlphaKeks

" settings
set nocompatible
set path+=**
set wildmenu
set clipboard=unnamedplus
syntax on
filetype on

set cdhome
set confirm
set fileencoding=utf-8
set mousehide
set noswapfile
set undodir=/home/max/.config/vim/undo
set undofile
set updatetime=50

set autoindent
set breakindent
set copyindent
set noexpandtab
set preserveindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4

set cursorline
set formatoptions=crqn2lj
set guicursor=a:block,i:ver25,v:hor10,r:hor10
set laststatus=2
set number
set relativenumber
set scrolloff=8
set sidescrolloff=8
set showmode
set signcolumn=yes
set splitbelow
set splitright
set termguicolors
set textwidth=0
set wrap
set wrapmargin=8

set hlsearch
set incsearch
set ignorecase

" keymaps
noremap <Space> <Nop>
let mapleader = " "

nnoremap <C-s> :w<cr>
nnoremap <C-w> :close<cr>

nnoremap U <C-r>
nnoremap x "_x
nnoremap dw diw
nnoremap cw ciw
nnoremap vw viw
nnoremap yw yiw
nnoremap cc "_cc
vnoremap <leader>p "_dP
xnoremap <leader>p "_dP

nnoremap J V:m '>+1<cr>gv=gv<esc>
nnoremap K V:m '<-2<cr>gv=gv<esc>
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
xnoremap J :m '>+1<cr>gv=gv
xnoremap K :m '<-2<cr>gv=gv

nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv
xnoremap < <gv
xnoremap > >gv

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>e :Ex<cr>
