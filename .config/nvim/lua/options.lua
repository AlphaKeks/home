vim.opt.confirm = true
vim.opt.filetype = "off"
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
vim.opt.undofile = true
vim.opt.updatetime = 69
vim.opt.breakindent = true
vim.opt.copyindent = true
vim.opt.expandtab = false
vim.opt.preserveindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"
vim.opt.formatoptions = "crqn2lj"
vim.opt.textwidth = 100
vim.opt.guicursor = "a:block,i:ver20,v:hor20,r-cr-o:hor20"
-- vim.opt.guicursor = "a:block,v:hor20,r-cr-o:hor20"
vim.opt.guifont = "Fira Code NF:h16"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "│ " }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us", "de_de" }
vim.opt.spelloptions = { "camel", "noplainbuffer" }
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" },

vim.cmd.colorscheme("quiet")


vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0
