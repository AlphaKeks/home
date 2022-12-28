--[[ https://github.com/AlphaKeks ]]--

-- options
--{{{
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
vim.opt.guicursor = "a:block,i:ver20,v:hor20,r-cr-o:hor20"
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
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" }
vim.cmd.colorscheme("quiet")
--}}}

vim.g.AlphaKeks = vim.api.nvim_create_augroup("AlphaKeks", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.highlight.on_yank({ timeout = 69 })
	end
})

function Print(item)
	vim.pretty_print(item)
	return item
end

if vim.g.neovide then
	vim.api.nvim_create_autocmd("VimEnter", {
		group = vim.g.AlphaKeks,
		command = "cd ~/Projects"
	})

	vim.g.neovide_transparency = 0.85
	vim.g.neovide_refresh_rate = 240
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_cursor_trail_size = 0.8
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

-- keymaps
--{{{
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "

vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("n", "<C-w>", ":close<cr>")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "J", "V:m '>+1<cr>gv=gv<esc>")
vim.keymap.set("n", "K", "V:m '<-2<cr>gv=gv<esc>")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "H", "\"mxh\"mP")
vim.keymap.set("n", "L", "\"mx\"mp")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>Y", "\"+y$")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")

vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")

for i = 1,8,1 do
	vim.keymap.set({ "n", "t" }, "<C-" .. i .. ">", "<cmd>norm " .. i .. "gt<cr>")
end
vim.keymap.set({ "n", "t" }, "<C-9>", "<cmd>tablast<cr>")

vim.keymap.set({ "n", "t" }, "<leader>ss", "<cmd>split<cr>")
vim.keymap.set({ "n", "t" }, "<leader>vs", "<cmd>vsplit<cr>")
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>")

vim.keymap.set("n", "<C-t>", ":tabnew<cr><cmd>term<cr>A")
vim.keymap.set("t", "<C-w>", "<cmd>tabclose<cr>")
vim.keymap.set("t", "<leader><esc>", "<C-\\><C-n>")
--}}}

vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd("FileType", {
	group = vim.g.AlphaKeks,
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "a", "<Plug>NetrwOpenFile", { remap = true, buffer = true })
		vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
	end
})

vim.keymap.set("n", "<leader>e", ":Ex<cr>")

local packer_installed, packer = pcall(require, "packer")
if packer_installed then
	packer.startup(function(use)
		-- plugins
		--{{{
		use("wbthomason/packer.nvim")
		use({ "catppuccin/nvim", as = "catppuccin" })
		use({
			"nvim-treesitter/nvim-treesitter",
			requires = { "windwp/nvim-autopairs" }
		})
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"ThePrimeagen/harpoon"
			}
		})
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-path",
				"L3MON4D3/LuaSnip"
			}
		})
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"simrat39/rust-tools.nvim",
				"jose-elias-alvarez/null-ls.nvim"
			}
		})
		use("TimUntersberger/neogit")
		use({
			"feline-nvim/feline.nvim",
			requires = {
				"lewis6991/gitsigns.nvim",
				"kyazdani42/nvim-web-devicons"
			}
		})
		--}}}
	end)
else
	vim.api.nvim_create_user_command("PackerDownload", function()
		local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		vim.fn.system({
			"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path
		})
		print("Packer has been installed. Please restart.")
		vim.cmd.packadd("packer.nvim")
	end, {})
end

local catppuccin_installed, catppuccin = pcall(require, "catppuccin")
if catppuccin_installed then
	vim.g.catppuccin_flavour = "mocha"
	local palette = require("catppuccin.palettes").get_palette()
	catppuccin.setup({
		transparent_background = not vim.g.neovide,
		no_italic = true,
		custom_highlights = {
			CursorLineNr = { fg = palette.yellow },
			Search = { fg = palette.text, bg = "#7480C2" },
			IncSearch = { fg = palette.text, bg = "#7480C2" },
			CurSearch = { fg = palette.text, bg = "#7480C2" },
			NormalFloat = { bg = palette.none },
			FloatBorder = { fg = palette.lavender },
			MatchParen = { fg = palette.red },
			["@storageclass"] = { fg = palette.sapphire }
		}
	})
	vim.cmd.colorscheme("catppuccin")
end

local treesitter_installed, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_installed then
	treesitter.setup({
		ensure_installed = {},
		highlight = { enable = true },
		indent = { enable = true }
	})

	local autopairs_installed, autopairs = pcall(require, "nvim-autopairs")
	if autopairs_installed then
		autopairs.setup({ check_ts = true, disable_filetypes = { "TelescopePrompt" } })
	end
end

local telescope_installed, telescope = pcall(require, "telescope")
if telescope_installed then
	telescope.setup({
		defaults = {
			mappings = {
				["i"] = {
					["<esc>"] = require("telescope.actions").close
				}
			}
		}
	})

	local builtin = require("telescope.builtin")
	local ivy = require("telescope.themes").get_ivy

	local default_ivy = function(title)
		return ivy({
			prompt_title = title,
			hidden = true,
			follow = true,
			layout_config = { height = 0.4 }
		})
	end

	vim.keymap.set("n", "<C-f>", function()
		builtin.current_buffer_fuzzy_find({ prompt_title = "Search Buffer" })
	end)
	vim.keymap.set("n", "<leader>ff", function()
		builtin.find_files(default_ivy("Search Files"))
	end)
	vim.keymap.set("n", "<leader>fl", function()
		builtin.live_grep({
			prompt_title = "Search Project",
			glob_pattern = { "!node_modules/*", "!target/*" }
		})
	end)
	vim.keymap.set("n", "<leader>fd", function()
		buitlin.diagnostics(default_ivy("Diagnostics"))
	end)
	vim.keymap.set("n", "<leader>fs", function()
		buitlin.lsp_workspace_symbols(default_ivy("LSP Symbols"))
	end)
	vim.keymap.set("n", "<leader>fd", function()
		buitlin.lsp_references(default_ivy("LSP References"))
	end)
	vim.keymap.set("n", "<C-/>", function()
		builtin.grep_string({
			layout_strategy = "cursor",
			layout_config = { height = 0.5, width = 0.75 }
		})
	end)

	vim.keymap.set("n", "<leader>df", function()
		builtin.find_files(ivy({
			prompt_title = title,
			hidden = true,
			follow = true,
			layout_config = { height = 0.4 },
			cwd = "~/.dotfiles"
		}))
	end)

	local harpoon_installed, _ = pcall(require, "harpoon")
	if harpoon_installed then
		telescope.load_extension("harpoon")
		local ui = require("harpoon.ui")
		local mark = require("harpoon.mark")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<leader>j", ui.toggle_quick_menu)
		vim.keymap.set("n", "<F1>", function() ui.nav_file(1) end)
		vim.keymap.set("n", "<F2>", function() ui.nav_file(2) end)
		vim.keymap.set("n", "<F3>", function() ui.nav_file(3) end)
		vim.keymap.set("n", "<F4>", function() ui.nav_file(4) end)
	end
end

local cmp_installed, cmp = pcall(require, "cmp")
local luasnip_installed, luasnip = pcall(require, "luasnip")
if cmp_installed and luasnip_installed then
	cmp.setup({
		snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
		mapping = cmp.mapping.preset.insert({
			["<cr>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-j>"] = cmp.mapping.scroll_docs(4),
			["<C-k>"] = cmp.mapping.scroll_docs(-4),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end)
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" }
		},
		formatting = {
			format = function(_, vim_item)
				local icons = {
					Text = "", Method = "", Function = "", Constructor = "", Field = "ﰠ",
					Variable = "", Class = "ﴯ", Interface = "", Module = "", Property = "ﰠ",
					Unit = "塞", Value = "", Enum = "", Keyword = "", Snippet = "",
					Color = "", File = "", Reference = "", Folder = "", EnumMember = "",
					Constant = "", Struct = "פּ", Event = "", Operator = "", TypeParameter = ""
				}
				vim_item.kind = icons[vim_item.kind]
				return vim_item
			end
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = { ghost_text = true }
	})
end

local lsp_installed, lsp = pcall(require, "lspconfig")
if lsp_installed then
	local function format_on_save(bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.g.AlphaKeks,
			buffer = bufnr,
			callback = vim.lsp.buf.format
		})
	end

	local function highlight_word(bufnr)
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = vim.g.AlphaKeks,
			buffer = bufnr,
			callback = function()
				local utils_installed, utils = pcall(require, "nvim-treesitter.ts_utils")
				if not utils_installed then return end

				local node = utils.get_node_at_cursor()
				if not node then return end

				local node_text = vim.treesitter.get_node_text(node, 0)
				if vim.g.current_node ~= node_text then
					vim.g.current_node = node_text
					vim.lsp.buf.clear_references()

					local node_type = vim.treesitter.get_node_at_cursor()
					if node_type == "identifier" or node_type == "property_identifier" then
						vim.lsp.buf.document_highlight()
					end
				end
			end
		})
	end

	local function apply_keymaps(bufnr)
		vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.hover, { buffer = bufnr })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
		vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr })
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
		vim.keymap.set("n", "gL", vim.diagnostic.goto_next, { buffer = bufnr })
		vim.keymap.set("n", "gr", function()
			vim.ui.input({ prompt = "New Name: " }, function(input)
				if not input then return end
				vim.lsp.buf.rename(input)
			end)
		end, { buffer = bufnr })
	end

	local capabilities = nil
	local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_installed then
		capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
	end

	local rust_tools_installed, rust_tools = pcall(require, "rust-tools")
	if rust_tools_installed then
		rust_tools.setup({
			tools = {
				inlay_hints = {
					auto = true,
					only_current_line = true,
					show_parameter_hints = true
				}
			},
			server = {
				standalone = true,
				on_attach = function(_, bufnr)
					format_on_save(bufnr)
					highlight_word(bufnr)
					apply_keymaps(bufnr)
				end,
				capabilities = capabilities,
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						checkOnSave = { command = "clippy" }
					}
				}
			}
		})
	end

	lsp["tsserver"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
			highlight_word(bufnr)
			apply_keymaps(bufnr)
		end,
		capabilities = capabilities
	})

	local null_ls_installed, null_ls = pcall(require, "null-ls")
	if null_ls_installed then
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettierd.with({
					env = {
						PRETTIERD_DEFAULT_CONFIG = os.getenv("HOME") .. "/.config/prettier/prettier.config.js"
					}
				})
			},
			on_attach = function(client, bufnr)
				format_on_save(bufnr)
			end
		})
	end

	vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "" })
	vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "" })
	vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "" })
	vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "" })
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	vim.diagnostic.config({
		virtual_text = {
			source = false,
			prefix = "",
			format = function(diagnostic) return "  " .. diagnostic.message end,
			severity = vim.diagnostic.severity.ERROR
		},
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			source = "always",
			header = "Diagnostics",
			prefix = " ",
			border = "rounded"
		}
	})
end

local neogit_installed, neogit = pcall(require, "neogit")
if neogit_installed then
	neogit.setup({
		commit_popup = { kind = "vsplit" },
		disable_context_highlighting = true
	})
	vim.keymap.set("n", "<leader>gs", neogit.open)
	vim.keymap.set("n", "<leader>gc", function()
		neogit.open({ "commit" })
	end)
	vim.keymap.set("n", "<leader>gl", function()
		neogit.open({ "log" })
	end)
end

local feline_ok, feline = pcall(require, "feline")
local palette_ok, palette = pcall(require, "catppuccin.palettes")
local git_ok, git = pcall(require, "gitsigns")
if feline_ok and palette_ok and git_ok then
	palette = palette.get_palette()
	local bg_color = palette.base

	local feline_lsp = require("feline.providers.lsp")
	local severity = vim.diagnostic.severity

	local modes = {
		--{{{
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
		["!"] = "SHELL"
		--}}}
	}

	git.setup()

	local filler = {
		provider = "█",
		hl = { fg = bg_color, bg = bg_color }
	}

	feline.setup({
		components = {
			--{{{
			active = {
				{
					filler,
					{
						provider = function()
							return modes[vim.fn.mode()]
						end,
						hl = { fg = palette.lavender, bg = bg_color },
					},
					filler,
					{
						provider = "git_branch",
						icon = " ",
						hl = { fg = palette.yellow, bg = bg_color }
					},
					filler,
					{
						provider = "git_diff_added",
						icon = " ",
						hl = { fg = palette.green, bg = bg_color }
					},
					filler,
					{
						provider = "git_diff_changed",
						icon = " ",
						hl = { fg = palette.yellow, bg = bg_color }
					},
					filler,
					{
						provider = "git_diff_removed",
						icon = " ",
						hl = { fg = palette.red, bg = bg_color }
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
						hl = { fg = palette.lavender, bg = bg_color }
					}
				},
				{
					{
						provider = function()
							return string.format("<%s>", vim.opt.filetype._value)
						end,
						hl = { fg = palette.surface2, bg = bg_color }
					},
					filler,
					{
						provider = "diagnostic_hints",
						enabled = function()
							return feline_lsp.diagnostics_exist(severity.HINT)
						end,
						icon = " ",
						hl = { fg = palette.text, bg = bg_color }
					},
					filler,
					{
						provider = "diagnostic_info",
						enabled = function()
							return feline_lsp.diagnostics_exist(severity.INFO)
						end,
						icon = " ",
						hl = { fg = palette.teal, bg = bg_color }
					},
					filler,
					{
						provider = "diagnostic_warnings",
						enabled = function()
							return feline_lsp.diagnostics_exist(severity.WARN)
						end,
						icon = " ",
						hl = { fg = palette.yellow, bg = bg_color }
					},
					filler,
					{
						provider = "diagnostic_errors",
						enabled = function()
							return feline_lsp.diagnostics_exist(severity.ERROR)
						end,
						icon = " ",
						hl = { fg = palette.red, bg = bg_color }
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
						hl = { fg = palette.blue, bg = bg_color }
					}
				}
			}
			--}}}
		}
	})


	feline.winbar.setup()
end

-- vim: foldmethod=marker foldlevel=0
