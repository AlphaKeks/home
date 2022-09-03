-- this config is intended for neovim 0.7.2
-- https://github.com/AlphaKeks

_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}

local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

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
keymap("x", ">", ">gv", opts)
keymap("x", "<", "<gv", opts)

-- buffer / window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<C-w>", ":bdelete<CR>", opts)
keymap("t", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap("t", "<S-l>", "<cmd>bnext<CR>", opts)

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
keymap("n", "<leader>fg", function()
	require("telescope.builtin").git_status {
		prompt_title = "git",
		hidden = true,
		layout_config = {
			height = 0.90,
			width = 0.90
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

keymap("n", "gR", function()
	require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy {
		prompt_title = "References",
		layout_config = {
			height = 0.2
		}
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
keymap("n", "<C-t>", ":term<CR><cmd>vsplit<CR><C-w>h<cmd>bprevious<CR>", opts)
keymap("t", "<C-w>", "<cmd>bdelete!<CR>", opts)

--[[ plugin manager ]]--
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer...\nclose and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

local packer_ok, packer = pcall(require, "packer")
if packer_ok then
	packer.startup(function(use)
		-- let packer manage itself
		use { "wbthomason/packer.nvim" }

		-- theme
		use { "catppuccin/nvim", as = "catppuccin" }

		-- dependency plugins
		use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
		use { "nvim-lua/plenary.nvim", commit = "31807eef4ed574854b8a53ae40ea3292033a78ea" }

		-- basic functionality
		use { "nvim-treesitter/nvim-treesitter", commit = "59f656a20375242948755e860fabe3944968cbc0" }

		use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "37a97a04c39f26fffe7745815517e1ce1a0eb3be" }
		use { "numToStr/Comment.nvim", commit = "80e7746e42fa685077a7941e9022308c7ad6adf8" }

		use { "neovim/nvim-lspconfig", commit = "607ff48b970b89c3e4e3825b88d9cfd05b7aaea5" }
		use { "jose-elias-alvarez/null-ls.nvim", commit = "753ad51790a966b42997ac935e26573fb6d5864a" }

		-- completion
		use { "L3MON4D3/LuaSnip", commit = "04f90900f2a57938921fd25169c7f282e7eefe85" }
		use { "hrsh7th/nvim-cmp", commit = "058100d81316239f3874064064f0f0c5d43c2103" }
		use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
		use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
		use { "hrsh7th/cmp-nvim-lsp-signature-help", commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb" }
		use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }
		use { "onsails/lspkind-nvim", commit = "57e5b5dfbe991151b07d272a06e365a77cc3d0e7" }
		use { "windwp/nvim-autopairs", commit = "0a18e10a0c3fde190437567e40557dcdbbc89ea1" }
		use { "windwp/nvim-ts-autotag", commit = "044a05c4c51051326900a53ba98fddacd15fea22" }

		-- nicer UI
		use { "nvim-lualine/lualine.nvim", commit = "3cf45404d4ab5e3b5da283877f57b676cb78d41d" }
		use { "akinsho/bufferline.nvim", commit = "8383034f103a6e9c0b3178a56e27acb2215986c1" }
		use { "nvim-telescope/telescope.nvim", commit = "510338722e1151c116afb9467e416989159476fa" }
		use { "glepnir/lspsaga.nvim", commit = "7d3e1b186b84491f23bc728a2aa874150d71f3b6" }
		use { "lewis6991/gitsigns.nvim", commit = "1e107c91c0c5e3ae72c37df8ffdd50f87fb3ebfa" }
		use { "kyazdani42/nvim-tree.lua", commit = "c3ea264947671f44d836af5b7587e12c4b4611f9" }
		use { "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" }
		use { "williamboman/mason.nvim", commit = "6f30a4066c477617da95ecef8f88a697d2a7124c" }

	if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end)
end

--[[ setup functions ]]--
-- theme (catppuccin)
local theme_ok, catppuccin = pcall(require, "catppuccin")
if theme_ok then
	vim.g.catppuccin_flavour = "mocha"
	local colors = require("catppuccin.palettes").get_palette()

	catppuccin.setup {
		transparent_background = true,
		term_colors = true,
		compile = { enabled = false	},
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = { "italic" },
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = { "bold" },
			operators = {},
		},
		integration = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = { errors = { "underline" } }
			},
			lsp_saga = true,
			gitsigns = true,
			telescope = true,
			nvimtree = {
				enabled = true,
				show_root = true,
				transparent_panel = true
			},
			bufferline = true,
			markdown = true
		},
		custom_highlights = {
			TSType = { fg = "#73bdea" },
			TSTypeBuiltin = { fg = "#73bdea", style = { "italic" } },
			TSPunctDelimiter = { fg = "#73bdea" },
			TSVariable = { fg = colors.lavender }
		}
	}
	vim.cmd [[colorscheme catppuccin]]
end

-- syntax highlighting and indenting (treesitter)
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_ok then
	treesitter.setup {
		ensure_installed = "all",
		ignore_install = { "" },
		highlight = { enable = true },
		autopairs = {	enable = true },
		indent = { enable = true },
	}
end

-- commenting
local comment_ok, comment = pcall(require, "Comment")
if comment_ok then
	comment.setup {
		pre_hook = function(ctx)
			local U = require("Comment.utils")
			local type = ctx.type == U.ctype.linewise and "__default" or "__multiline"
			local location = nil

			if ctx.ctype == U.ctype.block then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = type,
				location = location
			})
		end
	}
end

-- autopairs && autotags
local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if autopairs_ok then
	autopairs.setup { check_ts = true, disable_filetypes = { "TelescopePrompt", "vim" } }
end

local autotag_ok, autotag = pcall(require, "nvim-ts-autotag")
if autotag_ok then autotag.setup() end

-- native lsp
local lsp_ok, lsp = pcall(require, "lspconfig")
if lsp_ok then
	--settings
	-- format on save
	local on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end
			})
		end
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	-- completion
	local cmp_nvim_ok, cmp_nvim = pcall(require, "cmp_nvim_lsp")
	if cmp_nvim_ok then capabilities = cmp_nvim.update_capabilities(capabilities) end

	vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })

	vim.diagnostic.config {
		virtual_text = true,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	-- servers
	lsp["bashls"].setup {
		on_attach = on_attach,
		capabilities = capabilities
	}

	lsp["cssls"].setup {
		on_attach = on_attach,
		capabilities = capabilities
	}

	lsp["html"].setup {
		on_attach = on_attach,
		capabilities = capabilities
	}

	lsp["jsonls"].setup {
		on_attach = on_attach,
		capabilities = capabilities
	}

	lsp["rust_analyzer"].setup {
		on_attach = function(client, bufnr)
			-- rustfmt instead
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities,
		cmd = { "rust-analyzer" }
	}

	lsp["tsserver"].setup {
		on_attach = function(client, bufnr)
			-- prettierd instead
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities
	}

	lsp["vuels"].setup {
		on_attach = function(client, bufnr)
			-- prettierd instead
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities
	}
end

-- null-ls
local null_ls_ok, null_ls = pcall(require, "null-ls")
if null_ls_ok then
	local diagnostics = null_ls.builtins.diagnostics
	local formatting = null_ls.builtins.formatting
	local actions = null_ls.builtins.code_actions

	null_ls.setup {
		debug = false,
		sources = {
			diagnostics.eslint_d.with { filetypes = { "javascript", "typescript" } },

			formatting.prettierd.with {
				filetypes = { "javascript", "typescript", "vue" },
				env = {
					PRETTIERD_DEFAULT_CONFIG = "/home/alpha/.config/prettier/prettier.config.js"
				}
			},

			formatting.rustfmt.with { extra_args = { "--edition=2021" } }
		},
		-- format on save
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.formatting_sync()
					end
				})
			end
		end
	}
end

-- completion
local luasnip_ok, luasnip = pcall(require, "luasnip")
if luasnip_ok then
	luasnip.config.set_config = {
		history = true,
		updateevents = "TextChanged,TextChangedI"
	}

	local f = require("luasnip.extras.fmt").fmt
	local i = luasnip.insert_node
	local r = require("luasnip.extras").rep
	local snip = luasnip.snippet

	luasnip.add_snippets("typescript", {
		snip("imp", f("import {{ {} }} from \"{}\";", {
			i(1, "obj"),
			i(2, "package")
		}))
	})

	local lspkind_ok, lspkind = pcall(require, "lspkind")
	if lspkind_ok then
		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		kind_icons = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
			TypeParameter = ""
		}

		local cmp_status, cmp = pcall(require, "cmp")
		if cmp_status then
			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},
				mapping = cmp.mapping.preset.insert {
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" })
				},
				formatting = {
					format = lspkind.cmp_format {
						mode = "symbol",
						menu = {
							nvim_lsp = "[LSP]",
							nvim_lsp_signature_help = "[Inferred]",
							luasnip = "[Snippet]",
							path = "[Path]",
						},
						maxwidth = 40
					}
				},
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" }
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered()
				}
			}
		end
	end
end

-- lualine
local lualine_ok, lualine = pcall(require, "lualine")
if lualine_ok then
	lualine.setup {
		options = {
			icons_enabled = true,
			theme = "catppuccin",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = {}
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"filename",
					file_status = true,
								path = 0
						}
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " "
				}
			},
			"encoding",
			"filetype"
			},
			lualine_y = { "progress" },
			lualine_z = { "location" }
			},
			inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
								'filename',
								file_status = true,
					path = 1
						}
			},
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
	}
end

-- bufferline
local bufferline_ok, bufferline = pcall(require, "bufferline")
if bufferline_ok then
	bufferline.setup {
		options = {
			close_command = "Bdelete! %d",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
			separator_style = "thin"
		}
	}
end

-- telescope
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	local actions = require("telescope.actions")

	telescope.setup {
		defaults = {
			prompt_prefix = "  ",
			selection_caret = " ",
			path_display = { "smart" },
			mappings = {
				i = {
					["<Down>"] = actions.cycle_history_next,
					["<Up>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				}
			}
		},
	}
end

-- lspsaga
local saga_ok, saga = pcall(require, "lspsaga")
if saga_ok then
	saga.init_lsp_saga {
		border_style = "rounded",
		diagnostic_header = { " ", " ", " ", "ﴞ " },
		show_diagnostic_source = true,
		finder_icons = {
			def = " ",
			ref = "諭",
			link = " ",
		},
		finder_action_keys = {
			open = "<CR>",
			vsplit = "v",
			split = "s",
			tabe = "t",
			quit = "<ESC>",
			scroll_down = "<C-f>",
			scroll_up = "<C-b>"
		},
		definition_preview_icon = " ",
		show_outline = {
			win_position = "right",
			win_with = "",
			win_width = 30,
			auto_enter = true,
			auto_preview = true,
			virt_text = "┃",
			jump_key = "<CR>",
			auto_refresh = true
		},
		custom_kind = { Field = "#7480c2" },
		server_filetype_map = {}
	}
end

-- gitsigns
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
	gitsigns.setup {
		signs = {
			add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" }
		}
	}
end

-- nvim-tree
local tree_ok, tree = pcall(require, "nvim-tree")
if tree_ok then
	local tree_cb = require("nvim-tree.config").nvim_tree_callback

	tree.setup {
		update_focused_file = {
			enable = true,
			update_cwd = true
		},
		renderer = {
			root_folder_modifier = ":t",
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_open = "",
						arrow_closed = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = ""
					},
					git = {
						unstaged = "",
						staged = "S",
						unmerged = "",
						renamed = "➜",
						untracked = "U",
						deleted = "",
						ignored = "◌"
					}
				}
			}
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = ""
			}
		},
		view = {
			width = 30,
			height = 30,
			side = "left",
			mappings = {
				list = {
					{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
					{ key = "h", cb = tree_cb("close_node") },
					{ key = "v", cb = tree_cb("vsplit") }
				}
			}
		},
		filters = { dotfiles = false },
		git = { ignore = false }
	}
end

-- mason
local mason_ok, mason = pcall(require, "mason")
if mason_ok then mason.setup() end
