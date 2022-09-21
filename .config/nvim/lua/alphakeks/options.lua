local options = {
	-- meta settings
	backup = false,
	belloff = 'all',
	bufhidden = 'wipe',
	cdhome = true,
	confirm = true,
	errorbells = false,
	fileencoding = 'utf-8',
	icon = true,
	mousehide = true,
	swapfile = false,
	undodir = '/home/max/.config/nvim/undo',
	undofile = true,
	updatetime = 50,
	verbose = 0,
	visualbell = false,

	-- indentation
	autoindent = true,
	breakindent = true,
	copyindent = true,
	expandtab = false,
	preserveindent = true,
	smartindent = true,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,

	-- visuals
	background = 'dark',
	cmdheight = 1,
	cursorcolumn = false,
	cursorline = true,
	guicursor = 'a:block,i:ver50,v:hor50,r:hor50',
	guifont = 'JetBrains Mono:h16',
	helpheight = 8,
	list = false,
	listchars = {
		tab = '  |',
		space = '·',
	},
	menuitems = 8,
	number = true,
	pumheight = 8,
	relativenumber = true,
	scrolloff = 8,
	showmode = false,
	sidescroll = 1,
	sidescrolloff = 8,
	signcolumn = 'yes',
	splitbelow = true,
	splitright = true,
	syntax = 'ON',
	termguicolors = true,
	wrap = true,
	wrapmargin = 8,

	-- search settings
	hlsearch = false,
	incsearch = true,
	ignorecase = true
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- show whitespaces when in visual mode
local wgroup = vim.api.nvim_create_augroup('WhitespaceToggle', { clear = true })

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = { '*:v', '*:V' },
	callback = function()
		vim.opt.list = true
	end,
	group = wgroup
})

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = { 'v:*', 'V:*' },
	callback = function()
		vim.opt.list = false
	end,
	group = wgroup
})
