set noexpandtab
set tabstop=3
set shiftwidth=3
set formatoptions=crqn2lj
echo 'hi'

compiler cargo

nn <Leader>rr :make run<cr>
nn <Leader>rc :make clippy<cr>
