-- imports
require("plugins")
require("base")
require("extra")

-- settings
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.pumheight = 10
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.guifont = "firacode:h17"
vim.opt.fillchars.eob = " "
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

vim.g.neovide_refresh_rate = 240
vim.g.neovide_transparency = 0.85
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_animation_length = 0.01
vim.g.neovide_cursor_trail_length = 0.1
vim.g.neovide_cursor_antialiasing = true

-- keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- NORMAL --
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<C-w>", ":bdelete<CR>", opts)

keymap("n", "<A-j>", "<ESC>:m .+1<CR><ESC>", opts)
keymap("n", "<A-k>", "<ESC>:m .-2<CR><ESC>", opts)

keymap("n", "U", "<C-R>", opts)

-- VISUAL --
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gc", opts)
keymap("v", "<A-j>", "<ESC>:m .+1<CR><ESC>", opts)
keymap("v", "<A-k>", "<ESC>:m .-2<CR><ESC>", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Plugins --
keymap("n", "<leader>e", ":NvimTreeToggle<CR>:NvimTreeRefresh<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<C-f>", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>c", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>c", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", opts)
keymap("t", "<C-t>", "<cmd>ToggleTerm<CR>", opts)
--keymap("n", "<C-s>", ":lua vim.lsp.buf.formatting()<CR>", opts)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "<A-s>", "<cmd>JuliaFormatterFormat<CR>", opts)

-- theme
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
	return
end
catppuccin.setup({})
vim.cmd([[colorscheme catppuccin]])
