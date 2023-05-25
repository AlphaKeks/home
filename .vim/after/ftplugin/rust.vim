setlocal noexpandtab

compiler cargo

nnoremap <Leader>rm :make clippy<CR>
nnoremap <Leader>rr :make run<CR>
nnoremap <Leader>rf mf:silent! %!rustfmt<CR>`f
