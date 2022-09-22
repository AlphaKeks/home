local map = vim.keymap.set
local def = { silent = true }

map("", "<Space>", "<Nop>", def)
vim.g.mapleader = " "

map("n", "<C-s>", "<cmd>write<cr>", def)
map("n", "<C-w>", "<cmd>bdelete<cr>", def)
map("n", "<C-a>", "ggvG", def)
map("n", "<leader>r", ":%s/")

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

map("n", "J", "V:m '>+1<cr>gv<esc>", def)
map("n", "K", "V:m '<-2<cr>gv<esc>", def)
map({ "v", "x" }, "J", ":m '>+1<cr>gv", def)
map({ "v", "x" }, "K", ":m '<-2<cr>gv", def)
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
	map("n", "<leader>c", function()
		api.toggle.linewise()
	end, def)

	map("v", "<leader>c", function()
		api.toggle.blockwise()
	end, def)

	map("x", "<leader>c", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "nx", false)
		api.toggle.blockwise(vim.fn.visualmode())
	end, def)
end

map({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>", def)

map("n", "<leader><leader>", function() vim.lsp.buf.hover() end, def)
map("n", "gl", function() vim.diagnostic.open_float() end, def)
map("n", "gL", function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float()
end, def)
map("n", "gd", function() vim.lsp.buf.definition() end, def)
map("n", "gr", function() vim.lsp.buf.rename() end, def)
map("n", "ga", function() vim.lsp.buf.code_action() end, def)
map("n", "gi", function() vim.lsp.buf.implementation() end, def)
map("n", "gh", function() vim.lsp.buf.signature_help() end, def)
