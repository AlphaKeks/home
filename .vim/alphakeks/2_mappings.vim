let g:mapleader=" "

nnoremap <Esc> :nohlsearch<CR>
nnoremap <Leader>e :Explore<CR>
nnoremap <C-s> :write<CR>
nnoremap U <C-r>
nnoremap x "_x

nnoremap Y y$
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$
vnoremap <Leader>Y "+y$

nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

nnoremap J :silent! m +1<CR>==
nnoremap K :silent! m -2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

vnoremap < <gv
vnoremap > >gv

nnoremap <C-1> gt
nnoremap <C-2> 2gt
nnoremap <C-3> 3gt
nnoremap <C-4> 4gt
nnoremap <C-5> 5gt
nnoremap <C-6> 6gt
nnoremap <C-7> 7gt
nnoremap <C-8> 8gt
nnoremap <C-9> 9gt

nnoremap <C-Up> :resize +1<CR>
nnoremap <C-Down> :resize -1<CR>
nnoremap <C-Right> :vertical resize +1<CR>
nnoremap <C-Left> :vertical resize -1<CR>

tnoremap <C-Esc> <C-\><C-n>
nnoremap <Leader>t :tabedit \| terminal<CR>a

nnoremap <Leader>qo :copen<CR>
nnoremap <Leader>qn :cnext<CR>
nnoremap <Leader>qp :cprev<CR>

nnoremap <Leader>ff :find *
nnoremap <Leader>fl :grep 
nnoremap <C-/> :g/<C-r><C-w>/#<CR>:
