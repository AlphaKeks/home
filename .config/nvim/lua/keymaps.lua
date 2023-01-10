-- space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)

-- overriding default behavior
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<C-w>", "<cmd>close<cr>")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>Y", "\"+y$")
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")

-- moving lines around
vim.keymap.set("n", "J", "V:m '>+1<cr>gv=gv<esc>")
vim.keymap.set("n", "K", "V:m '<-2<cr>gv=gv<esc>")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "H", "\"mxh\"mP")
vim.keymap.set("n", "L", "\"mx\"mp")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- window navigation
vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")

for i = 1,8,1 do
	vim.keymap.set({ "n", "t" }, "<C-" .. i .. ">", "<cmd>norm " .. i.. "gt<cr>")
end

vim.keymap.set({ "n", "t" }, "<C-9>", "<cmd>tablast<cr>")

vim.keymap.set("n", "<Leader>ss", "<cmd>split<cr>")
vim.keymap.set("n", "<Leader>vs", "<cmd>vsplit<cr>")
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<cr><cmd>term<cr>A")
vim.keymap.set("t", "<C-w>", "<cmd>tabclose<cr>")
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
