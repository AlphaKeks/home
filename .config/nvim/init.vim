
"      _    _       _           _  __    _
"     / \  | |_ __ | |__   __ _| |/ /___| | _____
"    / _ \ | | '_ \| '_ \ / _` | ' // _ \ |/ / __|
"   / ___ \| | |_) | | | | (_| | . \  __/   <\__ \
"  /_/   \_\_| .__/|_| |_|\__,_|_|\_\___|_|\_\___/
"            |_|
"

source ~/.vimrc

au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 69 })

au TermOpen * silent! setlocal nonu rnu scrolloff=0

lua require("alphakeks")
