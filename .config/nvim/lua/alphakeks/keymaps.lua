local map = vim.keymap.set
local def = { silent = true }

map("", "<Space>", "<Nop>", def)
vim.g.mapleader = " "

map("n", "<C-s>", "<cmd>write<cr>", def)
map("n", "<C-w>", "<cmd>bdelete<cr>", def)

map("n", "U", "<C-r>", def)
map("n", "x", "\"_x", def)
map("n", "dw", "diw", def)
map("n", "cw", "ciw", def)
map("n", "yw", "yiw", def)
map("n", "vw", "viw", def)
map("n", "cc", "\"_cc", def)
map({ "v", "x" }, "p", "\"_dP", def)
map({ "v", "x" }, "c", "\"_c", def)
map("n", "j", "gj", def)
map("n", "k", "gk", def)

map({ "n", "v", "x" }, "<leader>p", "\"+p", def)
map({ "n", "v", "x" }, "<leader>y", "\"+y", def)

map("n", "J", "V:m '>+1<cr>gv=gv<esc>", def)
map("n", "K", "V:m '<-2<cr>gv=gv<esc>", def)
map({ "v", "x" }, "J", ":m '>+1<cr>gv=gv", def)
map({ "v", "x" }, "K", ":m '<-2<cr>gv=gv", def)
map("n", ">", ">>", def)
map("n", "<", "<<", def)
map({ "v", "x" }, ">", ">gv", def)
map({ "v", "x" }, "<", "<gv", def)

map({ "n", "t" }, "<C-h>", "<C-w>h", def)
map({ "n", "t" }, "<C-j>", "<C-w>j", def)
map({ "n", "t" }, "<C-k>", "<C-w>k", def)
map({ "n", "t" }, "<C-l>", "<C-w>l", def)
map({ "n", "t" }, "<S-h>", "<cmd>bprevious<cr>", def)
map({ "n", "t" }, "<S-l>", "<cmd>bnext<cr>", def)
map("n", "ss", "<cmd>split<cr>", def)
map("n", "sv", "<cmd>vsplit<cr>", def)

local comment, api = pcall(require, "Comment.api")
if comment then
end

map("n", "<leader><leader>", vim.lsp.buf.hover, def)
map("n", "gl", vim.diagnostic.open_float, def)
map("n", "gL", function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float()
end, def)
map("n", "gd", vim.lsp.buf.definition, def)
map("n", "gr", vim.lsp.buf.rename, def)
map("n", "ga", vim.lsp.buf.code_action, def)
map("n", "gi", vim.lsp.buf.implementation, def)
map("n", "gh", vim.lsp.buf.signature_help, def)

map("n", "<leader>r", "<cmd>ReloadColors<cr>")
