--[[ neovim 0.8 ]]--
-- https://github.com/AlphaKeks

local M = {}

--[[ editor settings ]]--
M.settings = {
	cdhome = true,
	confirm = true,
	clipboard = "unnamedplus",
	fileencoding = "utf-8",
	filetype = "on",
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
	colorcolumn = "100",
	formatoptions = "crqn2lj",
	guicursor = "a:block,i:ver50,v:hor50,r:hor50",
	guifont = "JetBrains Mono:h16",
	laststatus = 3,
	list = false,
	listchars = {
		tab = "» ",
		space = "·"
	},
	number = true,
	relativenumber = true,
	scrolloff = 8,
	sidescrolloff = 8,
	showmode = false,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	textwidth = 0,
	wrap = true,
	wrapmargin = 8,

	hlsearch = false,
	incsearch = true,
	ignorecase = true,
}

for k, v in pairs(M.settings) do
	vim.opt[k] = v
end

--[[ autocmds ]]--
M.augroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end
M.autocmd = vim.api.nvim_create_autocmd

M.groups = {}
M.groups.autism = M.augroup("Autism")

M.autocmd("ModeChanged", {
	group = M.groups.autism,
	pattern = { "*:v", "*:V" },
	callback = function()
		vim.opt.list = true
	end,
})

M.autocmd("ModeChanged", {
	group = M.groups.autism,
	pattern = { "v:*", "V:*" },
	callback = function()
		vim.opt.list = false
	end,
})

M.autocmd("FileType", {
	group = M.groups.autism,
	pattern = { "*" },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.formatoptions = "crqn2lj"
		vim.opt.textwidth = 0
	end,
})

M.autocmd("FileType", {
	group = M.groups.autism,
	pattern = { "text", "markdown" },
	callback = function()
		vim.opt.expandtab = true
		vim.opt.formatoptions = "tcrqn2lj"
		vim.opt.textwidth = 100
	end,
})

--[[ keymaps ]]--
M.map = function(modes, lhs, rhs)
	vim.keymap.set(modes, lhs, rhs, { silent = true })
end

M.map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

M.map("n", "<C-s>", ":w<cr>")
M.map("n", "<C-w>", ":bdelete<cr>")

M.map("n", "U", "<C-r>")
M.map("n", "x", "\"_x")
M.map("n", "dw", "diw")
M.map("n", "cw", "ciw")
M.map("n", "vw", "viw")
M.map("n", "yw", "yiw")
M.map("n", "cc", "\"_cc")
M.map({ "v", "x" }, "<leader>p", "\"_dP")

M.map("n", "J", "V:m '>+1<cr>gv=gv<esc>")
M.map("n", "K", "V:m '<-2<cr>gv=gv<esc>")
M.map({ "v", "x" }, "J", ":m '>+1<cr>gv=gv")
M.map({ "v", "x" }, "K", ":m '<-2<cr>gv=gv")

M.map("n", "<", "<<")
M.map("n", ">", ">>")
M.map({ "v", "x" }, "<", "<gv")
M.map({ "v", "x" }, ">", ">gv")

M.map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
M.map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
M.map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
M.map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")
M.map({ "n", "t" }, "H", "<cmd>bprevious<cr>")
M.map({ "n", "t" }, "L", "<cmd>bnext<cr>")
M.map({ "n", "t" }, "<leader>ss", "<cmd>split<cr>")
M.map({ "n", "t" }, "<leader>vs", "<cmd>vsplit<cr>")

M.map("n", "<leader><leader>", vim.lsp.buf.hover)
M.map("n", "gd", vim.lsp.buf.definition)
M.map("n", "gr", vim.lsp.buf.rename)
M.map("n", "ga", vim.lsp.buf.code_action)
M.map("n", "gi", vim.lsp.buf.implementation)
M.map("n", "gh", vim.lsp.buf.signature_help)
M.map("n", "gl", vim.diagnostic.open_float)
M.map("n", "gL", vim.diagnostic.goto_next)

M.map("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)")
M.map("v", "<leader>c", "<Plug>(comment_toggle_blockwise_visual)")
M.map("x", "<leader>c", "<Plug>(comment_toggle_linewise_visual)")

--[[ plugins ]]--
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		packer_path
	})

	print("Installing packer...")
	print("Close and reopen nvim once the installation has finished.")
	vim.cmd("packadd packer.nvim")
end

local packer_ok, packer = pcall(require, "packer")
if packer_ok then
	packer.startup(function(use)
		use("wbthomason/packer.nvim")
		use({ "catppuccin/nvim", as = "catppuccin" })

		use({ "nvim-lua/plenary.nvim" })
		use({ "nvim-treesitter/nvim-treesitter" })
		use({ "neovim/nvim-lspconfig" })
		use({ "hrsh7th/nvim-cmp" })

		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
		use({ "hrsh7th/cmp-path" })

		use({ "L3MON4D3/LuaSnip" })
		use({ "saadparwaiz1/cmp_luasnip" })

		use ({ "simrat39/rust-tools.nvim" })

		use({ "windwp/nvim-autopairs" })
		use({ "windwp/nvim-ts-autotag" })
		use({ "numToStr/Comment.nvim" })

		use({ "nvim-telescope/telescope.nvim" })
		use({ "nvim-telescope/telescope-file-browser.nvim" })
		use({ "ThePrimeagen/harpoon" })

		use({ "jose-elias-alvarez/null-ls.nvim" })
		use({ "williamboman/mason.nvim" })
		use({ "feline-nvim/feline.nvim" })
		use({ "lewis6991/gitsigns.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })
		use({ "akinsho/toggleterm.nvim" })

		if PACKER_BOOTSTRAP then
			packer.sync()
		end

	end)
end

--[[ catppuccin ]]--
local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if catppuccin_ok then
	vim.g.catppuccin_flavour = "mocha"
	local palette = require("catppuccin.palettes").get_palette()

	catppuccin.setup({
		transparent_background = true,
		styles = {
			comments = { "italic" },
			properties = { "italic" },
			types = { "bold" },
		},
		integrations = {
			markdown = true,
			cmp = true,
			treesitter = true,
			telescope = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "bold" },
					warnings = { "italic" },
				},
			},
		},
		custom_highlights = {
			-- transparency fixes
			WinSeparator = { bg = "NONE", fg = "NONE" },
			NormalFloat = { bg = "NONE" },
			DiagnosticError = { bg = "NONE" },
			DiagnosticWarn = { bg = "NONE" },
			DiagnosticInfo = { bg = "NONE" },
			DiagnosticHint = { bg = "NONE" },
			DiagnosticVirtualTextError = { bg = "NONE" },
			DiagnosticVirtualTextWarn = { bg = "NONE" },
			DiagnosticVirtualTextInfo = { bg = "NONE" },
			DiagnosticVirtualTextHint = { bg = "NONE" },

			-- editor
			CursorLine = { bg = palette.surface0 },
			EndOfBuffer = { fg = "#7480C2" },
			Whitespace = { fg = palette.surface2 },

			-- syntax
			-- ["@field"] = { fg = palette.blue },
			-- ["@property"] = { fg = palette.blue },
			--
			-- ["@include"] = { fg = palette.subtext0 },
			-- Operator = { fg = palette.yellow },
			-- ["@operator"] = { fg = palette.yellow },
			-- Keyword = { fg = palette.sky },
			-- ["@keyword.operator"] = { fg = palette.sky },
			-- ["@punctuation.special"] = { fg = palette.sky },
			--
			-- Number = { fg = palette.yellow },
			-- ["@number"] = { fg = palette.yellow },
			-- Float = { fg = palette.yellow },
			-- ["@float"] = { fg = palette.yellow },
			-- Boolean = { fg = palette.yellow },
			-- ["@boolean"] = { fg = palette.yellow },
			--
			-- ["@constructor"] = { fg = palette.sapphire },
			-- Constant = { fg = palette.sapphire },
			-- ["@constant"] = { fg = palette.sapphire },
			-- ["@constant.builtin"] = { fg = palette.sapphire },
			-- Conditional = { fg = palette.sky },
			-- ["@conditional"] = { fg = palette.sky },
			-- Repeat = { fg = palette.sky },
			-- ["@repeat"] = { fg = palette.sky },
			-- ["@exception"] = { fg = palette.sky },
			--
			-- ["@namespace"] = { fg = palette.pink },
			-- Type = { fg = palette.sapphire },
			-- ["@type"] = { fg = palette.sapphire },
			-- ["@type.builtin"] = { fg = palette.sapphire },
			--
			-- Function = { fg = palette.sky },
			-- ["@function"] = { fg = palette.sky },
			-- ["@function.macro"] = { fg = palette.sky },
			-- ["@parameter"] = { fg = palette.lavender },
			-- ["@keyword"] = { fg = palette.sky },
			-- ["@keyword.function"] = { fg = palette.sky },
			-- ["@keyword.return"] = { fg = palette.sky },
			-- ["@method"] = { fg = palette.blue },
			--
			-- Delimiter = { fg = palette.sapphire },
			-- ["@punctuation.delimiter"] = { fg = palette.sapphire },
			-- ["@punctuation.bracket"] = { fg = palette.sapphire },
			--
			-- String = { fg = palette.lavender },
			-- ["@string"] = { fg = palette.lavender },
			-- ["@string.regex"] = { fg = palette.mauve },
			-- ["@variable"] = { fg = palette.blue },
			-- ["@variable.builtin"] = { fg = palette.sapphire },
			-- ["@tag"] = { fg = palette.blue },
			-- ["@tag.delimiter"] = { fg = palette.blue },
			--
			-- ["@text"] = { fg = palette.text },
			--
			-- Character = { fg = palette.teal },
			-- Identifier = { fg = palette.sky },
			-- Statement = { fg = palette.sky },
			-- Structure = { fg = palette.sky },
			-- Error = { fg = palette.red },
			-- Todo = { fg = palette.mauve },
		},
	})

	vim.cmd("colorscheme catppuccin")
end

--[[ treesitter ]]--
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_ok then
	treesitter.setup({
		ensure_installed = "all",
		ignore_install = {},
		highlight = { enable = true },
		indent = {
			enable = true,
			disable = { "python" },
		},
		autopairs = { enable = true },
	})

	local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
	if autopairs_ok then
		autopairs.setup({
			check_ts = true,
			disable_filetypes = {
				"TelescopePrompt",
			},
		})
	end

	local autotag_ok, autotag = pcall(require, "nvim-ts-autotag")
	if autotag_ok then
		autotag.setup()
	end

	local comment_ok, comment = pcall(require, "Comment")
	if comment_ok then
		comment.setup({
			mappings = {
				basic = false,
				extra = false,
			},
		})
	end
end

--[[ LSP ]]--
local lsp_ok, lsp = pcall(require, "lspconfig")
if lsp_ok then
	M.format_on_save = function(client, bufnr)
		M.groups.lsp = M.augroup("LSPGroup")
		M.autocmd("BufWritePre", {
			group = M.groups.lsp,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end
		})
	end

	M.on_attach = function(client, bufnr)
		M.format_on_save(client, bufnr)
	end

	M.capabilities = vim.lsp.protocol.make_client_capabilities()

	local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then
		M.capabilities = cmp.default_capabilities()
	end

	vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })

	vim.diagnostic.config {
		virtual_text = true,
		signs = { active = signs },
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
			border = "rounded"
		},
	}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	M.servers = {
		"bashls",
		"cssls",
		"clangd",
		"emmet_ls",
		"html",
		"jsonls",
	}

	for _, server in ipairs(M.servers) do
		lsp[server].setup({
			on_attach = M.on_attach,
			capabilities = M.capabilities,
		})
	end

	-- lsp["rust_analyzer"].setup({
	-- 	on_attach = function(client, bufnr)
	-- 		client.server_capabilities.document_formatting = false
	-- 		client.server_capabilities.document_range_formatting = false
	-- 	end,
	-- 	capabilities = M.capabilities,
	-- })

	local rust_ok, rt = pcall(require, "rust-tools")
	if rust_ok then
		rt.setup({
			tools = {
				inlay_hints = {
					auto = true,
					only_current_line = true,
					show_parameter_hints = true,
					highlight = "Comment",
				},
				server = {
					standalone = true,
					on_attach = function(client, _bufnr)
						client.server_capabilities.document_formatting = false
						client.server_capabilities.document_range_formatting = false
					end
				}
			}
		})
	end

	lsp["tsserver"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
		capabilities = M.capabilities,
	})

	local null_ls_ok, null_ls = pcall(require, "null-ls")
	if null_ls_ok then
		local diag = null_ls.builtins.diagnostics
		local format = null_ls.builtins.formatting
		local actions = null_ls.builtins.code_actions

		M.null_sources = {
			format.prettierd.with({
				env = {
					PRETTIERD_DEFAULT_CONFIG = "/home/max/.config/prettier/prettier.config.js"
				},
			}),
			format.rustfmt.with({
				extra_args = { "--edition=2021" },
			})
		}

		local eslint_check = vim.fs.find({
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
			"eslint.config.js"
		}, {
			upward = true,
			stop = "/home/max",
			type = "file",
			limit = 1,
		})

		if eslint_check[1] then
			table.insert(M.null_sources, diag.eslint_d)
			table.insert(M.null_sources, actions.eslint_d)
		end

		null_ls.setup({
			debug = false,
			sources = M.null_sources,
			on_attach = M.on_attach,
		})

		M.autocmd("LspDetach", {
			group = M.groups.lsp,
			buffer = bufnr,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				-- kill prettier and eslint when not used
				if client.name == "null-ls" then
					os.execute("if [[ $(pgrep eslint_d | wc -l) -gt 0 ]]; then killall eslint_d; fi")
					os.execute("if [[ $(pgrep prettierd | wc -l) -gt 0 ]]; then killall prettierd; fi")
				end
			end
		})
	end

	local mason_ok, mason = pcall(require, "mason")
	if mason_ok then
		mason.setup()
	end
end

--[[ cmp ]]--
local cmp_ok, cmp = pcall(require, "cmp")
local ls_ok, ls = pcall(require, "luasnip")

if cmp_ok and lsp_ok then
	M.icons = {
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

	local snip = ls.snippet
	local inode = ls.insert_node
	local tnode = ls.text_node
	local fmt = require("luasnip.extras.fmt").fmt
	local same = function(index)
		return ls.function_node(function(arg)
			return arg[1]
		end, { index })
	end

	ls.add_snippets("css", {
		snip("rosewater", tnode("#f5e0dc")),
		snip("flamingo", tnode("f2cdcd")),
		snip("pink", tnode("#f5c2e7")),
		snip("mauve", tnode("#cba6f7")),
		snip("red", tnode("#f38ba8")),
		snip("maroon", tnode("#eba0ac")),
		snip("peach", tnode("#fab387")),
		snip("yellow", tnode("#f9e2af")),
		snip("green", tnode("#a6e3a1")),
		snip("teal", tnode("#94e2d5")),
		snip("sky", tnode("#89dceb")),
		snip("sapphire", tnode("#74c7ec")),
		snip("blue", tnode("#89b4fa")),
		snip("lavender", tnode("#b4befe")),
		snip("text", tnode("#cdd6f4")),
		snip("subtext1", tnode("#bac2de")),
		snip("subtext0", tnode("#a6adc8")),
		snip("overlay2", tnode("#9399b2")),
		snip("overlay1", tnode("#7f849c")),
		snip("overlay0", tnode("#6c7086")),
		snip("surface2", tnode("#585b70")),
		snip("surface1", tnode("#45475a")),
		snip("surface0", tnode("#313244")),
		snip("base", tnode("#1e1e2e")),
		snip("mantle", tnode("#181825")),
		snip("crust", tnode("#11111b"))
	})

	ls.add_snippets("typescript", {
		snip("imp", fmt([[import {{ {1} }} from "{2}";]], {
			inode(1, ""),
			inode(2, ""),
		})),

		snip("fn", fmt([[
			{5}function {1}({2}): {3} {{
				{4}
			}}
		]], {
			inode(1, "myFunction"),
			inode(2, "args: any"),
			inode(3, "void"),
			inode(4, ""),
			inode(5, ""),
		})),
	})

	ls.add_snippets("rust", {
		snip("sfn", fmt(
			[[
				pub fn {1}(&mut self, {2}: {3}) {{
					self.{4} = Some({5});
				}}
			]],
			{
				inode(1),
				inode(2),
				inode(3),
				same(1),
				same(2),
			})
		),

		snip("test", fmt(
			[[
				#[tokio::test]
				async fn {1}_test() {{
					let client = reqwest::Client::new();

					match {2}
				}}
			]],
			{
				inode(1, "function"),
				inode(2),
			})
		),

		snip("err!", fmt(
			[[
				log::error!(
					"[{{}}]: {{}} => {{}}",
					file!(), line!(), "{}", {}
				);
			]],
			{
				inode(1, "message"),
				inode(2),
			}
		))
	})

	cmp.setup({
		snippet = {
			expand = function(args)
				ls.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert {
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<cr>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif ls.expandable() then
					ls.expand()
				elseif ls.expand_or_jumpable() then
					ls.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif ls.jumpable(-1) then
					ls.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-n>"] = cmp.mapping(function(fallback)
				if ls.expandable() then
					ls.expand()
				elseif ls.expand_or_jumpable() then
					ls.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-p>"] = cmp.mapping(function(fallback)
				if ls.jumpable(-1) then
					ls.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" })
		},
		formatting = {
			format = function(_entry, vim_item)
				vim_item.kind = M.icons[vim_item.kind] or ""
				return vim_item
			end
		},
		experimental = {
			ghost_text = true,
		},
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "path" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})

	local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	local handlers_ok, handlers = pcall(require, "nvim-autopairs.completion.handlers")
	if cmp_autopairs_ok and handlers_ok then
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
			filetypes = {
				["*"] = {
					["("] = {
						kind = {
							cmp.lsp.CompletionItemKind.Function,
							cmp.lsp.CompletionItemKind.Method,
						},
						handler = handlers["*"],
					}
				}
			}
		}))
	end
end

--[[ telescope ]]--
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	local actions = require("telescope.actions")
	local fb_actions = telescope.extensions.file_browser.actions

	telescope.setup({
		defaults = {
			prompt_prefix = "» ",
			selection_caret = ">",
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<esc>"] = actions.close,
				},
			},
		},
		extensions = {
			file_browser = {
				theme = "dropdown",
				hijack_netrw = true,
				hidden = true,
				previewer = false,
				initial_mode = "normal";
				mappings = {
					n = {
						a = fb_actions.create,
						d = fb_actions.remove,
						r = fb_actions.rename,
					},
					i = {
						["<C-a>"] = fb_actions.create,
						["<C-d>"] = fb_actions.remove,
						["<C-r>"] = fb_actions.rename,
						["<esc>"] = actions.close,
					},
				},
			},
		},
	})

	telescope.load_extension("file_browser")
	telescope.load_extension("harpoon")

	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")
	local fb = telescope.extensions.file_browser

	local cwd = vim.fn.expand("%:p:h")

	M.map("n", "<leader>ff", function()
		builtin.find_files(themes.get_dropdown {
			prompt_title = cwd,
			previewer = false,
			hidden = true,

			layout_config = {
				width = 0.45,
				height = 0.45
			}
		})
	end)

	M.map("n", "<leader>fl", function()
		builtin.live_grep(themes.get_dropdown {
			prompt_title = "~ live grep ~",
			previewer = false,
			hidden = true,

			layout_config = {
				width = 0.4,
				height = 0.4,
				anchor = "NE"
			}
		})
	end)

	M.map("n", "<leader><tab>", function()
		builtin.buffers(themes.get_dropdown {
			prompt_title = "~ buffers ~",
			previewer = false,
			initial_mode = "normal",

			layout_config = {
				width = 0.65,
				height = 0.25,
				anchor = "N",
				prompt_position = "bottom"
			}
		})
	end)

	M.map("n", "<leader>fg", function()
		builtin.git_commits(themes.get_dropdown {
			prompt_title = "~ commits ~",
			initial_mode = "normal",

			layout_config = {
				width = 0.75,
				height = 0.9,
			}
		})
	end)

	M.map("n", "<leader>fr", function()
		builtin.lsp_references(themes.get_ivy {
			prompt_title = "LSP references",
			
			layout_config = {
				height = 0.35
			}
		})
	end)

	M.map("n", "<leader>df", function()
		fb.file_browser(themes.get_dropdown {
			prompt_title = "~/.dotfiles",
			previewer = false,
			hidden = true,
			cwd = "~/.dotfiles",
			initial_mode = "normal",

			layout_config = {
				width = 0.45,
				height = 0.45
			}
		})
	end)

	M.map("n", "<leader>e", function()
		fb.file_browser(themes.get_dropdown {
			previewer = false,
			hidden = true,
			cwd = vim.fn.expand("%:p:h"),
			initial_mode = "normal",

			layout_config = {
				width = 0.45,
				height = 0.45
			}
		})
	end)

	M.map("n", "<C-f>", function()
		builtin.current_buffer_fuzzy_find(themes.get_dropdown {
			prompt_title = "~ buffer grep ~",
			previewer = false,
			hidden = true,

			layout_config = {
				width = 0.4,
				height = 0.4,
				anchor = "NE"
			}
		})
	end)

	local ui = require("harpoon.ui")
	local mark = require("harpoon.mark")

	M.map("n", "<leader>a", mark.add_file)
	M.map("n", "<leader>j", ui.toggle_quick_menu)

	M.map("n", "<F1>", function() ui.nav_file(1) end)
	M.map("n", "<F2>", function() ui.nav_file(2) end)
	M.map("n", "<F3>", function() ui.nav_file(3) end)
	M.map("n", "<F4>", function() ui.nav_file(4) end)
end

--[[ feline ]]--
local feline_ok, feline = pcall(require, "feline")
local palette_ok, palette = pcall(require, "catppuccin.palettes")
local git_ok, git = pcall(require, "gitsigns")

if feline_ok and palette_ok and git_ok then
	palette = palette.get_palette()
	local lsp = require("feline.providers.lsp")
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

	local function any_git_changes()
		local gst = vim.b.gitsigns_status_dict -- git stats
		if gst then
			if
				gst["added"] and gst["added"] > 0
				or gst["removed"] and gst["removed"] > 0
				or gst["changed"] and gst["changed"] > 0
			then
				return true
			end
		end
		return false
	end

	local statusbar_components = {
		active = {
			{},
			{},
			{},
		},
		inactive = {
			{},
			{},
			{},
		},
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
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = {
			fg = palette.text,
			bg = palette.mantle,
		},
		icon = assets.lsp.hint,
	}

	statusbar_components.active[3][2] = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = palette.teal,
			bg = palette.mantle,
		},
		icon = assets.lsp.info,
	}

	statusbar_components.active[3][3] = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = {
			fg = palette.yellow,
			bg = palette.mantle,
		},
		icon = assets.lsp.warning,
	}

	statusbar_components.active[3][4] = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
		end,
		hl = {
			fg = palette.red,
			bg = palette.mantle,
		},
		icon = assets.lsp.error,
	}

	statusbar_components.active[3][5] = {
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

	statusbar_components.active[3][6] = {
		provider = "line_percentage",
		left_sep = assets.bar,
		right_sep = assets.bar,
		hl = {
			bg = palette.mantle,
			fg = palette.lavender,
		},
	}

	statusbar_components.active[3][7] = {
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

local term_ok, term = pcall(require, "toggleterm")
if term_ok then
	term.setup {
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = { border = "curved" },
	}

	M.map({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>")
end
