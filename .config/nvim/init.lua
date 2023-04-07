--[[      _    _       _           _  __    _          ]]--
--[[     / \  | |_ __ | |__   __ _| |/ /___| | _____   ]]--
--[[    / _ \ | | '_ \| '_ \ / _` | ' // _ \ |/ / __|  ]]--
--[[   / ___ \| | |_) | | | | (_| | . \  __/   <\__ \  ]]--
--[[  /_/   \_\_| .__/|_| |_|\__,_|_|\_\___|_|\_\___/  ]]--
--[[            |_|                                    ]]--
--[[                                                   ]]--
-----------------------------------------------------------

-- [[ Globals ]]--
vim.g.AlphaKeks = vim.api.nvim_create_augroup("AlphaKeks", { clear = true })
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_bufsettings = "rnu"

function Print(...)
	return vim.pretty_print(...)
end

--[[ Basic Options ]]--
-- You can read the help docs for any of these to find out
-- what they do. E.g.
-- :h 'confirm'

function Options()
	-- General options
	vim.opt.confirm = true
	vim.opt.shell = "/usr/bin/fish"
	vim.opt.undofile = true
	vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
	vim.opt.swapfile = false
	vim.opt.mouse = ""
	vim.opt.updatetime = 69
	vim.opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" }
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
	vim.opt.showmatch = true
	vim.opt.matchtime = 1

	-- UI options
	vim.opt.termguicolors = true
	vim.opt.colorcolumn = "100"
	vim.opt.cursorline = true
	vim.opt.fillchars = { fold = " " }
	vim.opt.foldenable = false
	vim.opt.foldlevel = 1
	vim.opt.foldmethod = "indent"
	vim.opt.guicursor = "a:block,i:ver20,v-r:hor20"
	vim.opt.hlsearch = true
	vim.opt.laststatus = 3
	vim.opt.list = true
	vim.opt.listchars = {
		tab = "│ ",
		trail = "-",
	}
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.scrolloff = 12
	vim.opt.signcolumn = "yes"
	vim.opt.splitbelow = true
	vim.opt.splitright = true

	-- Indenting
	vim.opt.autoindent = true
	vim.opt.breakindent = true
	vim.opt.smartindent = true
	vim.opt.expandtab = false
	vim.opt.tabstop = 3
	vim.opt.shiftwidth = 3
	vim.opt.textwidth = 100
	vim.opt.formatoptions = "crqn2lj"

end

-- Default colorscheme
vim.cmd.colorscheme("habamax")

-- Some filetypes override some of the
-- options so I just override that with
-- an autocommand.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	group = vim.g.AlphaKeks,
	callback = Options
})

--[[ Autocommands ]]--
-- Event listeners that execute a `callback` function
-- whenever a specific event fires.
-- :h autocmd

-- Highlight a yanked region for a brief moment after yanking.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.highlight.on_yank({ timeout = 69 })
	end
})

-- Change some options when opening a terminal buffer.
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = true
		vim.wo.scrolloff = 0
	end
})

--[[ Keymaps ]]--
-- :h vim.keymap.set

-- Space as leader key. (:h mapleader)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable highlights after a search with escape
vim.keymap.set("n", "<ESC>", vim.cmd.nohlsearch)

-- Open filetree
vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)

-- Save current buffer
vim.keymap.set("n", "<C-s>", vim.cmd.write)

-- Close current window
vim.keymap.set("n", "<C-w>", vim.cmd.close)

-- Set `U` as "redo" because I find it more intuitive than C-r
vim.keymap.set("n", "U", "<C-r>")

-- Don't yank single characters when deleting them
vim.keymap.set("n", "x", "\"_x")

-- Yank to the system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>Y", "\"+y$")

-- Paste from the system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<Leader>P", "\"+P")

-- Move lines up and down
vim.keymap.set("n", "J", "V:m '>+1<CR>gv=gv<ESC>")
vim.keymap.set("n", "K", "V:m '<-2<CR>gv=gv<ESC>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Indent by just pressing `<` and `>` once
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

-- Keep selection after indenting it
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Create windows
vim.keymap.set({ "n", "t" }, "<Leader>ss", vim.cmd.split)
vim.keymap.set({ "n", "t" }, "<Leader>vs", vim.cmd.vsplit)

-- Navigate between windows
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>wincmd h<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>wincmd j<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>wincmd k<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>wincmd l<CR>")

-- Navigate tabs with CTRL + <number>
for i = 1, 9, 1 do
	vim.keymap.set({ "n", "t" }, "<C-" .. i .. ">", i .. "gt")
end

-- Resize windows
vim.keymap.set({ "n", "t" }, "<C-Up>", "<CMD>resize +2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Down>", "<CMD>resize -2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Right>", "<CMD>vertical resize +2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Left>", "<CMD>vertical resize -2<CR>")

-- Center the cursor when jumping up and down
vim.keymap.set({ "n", "t" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "t" }, "<C-u>", "<C-u>zz")

-- Escape terminal mode without a more sane shortcut
vim.keymap.set("t", "<C-ESC>", "<C-\\><C-n>")

-- Open a terminal in a new tab
vim.keymap.set({ "n", "t" }, "<C-t>", function()
	vim.cmd.tabnew()
	vim.cmd.term()
end)

--[[ Plugins ]]--
-- I use `lazy.nvim` as my plugin manager.
-- GitHub: https://github.com/folke/lazy.nvim

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if Lazy is already installed.
-- If it isn't -> install it.
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git", "clone", "--branch=stable",
		"https://github.com/folke/lazy.nvim",
		lazy_path
	})

	vim.notify("Installed Lazy.")
end

vim.opt.rtp:prepend(lazy_path)

local lazy_installed, lazy = pcall(require, "lazy")
if not lazy_installed then
	print("Lazy is not installed. Plugins are disabled.")
	return
end

-- List of all plugins that should be installed.
lazy.setup({
	-- Catppuccin, the best theme of all time
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Treesitter for syntax highlighting and context-aware motions
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	-- Comment/Uncomment lines/selections using Treesitter
	{ "numToStr/Comment.nvim" },

	{
		-- Completion engine
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
	},

	{
		-- LSP preset configurations and better APIs than the builtins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Package manager for language servers, formatters and linters
			"williamboman/mason.nvim",

			-- Additional features for rust-analyzer like inlay hints and automatic
			-- reloading when changing dependencies.
			"simrat39/rust-tools.nvim",
		},
	},

	{
		-- Telescope for fuzzy finding
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"ThePrimeagen/harpoon",
		},
	},

	-- Git integration
	{
		"TimUntersberger/neogit",
		dependencies = { "lewis6991/gitsigns.nvim" },
	},

	-- Statusline
	{ "freddiehaddad/feline.nvim" },
})

--[[ Catppuccin ]]--
-- :h catppuccin.txt
local catppuccin = require("catppuccin")

-- Setup global color palette
Colors = require("catppuccin.palettes").get_palette("mocha")
Colors.none = "NONE"
Colors.slate = "#3C5E7F"
Colors.poggers = "#7480C2"

catppuccin.setup({
	flavour = "mocha",
	transparent_background = true,
	no_italic = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		harpoon = true,
		markdown = true,
		mason = true,
		neogit = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		native_lsp = { enabled = true },
	},
	custom_highlights = {
		Comment = { fg = Colors.slate },
		Constant = { fg = Colors.red },
		String = { fg = Colors.lavender },
		Number = { fg = Colors.red },
		Float = { link = "Numer" },
		Boolean = { link = "Number" },
		Identifier = { fg = Colors.lavender },
		Operator = { fg = Colors.yellow },
		StorageClass = { fg = Colors.sapphire },
		Structure = { fg = Colors.poggers },
		Type = { fg = Colors.poggers, bold = true },
		Typedef = { fg = Colors.poggers, bold = true },
		Delimiter = { fg = Colors.sapphire },
		ColorColumn = { bg = Colors.surface0 },
		CursorLine = { link = "ColorColumn" },
		CursorLineNr = { fg = Colors.yellow },
		EndOfBuffer = { fg = Colors.mauve },
		Search = { fg = Colors.mantle, bg = Colors.yellow },
		CurSearch = { fg = "#FFFFFF", bg = Colors.red },
		IncSearch = { fg = Colors.text, bg = Colors.poggers },
		MatchParen = { fg = Colors.lavender },
		Whitespace = { fg = Colors.surface2 },
		WinSeparator = { fg = Colors.none, bg = Colors.none },
		NormalFloat = { bg = Colors.none },
		FloatShadow = { bg = Colors.none },
		FloatShadowThrough = { bg = Colors.none },
		DiagnosticHint = { bg = Colors.none },
		DiagnosticInfo = { bg = Colors.none },
		DiagnosticWarn = { bg = Colors.none },
		DiagnosticError = { bg = Colors.none },
		DiagnosticVirtualTextHint = { bg = Colors.none },
		DiagnosticVirtualTextInfo = { bg = Colors.none },
		DiagnosticVirtualTextWarn = { bg = Colors.none },
		DiagnosticVirtualTextError = { bg = Colors.none },
		TelescopeBorder = { fg = Colors.slate },
	}
})

-- Load colorscheme
vim.cmd.colorscheme("catppuccin")

--[[ Treesitter ]]--
-- :h treesitter
-- :h nvim-treesitter
-- :h nvim-treesitter-textobjects
local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	-- Make sure these are installed.
	-- NOTE: `vimdoc` used to be called `help`
	ensure_installed = { "vim", "vimdoc", "lua", "rust", "javascript", "typescript" },
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },

	-- Select "semantic regions" incrementally
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
		},
	},

	-- Extend the standard vim motions with treesitter.
	-- This enables things like `dif` (delete inside function)
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ic"] = "@class.inner",
				["ac"] = "@class.outer",
			},
		},
	},
})

-- This will keep the current scope (e.g. function) at the
-- top of the screen
local treesitter_context = require("treesitter-context")
treesitter_context.setup({ enable = true })

--[[ Comment.nvim ]]--
-- :h comment-nvim
local comment = require("Comment")

comment.setup({
	-- I don't like the default mappings.
	mappings = {
		basic = false,
		extra = false,
	}
})

-- Comment out whole line
vim.keymap.set("n", "<Leader>c", "<Plug>(comment_toggle_linewise_current)")

-- Comment out all lines in a selection
vim.keymap.set("v", "<Leader>c", "<Plug>(comment_toggle_blockwise_visual)")

-- Comment out _just_ the selection
vim.keymap.set("x", "<Leader>c", "<Plug>(comment_toggle_linewise_visual)")

--[[ Completion ]]--
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then cmp.select_next_item()
			else fallback()
			end
		end),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then cmp.select_prev_item()
			else fallback()
			end
		end),
		["<C-n>"] = function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end,
		["<C-p>"] = function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end,
	}),
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	},
	formatting = {
		expandable_indicator = false,
		format = function(_, item)
			item.menu = ""
			item.kind = ({
				Text = "", Method = "", Function = "", Constructor = "",
				Field = "", Variable = "", Class = "", Interface = "",
				Module = "", Property = "", Unit = "", Value = "", Enum = "",
				Keyword = "", Snippet = "", Color = "", File = "", Reference = "",
				Folder = "", EnumMember = "", Constant = "", Struct = "",
				Event = "", Operator = "", TypeParameter = "",
			})[item.kind]
			return item
		end
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	experimental = { ghost_text = true },
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	}
})

LspCapabilities = vim.lsp.protocol.make_client_capabilities()
LspCapabilities = require("cmp_nvim_lsp").default_capabilities(LspCapabilities)

--[[ LSP ]]--
local lspconfig = require("lspconfig")

-- Highlight the word under the cursor
local function highlight_words(bufnr)
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = vim.g.AlphaKeks,
		buffer = bufnr,
		callback = function()
			local treesitter_utils = require("nvim-treesitter.ts_utils")

			local current_node = treesitter_utils.get_node_at_cursor()
			if not current_node then return end

			local node_text = vim.treesitter.get_node_text(current_node, 0)
			if vim.g.CurrentNode == node_text then return end

			vim.g.CurrentNode = node_text
			vim.lsp.buf.clear_references()

			local node_type = vim.treesitter.get_node_at_cursor()

			if node_type == "identifier" or node_type == "property_identifier" then
				vim.lsp.buf.document_highlight()
			end
		end
	})
end

local function lsp_keymaps(bufnr)
	local function bufmap(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
	end

	bufmap("n", "<Leader><Leader>", vim.lsp.buf.hover)
	bufmap("n", "gd", vim.lsp.buf.definition)
	bufmap("n", "gD", vim.lsp.buf.type_definition)
	bufmap("n", "ga", vim.lsp.buf.code_action)
	bufmap("n", "gl", vim.diagnostic.open_float)
	bufmap("n", "gL", vim.diagnostic.goto_next)
	bufmap("n", "gr", function()
		vim.ui.input({ prompt = "New Name: " }, function(input)
			if input then
				vim.lsp.buf.rename(input)
			end
		end)
	end)
	bufmap("i", "<C-h>", vim.lsp.buf.signature_help)

	bufmap("n", "gp", function()
		vim.api.nvim_open_win(0, true, {
			relative = "cursor",
			width = math.floor(0.4 * vim.o.columns),
			height = math.floor(0.35 * vim.o.lines),
			col = 0,
			row = 1,
			style = "minimal",
			border = "single",
		})

		vim.lsp.buf.definition()
		vim.wo.relativenumber = true
		local win_id = vim.fn.get_windid()

		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(win_id, true)
			vim.keymap.del("n", "q")
		end)
	end)
end

local rust_tools = require("rust-tools")

rust_tools.setup({
	tools = {
		reload_workspace_from_cargo_toml = true,
		inlay_hints = {
			only_current_line = false,
			show_parameter_hints = false,
			other_hints_prefix = "",
		},
	},
	server = {
		standalone = true,
		on_attach = function(_, bufnr)
			lsp_keymaps(bufnr)
			highlight_words(bufnr)

			-- Format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.g.AlphaKeks,
				callback = function()
					vim.lsp.buf.format({ async = true })
				end
			})
		end,
		capabilities = LspCapabilities,
		cmd = { "rustup", "run", "stable", "rust-analyzer" },
		settings = {
			cargo = { features = "all" },
			checkOnSave = {
				enable = true,
				command = "clippy",
				features = "all",
			},
		},
	},
})

lspconfig["tsserver"].setup({
	on_attach = function(client, bufnr)
		lsp_keymaps(bufnr)
		highlight_words(bufnr)

		-- Disable formatting from tsserver
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false

		-- Run Prettier on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.g.AlphaKeks,
			buffer = bufnr,
			callback = function()
				local cwd = vim.fn.expand("%:h")
				local prettier_output = vim.fn.system("npx prettier " .. cwd)
				local lines = {}

				for line in prettier_output:gmatch("([^\n]+)") do
					table.insert(lines, line)
				end

				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			end
		})
	end
})

local mason = require("mason")
mason.setup()

--[[ Telescope ]]--
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
	defaults = {
		mappings = {
			["i"] = {
				["<ESC>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		["file_browser"] = {
			hijack_netrw = true,
			hidden = true,
			previewer = true,
			initial_mode = "normal",
			mappings = {
				["n"] = {
					["a"] = fb_actions.create,
					["d"] = fb_actions.remove,
					["r"] = fb_actions.rename
				},
				["i"] = {
					["<C-a>"] = fb_actions.create,
					["<C-d>"] = fb_actions.remove,
					["<C-r>"] = fb_actions.rename,
					["<ESC>"] = actions.close,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous
				}
			},
		},
		["ui-select"] = {
			themes.get_ivy({
				layout_config = {
					height = 0.3,
				},
			}),
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("file_browser")

local default_finder = themes.get_ivy({
	layout_config = {
		height = 0.4,
	},
})

vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader>fh", builtin.help_tags)

vim.keymap.set("n", "<Leader>ff", function()
	builtin.git_files(themes.get_ivy({
		hidden = true,
		follow = true,
		layout_config = {
			height = 0.4,
		},
	}))
end)

vim.keymap.set("n", "<leader>df", function()
	builtin.find_files(themes.get_ivy({
		cwd = os.getenv("HOME") .. "/.dotfiles",
		hidden = true,
		follow = true,
		layout_config = {
			height = 0.4,
		},
	}))
end)

vim.keymap.set("n", "<leader>fl", function()
	builtin.live_grep(themes.get_ivy({
		hidden = true,
		follow = true,
		layout_config = {
			height = 0.4,
		},
		glob_patterns = {
			"!node_modules/*",
			"!target/*",
		},
	}))
end)

vim.keymap.set("n", "<leader>fd", function()
	builtin.diagnostics(default_finder)
end)

vim.keymap.set("n", "<leader>fs", function()
	builtin.lsp_workspace_symbols(default_finder)
end)

vim.keymap.set("n", "<leader>fr", function()
	builtin.lsp_references(default_finder)
end)

vim.keymap.set("n", "<Leader>e", function()
	telescope.extensions.file_browser.file_browser(themes.get_dropdown({
		previewer = false,
		hidden = true,
		cwd = vim.fn.expand("%:p:h"),
		initial_mode = "normal",
		layout_config = {
			height = 0.9,
			width = 0.9,
		},
	}))
end)

local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

vim.keymap.set("n", "<Leader>j", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<Leader>a", harpoon_mark.add_file)

vim.keymap.set("n", "<F1>", function()
	harpoon_ui.nav_file(1)
end)

vim.keymap.set("n", "<F2>", function()
	harpoon_ui.nav_file(2)
end)

vim.keymap.set("n", "<F3>", function()
	harpoon_ui.nav_file(3)
end)

vim.keymap.set("n", "<F4>", function()
	harpoon_ui.nav_file(4)
end)

local neogit = require("neogit")
local gitsigns = require("gitsigns")

neogit.setup({
	disable_context_highlighting = true,
	commit_popup = { kind = "vsplit" },
	popup = { kind = "split" },
})

gitsigns.setup()

vim.keymap.set("n", "<Leader>gb", gitsigns.blame_line)
vim.keymap.set("n", "<Leader>gB", function()
	gitsigns.blame_line({ full = true })
end)

vim.keymap.set("n", "<Leader>gs", neogit.open)

local feline = require("feline")
local lsp_status = require("feline.providers.lsp")
local severity = vim.diagnostic.severity
local bg_color = Colors.base

local modes = {
	["n"] = "NORMAL",
	["no"] = "N-PENDING",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["t"] = "TERMINAL",
	["v"] = "VISUAL",
	["V"] = "V-LINE",
	[""] = "V-BLOCK",
	["R"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["s"] = "SELECT",
	["S"] = "S-LINE",
	[""] = "S-BLOCK",
	["c"] = "COMMAND",
	["cv"] = "COMMAND",
	["ce"] = "COMMAND",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
}

local filler = {
	provider = "█",
	hl = { fg = bg_color, bg = bg_color }
}

feline.setup({
	components = {
		active = {
			{
				filler,
				filler,
				{
					provider = function()
						return modes[vim.fn.mode()]
					end,
					hl = { fg = Colors.lavender, bg = bg_color },
				},
				filler,
				filler,
				{
					provider = "git_branch",
					icon = " ",
					hl = { fg = Colors.yellow, bg = bg_color }
				},
				filler,
				{
					provider = "git_diff_added",
					icon = " ",
					hl = { fg = Colors.green, bg = bg_color }
				},
				filler,
				{
					provider = "git_diff_changed",
					icon = " ",
					hl = { fg = Colors.yellow, bg = bg_color }
				},
				filler,
				{
					provider = "git_diff_removed",
					icon = " ",
					hl = { fg = Colors.red, bg = bg_color }
				},
			},
			{
				{
					provider = function()
						local progress = vim.lsp.util.get_progress_messages()
						if progress[1] then
							local msg = ""
							if progress[1].title then
								msg = progress[1].title
							end
							if progress[1].message then
								msg = string.format("%s %s", msg, progress[1].message)
							end
							if progress[1].percentage then
								msg = string.format("%s (%s%%%%)", msg, progress[1].percentage)
							end
							return msg
						else
							return ""
						end
					end,
					hl = { fg = Colors.lavender, bg = bg_color }
				}
			},
			{
				{
					provider = function()
						return string.format("<%s>", vim.opt.filetype._value)
					end,
					hl = { fg = Colors.surface2, bg = bg_color }
				},
				filler,
				{
					provider = "diagnostic_hints",
					enabled = function()
						return lsp_status.diagnostics_exist(severity.HINT)
					end,
					icon = " ",
					hl = { fg = Colors.text, bg = bg_color }
				},
				filler,
				{
					provider = "diagnostic_info",
					enabled = function()
						return lsp_status.diagnostics_exist(severity.INFO)
					end,
					icon = " ",
					hl = { fg = Colors.teal, bg = bg_color }
				},
				filler,
				{
					provider = "diagnostic_warnings",
					enabled = function()
						return lsp_status.diagnostics_exist(severity.WARN)
					end,
					icon = " ",
					hl = { fg = Colors.yellow, bg = bg_color }
				},
				filler,
				{
					provider = "diagnostic_errors",
					enabled = function()
						return lsp_status.diagnostics_exist(severity.ERROR)
					end,
					icon = " ",
					hl = { fg = Colors.red, bg = bg_color }
				},
				filler,
				{
					provider = function()
						if next(vim.lsp.buf_get_clients()) ~= nil then
							return " "
						else
							return ""
						end
					end,
					hl = { fg = Colors.blue, bg = bg_color }
				}
			}
		}
	}
})
