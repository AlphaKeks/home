--[[ neovim 0.8 ]]--

-- https://github.com/AlphaKeks

------------------------------------------------
--[[ editor settings ]]--

local opts = {
	confirm = true,
	filetype = "on",
	mouse = "",
	swapfile = false,
	undodir = os.getenv("HOME") .. "/.local/share/nvim/undo",
	undofile = true,
	updatetime = 40,
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
	colorcolumn = "100",
	foldcolumn = "0",
	formatoptions = "crqn2lj",
	guicursor = "a:block,i:ver20,v:hor20,r-cr-o:hor20",
	guifont = "Fira_Code:h16",
	laststatus = 3,
	list = false,
	listchars = { tab = "» ", space = "·" },
	number = true,
	relativenumber = true,
	scrolloff = 8,
	sidescrolloff = 8,
	showmode = false,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	wrap = true,
	hlsearch = false,
	incsearch = true,
	ignorecase = true,
	smartcase = true,
	iskeyword = "@,48-57,192-255"
}

for opt, val in pairs(opts) do
	vim.opt[opt] = val
end

------------------------------------------------
--[[ autocmds ]]--

function AUGROUP(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

AUTOCMD = vim.api.nvim_create_autocmd

AUGROUPS = {}

AUGROUPS.Autism = AUGROUP("Autism")

AUTOCMD("ModeChanged", {
	group = AUGROUPS.Autism,
	pattern = { "*:v", "*:V" },
	callback = function()
		vim.opt.list = true
	end
})

AUTOCMD("ModeChanged", {
	group = AUGROUPS.Autism,
	pattern = { "v:*", "V:*" },
	callback = function()
		vim.opt.list = false
	end
})

AUTOCMD("FileType", {
	group = AUGROUPS.Autism,
	pattern = "*",
	callback = function()
		vim.opt.expandtab = false
		vim.opt.formatoptions = "crqn2lj"
		vim.opt.textwidth = 0
	end
})

AUTOCMD("FileType", {
	group = AUGROUPS.Autism,
	pattern = { "text", "markdown" },
	callback = function()
		vim.opt.expandtab = true
		vim.opt.formatoptions = "tcrqn2lj"
		vim.opt.textwidth = 80
	end
})

AUTOCMD("TextYankPost", {
	group = AUGROUPS.Autism,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 69 })
	end
})

------------------------------------------------
--[[ neovide ]]--

if vim.g.neovide then
	AUTOCMD("VimEnter", {
		pattern = "*",
		callback = function()
			vim.cmd.cd("~/projects")
		end
	})

	vim.g.neovide_transparency = 0.2
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_refresh_rate = 240
	vim.g.neovide_refresh_rate_idle = 240
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.05
end

------------------------------------------------
--[[ keymaps ]]--

-- space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- overriding default behavior
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<C-w>", "<cmd>close<cr>")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("v", "p", "\"_dP")
vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>Y", "\"+Y")
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")

-- moving lines around
vim.keymap.set("n", "J", "V:m '>+1<cr>gv=gv<esc>")
vim.keymap.set("n", "K", "V:m '<-2<cr>gv=gv<esc>")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- window navigation
vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")
vim.keymap.set({ "n", "t" }, "H", "<cmd>tabprevious<cr>")
vim.keymap.set({ "n", "t" }, "L", "<cmd>tabnext<cr>")
vim.keymap.set({ "n", "t" }, "<Leader>ss", "<cmd>split<cr>")
vim.keymap.set({ "n", "t" }, "<Leader>vs", "<cmd>vsplit<cr>")
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>")
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<cr><cmd>term<cr>A")
vim.keymap.set("t", "<C-w>", "<cmd>tabclose<cr>")
vim.keymap.set("t", "<Leader><esc>", "<C-\\><C-n>")
-- <C-^> stopped working for some reason?
vim.keymap.set({ "n", "t" }, "<Leader>^", "<C-^>")

-- LSP
vim.keymap.set("n", "<Leader><Leader>", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gr", function()
	vim.ui.input({ prompt = "New Name: " }, function(input)
		vim.lsp.buf.rename(input)
	end)
end)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gh", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "gL", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>h", vim.lsp.buf.document_highlight)

vim.keymap.set("n", "<Leader>c", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("v", "<Leader>c", "<Plug>(comment_toggle_blockwise_visual)")
vim.keymap.set("x", "<Leader>c", "<Plug>(comment_toggle_linewise_visual)")

------------------------------------------------
--[[ netrw ]]--

vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0

AUTOCMD("FileType", {
	group = AUGROUPS.Autism,
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "a", "<Plug>NetrwOpenFile", { remap = true, buffer = true })
		vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
	end
})

------------------------------------------------
--[[ plugins ]]--

-- plugin list
local function PackerSetup()
	local packer_installed, packer = pcall(require, "packer")
	if not packer_installed then return end

	packer.startup(function(use)
		use("wbthomason/packer.nvim") -- packer can update itself
		use({ "catppuccin/nvim", as = "catppuccin" }) -- colorscheme
		use("nvim-lua/plenary.nvim") -- utility functions
		use({
			"nvim-treesitter/nvim-treesitter", -- tree-sitter
			requires = {
				"windwp/nvim-autopairs", -- automatically close (,[,{ etc.
				"numToStr/Comment.nvim" -- comment stuff using tree-sitter
			}
		})
		use({
			"hrsh7th/nvim-cmp", -- completion engine
			requires = {
				"hrsh7th/cmp-buffer", -- suggest buffer words for completion
				"hrsh7th/cmp-path", -- suggest filesystem paths for completion
				"L3MON4D3/LuaSnip", -- snippet engine
				"saadparwaiz1/cmp_luasnip" -- suggest snippets for completion
			}
		})
		use({
			"neovim/nvim-lspconfig", -- LSP configurations
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
				"jose-elias-alvarez/null-ls.nvim", -- custom language server for linters/formatters
				"simrat39/rust-tools.nvim", -- rust-analyzer extended™
				{
					"williamboman/mason.nvim", -- install LSP-related dependencies easily
					config = function() -- but only setup on demand
						vim.api.nvim_create_user_command("MasonSetup", require("mason").setup, {})
					end
				}
			}
		})
		use({
			"nvim-telescope/telescope.nvim", -- blazingly fast fuzzy finding
			requires = {
				"nvim-telescope/telescope-file-browser.nvim", -- blazingly fast file browser
				"ThePrimeagen/harpoon" -- blazingly fast marks (but better™)
			}
		})
		use({
			"feline-nvim/feline.nvim", -- statusline
			requires = {
				"lewis6991/gitsigns.nvim", -- git integration
				"kyazdani42/nvim-web-devicons" -- cool icons
			}
		})
	end)
end

local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	-- ask for packer installation if it's not installed
	vim.ui.input({ prompt = "Install packer? [y/n] " }, function(packer_choice)
		print("\n")
		packer_choice = string.lower(packer_choice)
		if packer_choice == "y" or packer_choice == "yes" then
			vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
			print("Installing packer...")
			vim.cmd.packadd("packer.nvim")

			-- also ask for plugin installation
			vim.ui.input({ prompt = "Install plugins? [y/n] " }, function(plugin_choice)
				print("\n")
				plugin_choice = string.lower(plugin_choice)
				if plugin_choice == "y" or plugin_choice == "yes" then
					print("Installing plugins...")
					print("Close and reopen neovim once the installation has finished.")
					PackerSetup()
					vim.cmd.PackerSync()
				end
			end)
		end
	end)

end

-- don't unnecessarily setup packer, but use a usercommand instead
vim.api.nvim_create_user_command("PackerSetup", function()
	PackerSetup()
end, {})

------------------------------------------------
--[[ catppuccin ]]--

local catppuccin_installed, catppuccin = pcall(require, "catppuccin")
if catppuccin_installed then
	vim.g.catppuccin_flavour = "mocha"
	local palette = require("catppuccin.palettes").get_palette()

	catppuccin.setup({
		transparent_background = true,
		no_italic = true,
		integrations = {
			markdown = true,
			cmp = true,
			treesitter = true,
			telescope = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "bold" },
					warnings = { "italic" }
				}
			}
		},
		custom_highlights = {
			CursorLine = { bg = palette.surface0 },
			CursorLineNr = { fg = palette.yellow },
			EndOfBuffer = { fg = "#7480c2" },
			Whitespace = { fg = palette.surface2 },
			IncSearch = { fg = palette.text, bg = "#7480c2" },
			WinSeparator = { bg = "NONE", fg = "NONE" },
			NormalFloat = { bg = "NONE" },
			DiagnosticHint = { bg = "NONE" },
			DiagnosticInfo = { bg = "NONE" },
			DiagnosticWarn = { bg = "NONE" },
			DiagnosticError = { bg = "NONE" },
			DiagnosticVirtualTextHint = { bg = "NONE" },
			DiagnosticVirtualTextInfo = { bg = "NONE" },
			DiagnosticVirtualTextWarn = { bg = "NONE" },
			DiagnosticVirtualTextError = { bg = "NONE" },
			TelescopeBorder = { fg = palette.lavender }
		}
	})

	vim.cmd.colorscheme("catppuccin")
end

------------------------------------------------
--[[ tree-sitter ]]--

local ts_installed, ts = pcall(require, "nvim-treesitter.configs")
if ts_installed then
	ts.setup({
		ensure_installed = {},
		ignore_install = {},
		highlight = { enable = true },
		indent = { enable = true }
	})

	local autopairs_installed, autopairs = pcall(require, "nvim-autopairs")
	if autopairs_installed then
		autopairs.setup({
			check_ts = true,
			disable_filetypes = {
				"TelescopePrompt",
			},
		})
	end

	local comment_installed, comment = pcall(require, "Comment")
	if comment_installed then
		comment.setup({
			mappings = {
				basic = false,
				extra = false
			}
		})
	end
end

------------------------------------------------
--[[ nvim-cmp ]]--

local cmp_installed, cmp = pcall(require, "cmp")
local luasnip_installed, luasnip = pcall(require, "luasnip")
if cmp_installed and luasnip_installed then
	vim.g.icons = {
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
		TypeParameter = "",
	}

	local snip = luasnip.snippet
	local i = luasnip.insert_node
	local f = require("luasnip.extras.fmt").fmt

	luasnip.add_snippets("typescript", {
		snip("fn", f(
			[[
			{5}function {1}({2}): {3} {{
				{4}
			}}
			]],
			{
				i(1, "callMeDaddy"),
				i(2, "args: any"),
				i(3, "void"),
				i(4, "typeof NaN === \"number\""),
				i(5, "")
			}
		))
	})

	luasnip.add_snippets("rust", {
		snip("atest", f(
			[[
			#[tokio::test]
			async fn {1}_test() {{
				// {2}
			}}
			]],
			{
				i(1, "function"),
				i(2, "")
			}
		))
	})

	cmp.setup({
		snippet = {
			expand = function(args) luasnip.lsp_expand(args.body) end
		},
		mapping = cmp.mapping.preset.insert({
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<cr>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible then cmp.select_next_item()
				elseif luasnip.expandable() then luasnip.expand()
				elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
				else fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible then cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then luasnip.jump(-1)
				else fallback()
				end
			end, { "i", "s" }),
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible then cmp.select_next_item()
				elseif luasnip.expandable() then luasnip.expand()
				elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
				else fallback()
				end
			end, { "i", "s" }),
			["<C-p>"] = cmp.mapping(function(fallback)
				if cmp.visible then cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then luasnip.jump(-1)
				else fallback()
				end
			end, { "i", "s" }),
		}),
		formatting = {
			format = function(_, vim_item)
				vim_item.kind = vim.g.icons[vim_item.kind] or ""
				return vim_item
			end
		},
		experimental = { ghost_text = true },
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "buffer" },
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
	})
end

------------------------------------------------
--[[ diagnostics ]]--

vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = "🤓"
	},
	update_in_insert = true,
	underline = false,
	severity_sort = true,
	float = {
		focusable = true,
		source = "always",
		header = "Diagnostics",
		prefix = "- ",
		border = "rounded"
	}
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

------------------------------------------------
--[[ LSP ]]--

AUGROUPS.AlphaKeksLSP = AUGROUP("AlphaKeksLSP")

local lsp_installed, lsp = pcall(require, "lspconfig")
if lsp_installed then
	local format_on_save = function(_, bufnr)
		AUTOCMD("BufWritePre", {
			group = AUGROUPS.AlphaKeksLSP,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end
		})
	end

	local highlight_word = function(client, bufnr)
		if client.name == "bashls" then return end
		AUTOCMD({ "CursorMoved", "InsertCharPre" }, {
			group = AUGROUPS.AlphaKeksLSP,
			buffer = bufnr,
			callback = function()
				local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
				if node == nil then return end

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

	local servers = {
		"cssls",
		"html",
		"jsonls"
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_nvim_lsp_installed, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_nvim_lsp_installed then
		capabilities = cmp_nvim_lsp.default_capabilities()
	end

	for _, server in ipairs(servers) do
		lsp[server].setup({
			on_attach = function(client, bufnr)
				highlight_word(client, bufnr)
				format_on_save(client, bufnr)
			end,
			capabilities = capabilities
		})
	end

	local rt_installed, rt = pcall(require, "rust-tools")
	-- https://github.com/simrat39/rust-tools.nvim#configuration
	if rt_installed then
		rt.setup({
			tools = {
				inlay_hints = {
					auto = true,
					only_current_line = true,
					show_parameter_hints = false,
				}
			},
			server = {
				standalone = true,
				on_attach = function(client, bufnr)
					client.server_capabilities.document_range_formatting = false
					client.server_capabilities.document_formatting = false
					highlight_word(client, bufnr)
				end,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy"
						}
					}
				}
			}
		})
	end

	lsp["tsserver"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
			highlight_word(client, bufnr)
		end,
		capabilities = capabilities
	})

	local rtp = vim.split(package.path, ";")
	table.insert(rtp, "lua/?.lua")
	table.insert(rtp, "lua/?/init.lua")

	lsp["sumneko_lua"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
			highlight_word(client, bufnr)
		end,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = rtp
				},
				diagnostics = {
					globals = { "vim" }
				},
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				telemetry = { enable = false, enabled = false }
			}
		}
	})

	local null_ls_installed, null_ls = pcall(require, "null-ls")
	if null_ls_installed then
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		local actions = null_ls.builtins.code_actions

		local null_sources = {
			formatting.prettierd.with({
				env = {
					PRETTIERD_DEFAULT_CONFIG = os.getenv("HOME") .. "/.config/prettier/prettier.config.js"
				}
			}),
			formatting.rustfmt.with({
				extra_args = { "--edition=2021" }
			})
		}

		local eslint_check = vim.fs.find({
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yml",
			".eslintrc.yaml",
			".eslintrc.json",
			"eslintrc.config.js",
		}, {
			upward = true,
			stop = os.getenv("HOME"),
			type = "file",
			limit = 1
		})

		if eslint_check[1] then
			table.insert(null_sources, diagnostics.eslint_d)
			table.insert(null_sources, actions.eslint_d)
		end

		null_ls.setup({
			debug = false,
			sources = null_sources,
			on_attach = function(client, bufnr)
				format_on_save(client, bufnr)

				AUTOCMD("LspDetach", {
					group = AUGROUPS.AlphaKeksLSP,
					buffer = bufnr,
					callback = function()
						if client.name == "null-ls" then
							os.execute("if [[ $(pgrep eslint_d | wc -l) -gt 0 ]]; then killall eslint_d; fi")
							os.execute("if [[ $(pgrep prettierd | wc -l) -gt 0 ]]; then killall prettierd; fi")
						end
					end
				})
			end,
		})
	end
end

------------------------------------------------
--[[ telescope ]]--

local telescope_installed, telescope = pcall(require, "telescope")
if telescope_installed then
	local actions = require("telescope.actions")
	local fb_actions = telescope.extensions.file_browser.actions

	telescope.setup({
		defaults = {
			prompt_prefix = "> ",
			selection_caret = ">",
			mappings = {
				["i"] = {
					["<C-j>"] = actions.move_selection_next,
					["<C-K>"] = actions.move_selection_previous,
					["<esc>"] = actions.close
				}
			}
		},
		extensions = {
			file_browser = {
				hijack_netrw = true,
				hidden = true,
				previewer = false,
				initial_mode = "normal",
				mappings = {
					["n"] = {
						["a"] = fb_actions.create,
						["d"] = fb_actions.remove,
						["r"] = fb_actions.rename,
					},
					["i"] = {
						["<C-a>"] = fb_actions.create,
						["<C-d>"] = fb_actions.remove,
						["<C-r>"] = fb_actions.rename,
						["<esc>"] = actions.close
					},
				}
			}
		}
	})

	telescope.load_extension("file_browser")
	telescope.load_extension("harpoon")

	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")
	local fb = telescope.extensions.file_browser
	local function get_cwd()
		return vim.fn.expand("%:p:h")
	end

	vim.keymap.set("n", "<C-f>", function()
		builtin.current_buffer_fuzzy_find({ prompt_title = "Search Buffer" })
	end)

	vim.keymap.set("n", "<Leader>fl", function()
		builtin.live_grep({
			prompt_title = "Search Project",
			glob_pattern = "!node_modules/*"
		})
	end)

	vim.keymap.set("n", "<Leader>ff", function()
		builtin.find_files(themes.get_ivy({
			prompt_title = "Search Files",
			hidden = true,
			follow = true,
			layout_config = {
				height = 0.4
			}
		}))
	end)

	vim.keymap.set("n", "<Leader>fd", function()
		builtin.diagnostics(themes.get_dropdown({
			prompt = "Diagnostics",
			layout_config = {
				height = 0.4
			}
		}))
	end)

	vim.keymap.set("n", "<Leader>fs", function()
		builtin.lsp_workspace_symbols(themes.get_dropdown({
			prompt = "Symbols",
			layout_config = {
				height = 0.4
			}
		}))
	end)

	vim.keymap.set("n", "<Leader>fr", function()
		builtin.lsp_references({
			prompt = "References",
			layout_strategy = "cursor",
			layout_config = {
				height = 0.5,
				width = 0.8,
			}
		})
	end)

	vim.keymap.set("n", "<Leader><Tab>", function()
		builtin.buffers(themes.get_dropdown({
			prompt_title = "Buffers",
			previewer = false,
			initial_mode = "normal",
			layout_config = {
				width = 0.5,
				height = 0.5,
				anchor = "N",
				prompt_position = "bottom"
			}
		}))
	end)

	vim.keymap.set("n", "<C-/>", function()
		builtin.grep_string({
			layout_strategy = "cursor",
			layout_config = {
				height = 0.5,
				width = 0.75
			}
		})
	end)

	vim.keymap.set("n", "<Leader>e", function()
		fb.file_browser(themes.get_dropdown({
			previewer = false,
			hidden = true,
			cwd = get_cwd(),
			initial_mode = "normal"
		}))
	end)

	local ui = require("harpoon.ui")
	local mark = require("harpoon.mark")

	vim.keymap.set("n", "<Leader>a", mark.add_file)
	vim.keymap.set("n", "<Leader>j", ui.toggle_quick_menu)
	vim.keymap.set("n", "<F1>", function() ui.nav_file(1) end)
	vim.keymap.set("n", "<F2>", function() ui.nav_file(2) end)
	vim.keymap.set("n", "<F3>", function() ui.nav_file(3) end)
	vim.keymap.set("n", "<F4>", function() ui.nav_file(4) end)
end

------------------------------------------------
--[[ feline ]]--

local feline_ok, feline = pcall(require, "feline")
local palette_ok, palette = pcall(require, "catppuccin.palettes")
local git_ok, git = pcall(require, "gitsigns")

if feline_ok and palette_ok and git_ok then
	palette = palette.get_palette()
	local feline_lsp = require("feline.providers.lsp")
	local lsp_severity = vim.diagnostic.severity

	local assets = {
		left_separator = "",
		right_separator = "",
		bar = "█",
		mode_icon = "",
		dir = "  ",
		file = "  ",
		lsp = {
			server = "  ",
			error = "  ",
			warning = "  ",
			info = "  ",
			hint = "  ",
		},
		git = {
			branch = "  ",
			added = "  ",
			changed = "  ",
			removed = "  ",
		},
	}

	local mode_colors = {
		["n"] = { "normal", palette.lavender },
		["no"] = { "n-pending", palette.lavender },
		["i"] = { "insert", palette.lavender },
		["ic"] = { "insert", palette.lavender },
		["t"] = { "terminal", palette.lavender },
		["v"] = { "visual", palette.lavender },
		["V"] = { "v-line", palette.lavender },
		[""] = { "v-block", palette.lavender },
		["R"] = { "replace", palette.lavender },
		["Rv"] = { "v-replace", palette.lavender },
		["s"] = { "select", palette.lavender },
		["S"] = { "s-line", palette.lavender },
		[""] = { "s-block", palette.lavender },
		["c"] = { "command", palette.lavender },
		["cv"] = { "command", palette.lavender },
		["ce"] = { "command", palette.lavender },
		["r"] = { "prompt", palette.lavender },
		["rm"] = { "more", palette.lavender },
		["r?"] = { "confirm", palette.lavender },
		["!"] = { "shell", palette.lavender },
	}

	git.setup({
		signcolumn = false
	})

	local statusbar_components = {
		active = { {}, {}, {} },
		inactive = { {}, {}, {} },
	}

	statusbar_components.active[1][1] = {
		provider = assets.bar,
		hl = {
			bg = palette.mantle,
			fg = mode_colors[vim.fn.mode()][2],
		},
	}

	statusbar_components.active[1][2] = {
		provider = assets.mode_icon,
		hl = {
			bg = palette.mantle,
			fg = mode_colors[vim.fn.mode()][2],
		},
	}

	statusbar_components.active[1][3] = {
		provider = function()
			return " " .. mode_colors[vim.fn.mode()][1] .. " "
		end,
		hl = {
			bg = palette.mantle,
			fg = mode_colors[vim.fn.mode()][2],
		},
	}

	statusbar_components.active[1][4] = {
		provider = "git_branch",
		icon = assets.git.branch,
		hl = {
			bg = palette.mantle,
			fg = palette.yellow,
		},
		right_sep = assets.bar,
	}

	statusbar_components.active[1][5] = {
		provider = "git_diff_added",
		hl = {
			fg = palette.green,
			bg = palette.mantle,
		},
		icon = assets.git.added,
	}

	statusbar_components.active[1][6] = {
		provider = "git_diff_changed",
		hl = {
			fg = palette.orange,
			bg = palette.mantle,
		},
		icon = assets.git.changed,
	}

	statusbar_components.active[1][7] = {
		provider = "git_diff_removed",
		hl = {
			fg = palette.red,
			bg = palette.mantle,
		},
		icon = assets.git.removed,
	}

	statusbar_components.active[3][1] = {
		provider = function()
			return "<" .. vim.opt.filetype._value .. ">"
		end,
		hl = {
			fg = palette.surface0,
			bg = palette.mantle,
		},
	}

	statusbar_components.active[3][2] = {
		provider = "diagnostic_hints",
		enabled = function()
			return feline_lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = {
			fg = palette.text,
			bg = palette.mantle,
		},
		icon = assets.lsp.hint,
	}

	statusbar_components.active[3][3] = {
		provider = "diagnostic_info",
		enabled = function()
			return feline_lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = palette.teal,
			bg = palette.mantle,
		},
		icon = assets.lsp.info,
	}

	statusbar_components.active[3][4] = {
		provider = "diagnostic_warnings",
		enabled = function()
			return feline_lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = {
			fg = palette.yellow,
			bg = palette.mantle,
		},
		icon = assets.lsp.warning,
	}

	statusbar_components.active[3][5] = {
		provider = "diagnostic_errors",
		enabled = function()
			return feline_lsp.diagnostics_exist(lsp_severity.ERROR)
		end,
		hl = {
			fg = palette.red,
			bg = palette.mantle,
		},
		icon = assets.lsp.error,
	}

	statusbar_components.active[3][6] = {
		provider = function()
			if next(vim.lsp.buf_get_clients()) ~= nil then
				return assets.lsp.server
			else
				return ""
			end
		end,
		hl = {
			fg = palette.blue,
			bg = palette.mantle,
		},
		left_separator = " ",
	}

	statusbar_components.active[3][7] = {
		provider = "line_percentage",
		left_sep = assets.bar,
		right_sep = assets.bar,
		hl = {
			bg = palette.mantle,
			fg = palette.lavender,
		},
	}

	statusbar_components.active[3][8] = {
		provider = assets.bar,
		hl = {
			bg = palette.lavender,
			fg = palette.lavender,
		},
	}

	feline.setup {
		components = statusbar_components,
	}

	feline.winbar.setup()
end

------------------------------------------------
