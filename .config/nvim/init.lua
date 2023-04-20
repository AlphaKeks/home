
--[[      _    _       _           _  __    _          ]]--
--[[     / \  | |_ __ | |__   __ _| |/ /___| | _____   ]]--
--[[    / _ \ | | '_ \| '_ \ / _` | ' // _ \ |/ / __|  ]]--
--[[   / ___ \| | |_) | | | | (_| | . \  __/   <\__ \  ]]--
--[[  /_/   \_\_| .__/|_| |_|\__,_|_|\_\___|_|\_\___/  ]]--
--[[            |_|                                    ]]--
--[[                                                   ]]--

-- [[ Globals ]]--
vim.g.AlphaKeks = vim.api.nvim_create_augroup("AlphaKeks", { clear = true })
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_bufsettings = "rnu"

function Print(...)
	return vim.print(...)
end

function Reload(...)
	require("plenary.reload").reload_module(...)
	return require(...)
end

--[[ Basic Options ]]--

-- General options
vim.opt.confirm = true
vim.opt.shell = "/usr/bin/zsh"
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

-- Indentation
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.textwidth = 100
vim.opt.formatoptions = "crqn2lj"

-- Default colorscheme
vim.cmd.colorscheme("habamax")

-- Rust overrides some of the options so I just override that with an autocommand.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	group = vim.g.AlphaKeks,
	callback = function()
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
})

--[[ Autocommands ]]--

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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<ESC>", vim.cmd.nohlsearch)

vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<C-s>", vim.cmd.write)

vim.keymap.set("n", "<C-w>", vim.cmd.close)

vim.keymap.set("n", "U", "<C-r>")

vim.keymap.set("n", "x", "\"_x")

vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>Y", "\"+y$")

vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<Leader>P", "\"+P")

vim.keymap.set("n", "J", "V:m '>+1<CR>gv=gv<ESC>")
vim.keymap.set("n", "K", "V:m '<-2<CR>gv=gv<ESC>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<Leader>ss", vim.cmd.split)
vim.keymap.set("n", "<Leader>vs", vim.cmd.vsplit)

vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>wincmd h<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>wincmd j<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>wincmd k<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>wincmd l<CR>")

for i = 1, 9, 1 do
	vim.keymap.set({ "n", "t" }, "<C-" .. i .. ">", i .. "gt")
end

vim.keymap.set({ "n", "t" }, "<C-Up>", "<CMD>resize +2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Down>", "<CMD>resize -2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Right>", "<CMD>vertical resize +2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Left>", "<CMD>vertical resize -2<CR>")

vim.keymap.set({ "n", "t" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "t" }, "<C-u>", "<C-u>zz")

vim.keymap.set("t", "<C-ESC>", "<C-\\><C-n>")

vim.keymap.set({ "n", "t" }, "<C-t>", function()
	vim.cmd.tabnew()
	vim.cmd.term()
end)

--[[ Plugins ]]--
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

lazy.setup({
	{ "catppuccin/nvim", name = "catppuccin" },

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	{ "numToStr/Comment.nvim" },

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"simrat39/rust-tools.nvim",
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"ThePrimeagen/harpoon",
		},
	},

	{
		"TimUntersberger/neogit",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"sindrets/diffview.nvim"
		},
	},

	{
		"freddiehaddad/feline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
})

--[[ Catppuccin ]]--
local catppuccin = require("catppuccin")

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
		TelescopeBorder = { fg = Colors.poggers },
		TreesitterContext = { bg = Colors.none },
	}
})

vim.cmd.colorscheme("catppuccin")

--[[ Treesitter ]]--
local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	ensure_installed = { "vim", "vimdoc", "lua", "rust", "javascript", "typescript" },
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
		},
	},

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

local treesitter_context = require("treesitter-context")
treesitter_context.setup({ enable = true })

--[[ Comment.nvim ]]--
local comment = require("Comment")

comment.setup({
	-- I don't like the default mappings.
	mappings = {
		basic = false,
		extra = false,
	}
})

vim.keymap.set("n", "<Leader>c", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("v", "<Leader>c", "<Plug>(comment_toggle_blockwise_visual)")
vim.keymap.set("x", "<Leader>c", "<Plug>(comment_toggle_linewise_visual)")

--[[ Completion ]]--
local cmp = require("cmp")
local luasnip = require("luasnip")

local kz_map_source = {}

kz_map_source.new = function()
	local self = setmetatable({ cache = {} }, { __index = kz_map_source })
	return self
end

kz_map_source.complete = function(self, _, callback)
	if self.cache[1] then
		callback({ items = self.cache[1], isIncomplete = false})
		return
	end

	require("plenary.job")
		:new({
			"curl",
			"-L",
			"https://kztimerglobal.com/api/v2/maps?limit=9999",

			on_exit = function(job)
				local result = job:result()
				local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
				if not ok then
					vim.notify("Failed to parse maps.")
					return
				end

				local items = {}
				for _idx, kz_map in ipairs(parsed) do
					kz_map.body = string.gsub(kz_map.body or "", "\r", "")

					table.insert(items, {
						label = kz_map.name,
						cmp = {
							kind_hl_group = "CmpItemKindKZ",
							kind_text = "KZ",
						},
						documentation = {
							kind = "markdown",
							value = string.format(
								"# %s\n\n* Tier: %s\n* Global: %s\n* Workshop: %s\n\n* KZ:GO: %s",
								kz_map.name, kz_map.difficulty, kz_map.validated,
								kz_map.workshop_url, "https://kzgo.eu/maps/" .. kz_map.name
							),
						},
					})
				end

				callback({ items = items, isIncomplete = false })
				self.cache[1] = items
			end
		})
		:start()
end

require("cmp").register_source("kz_maps", kz_map_source.new())

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Right>"] = cmp.mapping.confirm({ select = true }),
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
		{ name = "kz_maps", keyword_length = 3, max_item_count = 10 },
		{ name = "path" },
	},
	formatting = {
		expandable_indicator = false,
		format = function(entry, item)
			item.menu = ""
			item.kind = ({
				Text = "", Method = "", Function = "", Constructor = "",
				Field = "", Variable = "", Class = "", Interface = "",
				Module = "", Property = "", Unit = "", Value = "", Enum = "",
				Keyword = "", Snippet = "", Color = "", File = "", Reference = "",
				Folder = "", EnumMember = "", Constant = "", Struct = "",
				Event = "", Operator = "", TypeParameter = "", KZ = "♿",
			})[item.kind] or "?"
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

			local node_type = vim.treesitter.get_node():type()

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

local function format_on_save(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.g.AlphaKeks,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
		end
	})
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
		on_attach = function(client, bufnr)
			lsp_keymaps(bufnr)
			highlight_words(bufnr)
			format_on_save(bufnr)

			client.server_capabilities.semanticTokensProvider = nil
		end,
		capabilities = LspCapabilities,
		cmd = { "rustup", "run", "stable", "rust-analyzer" },
		settings = {
			["rust-analyzer"] = {
				cargo = { features = "all" },
				checkOnSave = {
					enable = true,
					command = "clippy",
					features = "all",
				},
			},
		},
	},
})

lspconfig["tsserver"].setup({
	on_attach = function(client, bufnr)
		lsp_keymaps(bufnr)
		highlight_words(bufnr)
		format_on_save(bufnr)

		client.server_capabilities.semanticTokensProvider = nil
	end
})

require("mason").setup()

vim.diagnostic.config({
	virtual_text = {
		source = false,
		prefix = "",
		severity = vim.diagnostic.severity.ERROR,
	},
	underline = false,
	severity_sort = true,
	float = {
		focusable = true,
		source = "always",
		prefix = "• ",
		border = "single",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{ border = "single" }
)

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
	builtin.find_files(themes.get_ivy({
		hidden = true,
		follow = true,
		layout_config = {
			height = 0.4,
		},
	}))
end)

vim.keymap.set("n", "<leader>df", function()
	builtin.git_files(themes.get_ivy({
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

--[[ Neogit && Gitsigns ]]--
local neogit = require("neogit")
local gitsigns = require("gitsigns")

neogit.setup({
	disable_context_highlighting = true,
	commit_popup = { kind = "vsplit" },
	popup = { kind = "split" },
	integrations = { diffview = true },
})

gitsigns.setup()

vim.keymap.set("n", "<Leader>gb", gitsigns.blame_line)
vim.keymap.set("n", "<Leader>gB", function()
	gitsigns.blame_line({ full = true })
end)

vim.keymap.set("n", "<Leader>gs", neogit.open)

--[[ Feline ]]--
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

vim.opt.showmode = false

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
					icon = " ",
					hl = { fg = Colors.yellow, bg = bg_color }
				},
				filler,
				filler,
				{
					provider = "git_diff_added",
					icon = " ",
					hl = { fg = Colors.green, bg = bg_color }
				},
				filler,
				filler,
				{
					provider = "git_diff_changed",
					icon = " ",
					hl = { fg = Colors.yellow, bg = bg_color }
				},
				filler,
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
