" https://github.com/AlphaKeks

" settings
set confirm
set filetype=on
set mouse=
set noswapfile
set undodir=/home/.vim/undo
set undofile
set updatetime=69
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
set colorcolumn=100
set foldcolumn=0
set formatoptions=crqn2lj
set guicursor=a:block,i:ver25,v:hor10,r-cr-o:hor20
set guifont=JetBrains_Mono:h16
set laststatus=3
set nolist
set number
set relativenumber
set scrolloff=8
set sidescrolloff=8
set noshowmode
set signcolumn=yes
set splitbelow
set splitright
set termguicolors
set wrap
set nohlsearch
set incsearch
set ignorecase
set smartcase

" keymaps
nnoremap <Space> <Nop>
let mapleader = " "

nnoremap <C-s> :w<cr>
nnoremap <C-w> :close<cr>

nnoremap U <C-r>
nnoremap x "_x

nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>p "+p

nnoremap J V:m '>+1<cr>gv=gv<esc>
nnoremap K V:m '<-2<cr>gv=gv<esc>
vnoremap J :m '>+1<cr>gv=gv<esc>
vnoremap K :m '<-2<cr>gv=gv<esc>

nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap H :tabprevious<cr>
nnoremap L :tabnext<cr>

let netrw_liststyle=1
let netrw_banner=0

nnoremap <leader>e :Ex<cr>

" colorscheme
colorscheme quiet
