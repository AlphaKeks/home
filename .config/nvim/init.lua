-- this config is intended for neovim 0.7.2
-- https://github.com/AlphaKeks

require "alphakeks.impatient"

--[[ neovim settings ]]--
vim.opt.fileencoding = "utf-8"
vim.opt.clipboard:append("unnamedplus")
vim.opt.termguicolors = true

vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.pumheight = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.showmode = false
vim.opt.updatetime = 100
vim.opt.guifont = "firacode:h16"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

vim.g.blamer_enabled = 1
vim.g.blamer_delay = 1
vim.g.blamer_template = "// <committer> • <summary> (<committer-time>)"
vim.g.blamer_relative_time = 1

--[[ keymaps ]]--
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- general
keymap("n", "U", "<C-R>", opts)
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("n", "x", '"_x', opts) -- delete without yanking
keymap("n", "yw", "yiw", opts) -- yank a word from anywhere
keymap("n", "dw", '"_diw', opts) -- delete a word from anywhere without yanking
keymap("n", "cw", '"_ciw', opts) -- change a word from anywhere without yanking
keymap("n", "cc", '"_cc', opts) -- change line without yanking
keymap("v", "c", '"_c', opts) -- change selection without yanking
keymap("n", "ss", "<cmd>split<CR>", opts)
keymap("n", "sv", "<cmd>vsplit<CR>", opts)
keymap("n", "<leader>r", ":%s/", { noremap = true })

-- line navigation / movement
keymap("n", "j", "v:count == 0 ? \"gj\" : \"j\"", { expr = true }, opts)
keymap("n", "k", "v:count == 0 ? \"gk\" : \"k\"", { expr = true }, opts)
keymap("n", "J", "<ESC>:m .+1<CR><ESC>", opts)
keymap("n", "K", "<ESC>:m .-2<CR><ESC>", opts)
keymap("v", "J", "<ESC>:m .+1<CR><ESC>", opts)
keymap("v", "K", "<ESC>:m .-2<CR><ESC>", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)
keymap("x", "<", "<gv", opts)

-- buffer navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<C-w>", "<cmd>bdelete<CR>", opts)

-- telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>o", "<cmd>Telescope oldfiles<CR>", opts)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<CR>", opts)

-- nvim-tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- commenting
keymap("n", "<leader>c", "<cmd>lua require('Comment.api').toggle.linewise()<CR>", opts)
keymap("v", "<leader>c", "<cmd>lua require('Comment.api').toggle.blockwise()<CR>", opts)
keymap("x", "<leader>c", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- lspsaga / lsp navigation
keymap("n", "<leader><leader>", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "gL", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("i", "<C-h>", "<cmd>Lspsaga signature_help<CR>", opts)

keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- terminal
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", opts)
keymap("t", "<C-t>", "<cmd>ToggleTerm<CR>", opts)

require "alphakeks.plugins"
