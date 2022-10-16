local settings = {
	backup = false,
	bufhidden = "wipe",
	cdhome = true,
	confirm = true,
	fileencoding = "utf-8",
	filetype = "on",
	hidden = true,
	mouse = "",
	mousehide = true,
	swapfile = false,
	undodir = "/home/max/.config/nvim/undo",
	undofile = true,
	updatetime = 50,

	autoindent = true,
	breakindent = true,
	copyindent = true,
	expandtab = false,
	preserveindent = true,
	smartindent = true,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,

	cursorline = true,
	formatoptions = "crqn2lj",
	guicursor = "a:block,i:ver50,v:hor50,r:hor50",
	guifont = "JetBrains Mono:h16",
	helpheight = 8,
	laststatus = 3,
	list = false,
	listchars = {
		tab = "» ",
		space = "·"
	},
	menuitems = 8,
	number = true,
	pumheight = 8,
	relativenumber = true,
	scrolloff = 8,
	showmode = false,
	sidescrolloff = 8,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	textwidth = 0,
	wrap = true,
	wrapmargin = 8,

	hlsearch = false,
	incsearch = true,
	ignorecase = true
}

for name, value in pairs(settings) do
	vim.opt[name] = value
end

-- show whitespaces when in visual mode
local wgroup = vim.api.nvim_create_augroup("WhitespaceToggle", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = { "*:v", "*:V" },
	callback = function()
		vim.opt.list = true
	end,
	group = wgroup
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = { "v:*", "V:*" },
	callback = function()
		vim.opt.list = false
	end,
	group = wgroup
})

-- stop overriding my settings god damnit
local fuckoffgroup = vim.api.nvim_create_augroup("FuckOff", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.formatoptions = "crqn2lj"
		vim.opt.textwidth = 0
	end,
	group = fuckoffgroup
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown" },
	callback = function()
		vim.opt.formatoptions = "tcrqn2lj"
		vim.opt.textwidth = 80
	end,
	group = fuckoffgroup
})
