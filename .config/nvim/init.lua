-- this config is intended for neovim 0.7.2
-- https://github.com/AlphaKeks

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
vim.opt.guicursor = "a:block,i:block-blinkwait175-blinkoff150-blinkon175,v:hor50"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

vim.cmd [[ filetype plugin indent off ]]

vim.g.blamer_enabled = 1
vim.g.blamer_delay = 3000
vim.g.blamer_template = "	<summary> (<committer>)"
vim.g.blamer_relative_time = 1

--[[ keymaps ]]--
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- general
keymap("n", "U", "<C-R>", opts)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "x", '"_x', opts) -- delete without yanking
keymap("n", "yw", "yiw", opts) -- yank a word from anywhere
keymap("n", "dw", '"_diw', opts) -- delete a word from anywhere without yanking
keymap("n", "cw", '"_ciw', opts) -- change a word from anywhere without yanking
keymap("n", "cc", '"_cc', opts) -- change line without yanking
keymap("v", "c", '"_c', opts) -- change selection without yanking
keymap("n", "ss", ":split<CR>", opts)
keymap("n", "sv", ":vsplit<CR>", opts)
keymap("n", "<leader>r", ":%s/", { noremap = true })

-- line navigation / movement
keymap("n", "j", "v:count == 0 ? \"gj\" : \"j\"", { expr = true }, opts)
keymap("n", "k", "v:count == 0 ? \"gk\" : \"k\"", { expr = true }, opts)
keymap("n", "J", ":m .+1<CR><ESC>", opts)
keymap("n", "K", ":m .-2<CR><ESC>", opts)
keymap("v", "J", ":m .+1<CR><ESC>", opts)
keymap("v", "K", ":m .-2<CR><ESC>", opts)
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
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<C-w>", ":bdelete<CR>", opts)

-- telescope
keymap("n", "<leader>ff", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown {
		prompt_title = "Fuzzy Find",
		previewer = false,
		layout_config = {
			anchor = "N",
			prompt_position = "top"
		}
	})
end, opts)
keymap("n", "<leader>fd", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown {
		prompt_title = "~ dotfiles ~",
		cwd = "~/.dotfiles",
		hidden = true,
		layout_config = {
			height = 0.35
		}
	})
end, opts)
keymap("n", "<leader>fc", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown {
		prompt_title = "config files",
		cwd = "~/.config",
		hidden = true,
		layout_config = {
			height = 0.35
		}
	})
end, opts)
keymap("n", "<leader>fp", function()
	require("telescope").extensions.file_browser.file_browser {
		prompt_title = "Projects",
		cwd = "~/Projects",
		hidden = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = {
			height = 0.85,
			width = 0.75
		}
	}
end, opts)
keymap("n", "<leader>fg", function()
	require("telescope").extensions.file_browser.file_browser {
		prompt_title = "Git Repos",
		cwd = "~/git/hub/repos",
		hidden = true,
		previewer = false,
		layout_config = {
			height = 0.85,
			width = 0.75
		}
	}
end, opts)
keymap("n", "<C-f>", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
		prompt_title = "Fuzzy Find",
		previewer = false,
		layout_config = {
			anchor = "NE",
			prompt_position = "top"
		}
	})
end, opts)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- commenting
keymap("n", "<leader>c", function()
	require("Comment.api").toggle.linewise()
end, opts)
keymap("v", "<leader>c", function()
	require("Comment.api").toggle.linewise()
end, opts)
keymap("x", "<leader>c", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
	require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end, opts)

-- lspsaga / lsp navigation
keymap("n", "<leader><leader>", ":Lspsaga hover_doc<CR>", opts)
keymap("n", "gr", ":Lspsaga rename<CR>", opts)
keymap("n", "ga", ":Lspsaga code_action<CR>", opts)
keymap("n", "gd", ":Lspsaga preview_definition<CR>", opts)
keymap("n", "gl", ":Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "gL", ":Lspsaga diagnostic_jump_next<CR>", opts)
keymap("i", "<C-h>", "<cmd>Lspsaga signature_help<CR>", opts)

keymap("n", "gf", function()
	require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy {
		prompt_title = "References",
	})
end, opts)

keymap("n", "gi", function()
	vim.lsp.buf.implementation()
end, opts)
keymap("n", "gh", function()
	vim.lsp.buf.signature_help()
end, opts)
keymap("n", "gD", function()
	vim.lsp.buf.definition()
end, opts)

-- terminal
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", opts)
keymap("t", "<C-t>", "<cmd>ToggleTerm<CR>", opts)

require "alphakeks"
