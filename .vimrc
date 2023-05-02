
"      _    _       _           _  __    _
"     / \  | |_ __ | |__   __ _| |/ /___| | _____
"    / _ \ | | '_ \| '_ \ / _` | ' // _ \ |/ / __|
"   / ___ \| | |_) | | | | (_| | . \  __/   <\__ \
"  /_/   \_\_| .__/|_| |_|\__,_|_|\_\___|_|\_\___/
"            |_|
"

set nocompatible
set confirm
set undofile

if has("nvim")
  set undodir=~/.config/nvim/undo
else
  set undodir=~/.vim/undo
endif

set noswapfile
set mouse=
set updatetime=69
set completeopt=menu,menuone,preview,noinsert,noselect
set ignorecase
set smartcase
set showmatch
set matchtime=1
set path=**
set termguicolors
set colorcolumn=100
set cursorline
set fillchars+=fold:\ 
set nofoldenable
set foldlevel=1
set foldmethod=indent
set guicursor=a:block,i:ver20,v-r:hor20
set hlsearch
set laststatus=3
set list
set listchars=tab:│\ ,trail:-
set number
set relativenumber
set scrolloff=12
set signcolumn=yes
set splitbelow
set splitright
set autoindent
set breakindent
set smartindent
set noexpandtab
set tabstop=3
set shiftwidth=3
set textwidth=100
set formatoptions=crqn2lj

syntax on
filetype on

let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_bufsettings="rnu"
let g:mapleader=" "

nn <Esc> :nohlsearch<cr>
nn <Leader>e :Ex<cr>
nn <C-s> :w<cr>
nn <C-w> :clo<cr>
nn U <C-r>
nn x "_x

nn <Leader>y "+y
vn <Leader>y "+y
nn <Leader>Y "+y$
vn <Leader>Y "+y$

nn <Leader>p "+p
vn <Leader>p "+p
nn <Leader>P "+P
vn <Leader>P "+P

nn J V:m '>+1<cr>gv=gv<Esc>
nn K V:m '<-2<cr>gv=gv<Esc>
vn J :m '>+1<cr>gv=gv
vn K :m '<-2<cr>gv=gv

nn <C-h> <C-w>h
nn <C-j> <C-w>j
nn <C-k> <C-w>k
nn <C-l> <C-w>l

nn <Leader>ss :sp<cr>
nn <Leader>vs :vsp<cr>

nn <C-1> gt
nn <C-2> 2gt
nn <C-3> 3gt
nn <C-4> 4gt
nn <C-5> 5gt
nn <C-6> 6gt
nn <C-7> 7gt
nn <C-8> 8gt
nn <C-9> 9gt

nn <C-Up> :resize +2<cr>
nn <C-Down> :resize -2<cr>
nn <C-Right> :vert resize +2<cr>
nn <C-Left> :vert resize -2<cr>

tnoremap <C-Esc> <C-\><C-n>
nn <Leader>t :tabe<cr>:term<cr>i

nn <Leader>qo :copen<cr>
nn <Leader>qn :cnext<cr>
nn <Leader>qp :cprev<cr>

if !has("nvim")
  colorscheme catppuccin
endif
