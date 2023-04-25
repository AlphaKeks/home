
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
	return vim.print(vim.inspect(...))
end

function Reload(...)
	require("plenary.reload").reload_module(...)
	return require(...)
end

vim.api.nvim_create_user_command("Messages", function()
	local messages = vim.api.nvim_exec2("messages", { output = true }).output
	if messages:len() == 0 then
		return
	end

	local lines = vim.split(messages, "\n")

	vim.cmd("new | setlocal buftype=nofile bufhidden=wipe nonu rnu")
	vim.api.nvim_put(lines, "l", false, true)
end, {})

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
vim.opt.path:append("**/*")

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

-- Rust overrides some of the options so I just override that with an autocommand.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "javascript", "typescript" },
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

vim.keymap.set("n", "<C-h>", "<CMD>wincmd h<CR>")
vim.keymap.set("n", "<C-j>", "<CMD>wincmd j<CR>")
vim.keymap.set("n", "<C-k>", "<CMD>wincmd k<CR>")
vim.keymap.set("n", "<C-l>", "<CMD>wincmd l<CR>")

for i = 1, 9, 1 do
	vim.keymap.set({ "n", "t" }, "<C-" .. i .. ">", i .. "gt")
end

vim.keymap.set({ "n", "t" }, "<C-Up>", "<CMD>resize +2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Down>", "<CMD>resize -2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Right>", "<CMD>vertical resize +2<CR>")
vim.keymap.set({ "n", "t" }, "<C-Left>", "<CMD>vertical resize -2<CR>")

vim.keymap.set("t", "<C-l>", "<C-l>")

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
	vim.cmd.colorscheme("habamax")
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
		"sourcegraph/sg.nvim",
		build = "cargo build --workspace",
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-tree/nvim-web-devicons" },
			},
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
		["<C-n>"] = function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<C-p>"] = function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
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
				Event = "", Operator = "", TypeParameter = "", KZ = "KZ",
			})[item.kind] or "?"
			return item
		end
	},
	-- window = {
	-- 	completion = cmp.config.window.bordered(),
	-- 	documentation = cmp.config.window.bordered()
	-- },
	experimental = { ghost_text = true },
	views = { entries = "native" },
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
			themes.get_cursor(),
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

vim.keymap.set("n", "<Leader>fh", function()
	builtin.help_tags(themes.get_ivy({
		layout_config = {
			height = 0.4,
		},
	}))
end)

vim.keymap.set("n", "<Leader>df", function()
	builtin.git_files(themes.get_ivy({
		cwd = os.getenv("HOME") .. "/.dotfiles",
		hidden = true,
		follow = true,
		layout_config = {
			height = 0.4,
		},
	}))
end)

vim.keymap.set("n", "<Leader>fl", function()
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

vim.keymap.set("n", "<Leader>fd", function()
	builtin.diagnostics(default_finder)
end)

vim.keymap.set("n", "<Leader>fs", function()
	builtin.lsp_workspace_symbols(default_finder)
end)

vim.keymap.set("n", "<Leader>fr", function()
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

--[[ Sourcegraph ]]--
local sg = require("sg")
local sg_telescope = require("sg.telescope")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

sg.setup({
	on_attach = function(client, bufnr)
		lsp_keymaps(bufnr)

		client.server_capabilities.semanticTokensProvider = nil

		vim.keymap.set("n", "<Leader>e", ":e %:h<CR>")
		vim.keymap.set("n", "<Leader>ff", sg_telescope.fuzzy_search_results)
		vim.keymap.set("n", "<Leader>fr", sg_telescope.sg_references)
	end
})

local function open_sg_link(input)
	if not input then return end
	-- https://github.com/sourcegraph/sg.nvim/blob/master/crates/sg-nvim/src/lib.rs
	-- --> sg://github.com/sourcegraph/sg.nvim/-/blob/crates/sg-nvim/src/lib.rs

	-- Collect all parts from the given URL into a table
	local parts = {}

	for part in vim.gsplit(input, "/", { plain = true }) do
		-- Filter out empty parts (e.g. when there is a trailing `/`)
		if part ~= "" then
			table.insert(parts, part)
		end
	end

	-- Extract the repository owner and name
	local repo = string.format("%s/%s", parts[3], parts[4])
	-- `tree` or `blob` depending on whether the URL is pointing to a directory or file
	local path_ident = parts[5]
	local path = nil

	if parts[7] then
		path = ""
		for i = 7, #parts do
			path = string.format("%s/%s", path, parts[i])
		end
	end

	local sourcegraph_url = string.format("https://sourcegraph.com/github.com/%s", repo)

	if path_ident then
		sourcegraph_url = string.format("%s/-/%s", sourcegraph_url, path_ident)
	end

	if path then
		sourcegraph_url = string.format("%s%s", sourcegraph_url, path)
	end

	-- This throws errors sometimes. No idea why. Still works tho!
	pcall(vim.cmd.e, sourcegraph_url)
end

vim.keymap.set("n", "<Leader>sg", function()
	vim.ui.input({ prompt = "Sourcegraph: " }, open_sg_link)
end)

vim.api.nvim_create_user_command("SgOpen", function(input)
	open_sg_link(input.fargs[1])
end, {
	nargs = 1
})
vim.api.nvim_create_user_command("SgSearch", sg_telescope.fuzzy_search_results, {})

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

--[[ Statusline ]]--
vim.opt.showmode = false

local function mode()
	return ({
			 ['n']     = 'NORMAL',
			 ['no']    = 'O-PENDING',
			 ['nov']   = 'O-PENDING',
			 ['noV']   = 'O-PENDING',
			 ['no\22'] = 'O-PENDING',
			 ['niI']   = 'NORMAL',
			 ['niR']   = 'NORMAL',
			 ['niV']   = 'NORMAL',
			 ['nt']    = 'NORMAL',
			 ['ntT']   = 'NORMAL',
			 ['v']     = 'VISUAL',
			 ['vs']    = 'VISUAL',
			 ['V']     = 'V-LINE',
			 ['Vs']    = 'V-LINE',
			 ['\22']   = 'V-BLOCK',
			 ['\22s']  = 'V-BLOCK',
			 ['s']     = 'SELECT',
			 ['S']     = 'S-LINE',
			 ['\19']   = 'S-BLOCK',
			 ['i']     = 'INSERT',
			 ['ic']    = 'INSERT',
			 ['ix']    = 'INSERT',
			 ['R']     = 'REPLACE',
			 ['Rc']    = 'REPLACE',
			 ['Rx']    = 'REPLACE',
			 ['Rv']    = 'V-REPLACE',
			 ['Rvc']   = 'V-REPLACE',
			 ['Rvx']   = 'V-REPLACE',
			 ['c']     = 'COMMAND',
			 ['cv']    = 'EX',
			 ['ce']    = 'EX',
			 ['r']     = 'REPLACE',
			 ['rm']    = 'MORE',
			 ['r?']    = 'CONFIRM',
			 ['!']     = 'SHELL',
			 ['t']     = 'TERMINAL',
		 })[vim.fn.mode()] or "UNKWN"
end

local function git_status()
	local git_status = ""

	if vim.b.gitsigns_head then
		git_status = string.format("%%#StatusGitBranch# %s", vim.b.gitsigns_head)
	end

	local function git_diff(type)
		local gsd = vim.b.gitsigns_status_dict

		if gsd and gsd[type] and gsd[type] > 0 then
			return tostring(gsd[type])
		end

		return ""
	end

	local added = git_diff("added")
	if added:len() > 0 then
		git_status = git_status .. " %#GitsignsAdd# " .. tostring(added)
	end

	local changed = git_diff("changed")
	if changed:len() > 0 then
		git_status = git_status .. " %#GitsignsChange# " .. tostring(changed)
	end

	local removed = git_diff("removed")
	if removed:len() > 0 then
		git_status = git_status .. " %#GitsignsDelete# " .. tostring(removed)
	end

	return git_status
end

local function diagnostics()
	local diagnostics = ""

	local hints = vim.tbl_count(vim.diagnostic.get(0, { severity = 4 }))
	if hints > 0 then
		diagnostics = diagnostics .. "%#DiagnosticSignHint#" .. tostring(hints) .. "  "
	end

	local infos = vim.tbl_count(vim.diagnostic.get(0, { severity = 3 }))
	if infos > 0 then
		diagnostics = diagnostics .. "%#DiagnosticSignInfo#" .. tostring(infos) .. "  "
	end

	local warns = vim.tbl_count(vim.diagnostic.get(0, { severity = 2 }))
	if warns > 0 then
		diagnostics = diagnostics .. "%#DiagnosticSignWarn#" .. tostring(warns) .. "  "
	end

	local errors = vim.tbl_count(vim.diagnostic.get(0, { severity = 1 }))
	if errors > 0 then
		diagnostics = diagnostics .. "%#DiagnosticSignError#" .. tostring(errors) .. "  "
	end

	return diagnostics
end

function LeftStatusline()
	local sep = "%#StatusSeparator#█"
	local mode = "%#StatusMode# " .. mode()
	local git = git_status()
	return string.format("%s%s %s", sep, mode, git)
end

function RightStatusline()
	return string.format("%s %%#StatusSeparator#█", diagnostics())
end

function Winbar()
	local path = vim.fn.expand("%:p:~")
	return string.format("%%#StatusWinbar#%s", path)
end

vim.api.nvim_set_hl(0, "StatusSeparator", { fg = Colors.lavender })
vim.api.nvim_set_hl(0, "StatusMode", { fg = Colors.text, bold = true })
vim.api.nvim_set_hl(0, "StatusGitBranch", { fg = Colors.mauve })
vim.api.nvim_set_hl(0, "StatusWinbar", { fg = Colors.teal })

vim.opt.statusline = "%{%v:lua.LeftStatusline()%} %= %{%v:lua.RightStatusline()%}"
vim.opt.winbar = "%{%v:lua.Winbar()%}"
