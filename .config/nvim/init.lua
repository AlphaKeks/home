--[[ neovim 0.8 ]]--
-- https://github.com/AlphaKeks

pcall(require, "impatient")

--[[ editor settings ]]--
vim.opt.confirm = true
vim.opt.filetype = "on"
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
vim.opt.undofile = true
vim.opt.updatetime = 69
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.copyindent = true
vim.opt.expandtab = false
vim.opt.preserveindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"
vim.opt.foldcolumn = "0"
vim.opt.formatoptions = "crqn2lj"
vim.opt.guicursor = "a:block,i:ver25,v:hor10,r-cr-o:hor20"
vim.opt.guifont = "JetBrains_Mono:h16"
vim.opt.laststatus = 3
vim.opt.list = false
vim.opt.listchars = { tab = "» ", space = "·" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.iskeyword = "@,48-57,192-255"

--[[ autocmds ]]--
function _AUGROUP(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end
_AUTOCMD = vim.api.nvim_create_autocmd

_AUGROUPS = {}
_AUGROUPS.autism = _AUGROUP("Autism")

_AUTOCMD("ModeChanged", {
	group = _AUGROUPS.autism,
	pattern = { "*:v", "*:V" },
	callback = function()
		vim.opt.list = true
	end,
})

_AUTOCMD("ModeChanged", {
	group = _AUGROUPS.autism,
	pattern = { "v:*", "V:*" },
	callback = function()
		vim.opt.list = false
	end,
})

_AUTOCMD("FileType", {
	group = _AUGROUPS.autism,
	pattern = { "*" },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.formatoptions = "crqn2lj"
		vim.opt.textwidth = 0
	end,
})

_AUTOCMD("FileType", {
	group = _AUGROUPS.autism,
	pattern = { "text", "markdown" },
	callback = function()
		vim.opt.expandtab = true
		vim.opt.formatoptions = "tcrqn2lj"
		vim.opt.textwidth = 100
	end,
})

_AUTOCMD("TextYankPost", {
	group = _AUGROUPS.autism,
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 69,
		})
	end,
})

--[[ neovide ]]--
if vim.g.neovide then
	-- open neovide in my projects directory
	_AUTOCMD("VimEnter", {
		pattern = "*",
		callback = function()
			vim.cmd("cd ~/projects")
		end
	})

	vim.g.neovide_transparency = 0.2
	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_refresh_rate = 240
	vim.g.neovide_refresh_rate_idle = 240
	vim.g.neovide_no_idle = true

	vim.g.neovide_cursor_animation_length = 0.05
end

--[[ keymaps ]]--
map = function(modes, lhs, rhs)
	vim.keymap.set(modes, lhs, rhs, { silent = true })
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

map("n", "<C-s>", ":w<cr>")
map("n", "<C-w>", ":close<cr>")

map("n", "U", "<C-r>")
map("n", "x", "\"_x")
map("v", "p", "\"_dP")

map({ "n", "v" }, "<leader>y", "\"+y")
map({ "n", "v" }, "<leader>Y", "\"+Y")
map({ "n", "v" }, "<leader>p", "\"+p")

map("n", "J", "V:m '>+1<cr>gv=gv<esc>")
map("n", "K", "V:m '<-2<cr>gv=gv<esc>")
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

map("n", "<", "<<")
map("n", ">", ">>")
map("v", "<", "<gv")
map("v", ">", ">gv")

map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")
map({ "n", "t" }, "H", "<cmd>tabprevious<cr>")
map({ "n", "t" }, "L", "<cmd>tabnext<cr>")
map({ "n", "t" }, "<leader>ss", "<cmd>split<cr>")
map({ "n", "t" }, "<leader>vs", "<cmd>vsplit<cr>")
map({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>")
map({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>")
map({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>")
map({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>")

map("n", "<C-t>", "<cmd>tabnew<cr><cmd>term<cr>A")
map("n", "<C-g>", "<cmd>tabnew<cr><cmd>term lazygit<cr>I")
map("t", "<C-w>", "<cmd>tabclose<cr>")
map("t", "<leader><esc>", "<C-\\><C-n>")

map("n", "<leader><leader>", vim.lsp.buf.hover)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.type_definition)
-- map("n", "gr", vim.lsp.buf.rename)
map("n", "gr", function()
	vim.ui.input({ prompt = "new name > " }, function(input)
		vim.lsp.buf.rename(input)
	end)
end)
map("n", "ga", vim.lsp.buf.code_action)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gh", vim.lsp.buf.signature_help)
map("n", "gl", vim.diagnostic.open_float)
map("n", "gL", vim.diagnostic.goto_next)
map("n", "<leader>h", vim.lsp.buf.document_highlight)

map("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)")
map("v", "<leader>c", "<Plug>(comment_toggle_blockwise_visual)")
map("x", "<leader>c", "<Plug>(comment_toggle_linewise_visual)")

--[[ netrw ]]--
vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0

map("n", "<leader>E", function()
	if vim.opt.filetype._value == "netrw" then
		vim.cmd("close")
	else
		vim.cmd("Sex")
	end
end)

map("n", "<leader>e", function()
	if vim.opt.filetype._value == "netrw" then
		vim.cmd("close")
	else
		vim.cmd("Ex")
	end
end)

_AUTOCMD("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "a", "<Plug>NetrwOpenFile", { remap = true, buffer = true })
		vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
	end
})

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
		use({ "wbthomason/packer.nvim" })

		-- theme
		use({ "catppuccin/nvim", as = "catppuccin" })

		-- base plugins
		use({ "nvim-lua/plenary.nvim" })
		use({ "lewis6991/impatient.nvim" })
		use({
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"windwp/nvim-autopairs",
				"windwp/nvim-ts-autotag",
				"numToStr/Comment.nvim",
				"nvim-treesitter/playground"
			}
		})
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"jose-elias-alvarez/null-ls.nvim"
			}
		})
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-path",
				-- snippets
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip"
			}
		})

		--[[ nvim-cmp alternative (config is wacky though)
		use({
			"ms-jpq/coq_nvim",
			requires = {
				"ms-jpq/coq.artifacts",
				"ms-jpq/coq.thirdparty"
			}
		})
		]]--

		-- blazingly fast file management
		use({ "nvim-telescope/telescope.nvim" })
		use({ "ThePrimeagen/harpoon" })

		-- UI
		use({ "feline-nvim/feline.nvim" })
		use({ "lewis6991/gitsigns.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })

		-- cool to have
		use({ "williamboman/mason.nvim" })
		use({ "ThePrimeagen/vim-be-good" })

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

	local function has_firacode()
		if os.getenv("FIRACODE") then
			return true
		else
			return false
		end
	end

	catppuccin.setup({
		transparent_background = true,
		styles = {
			comments = { "italic" },
		},
		no_italic = has_firacode(),
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
			TabLine = { fg = palette.surface0, bg = palette.crust },
			TabLineSel = { fg = palette.text, bg = palette.surface0 },
			IncSearch = { fg = palette.text, bg = "#7480C2" },

			-- plugin specific
			NvimTreeEndOfBuffer = { fg = palette.base },
		},
	})

	vim.cmd("colorscheme catppuccin")
end

--[[ treesitter ]]--
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_ok then
	treesitter.setup({
		ensure_installed = {},
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
	else
		local autopairs = {
			["("] = ")",
			["["] = "]",
			["{"] = "}",
			["\""] = "\"",
			["'"] = "'",
			["`"] = "`",
		}

		for k, v in pairs(autopairs) do
			vim.keymap.set("i", k, function()
				return k .. v .. "<Left>"
			end, { expr = true })
		end
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
	format_on_save = function(client, bufnr)
		_AUGROUPS.lsp = _AUGROUP("LSPGroup")
		_AUTOCMD("BufWritePre", {
			group = _AUGROUPS.lsp,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end
		})
	end

	on_attach = function(client, bufnr)
		format_on_save(client, bufnr)

		if client.name == "bashls" then return end -- bash causes issues with this for some reason
		_AUTOCMD({ "CursorMoved", "InsertCharPre" }, {
			group = _AUGROUPS.lsp,
			buffer = bufnr,
			callback = function()
				local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
				if node == nil then return end

				local node_text = vim.treesitter.get_node_text(node, 0)
				if vim.g.current_node ~= node_text then
					vim.g.current_node = node_text
					vim.lsp.buf.clear_references()

					local node_type = vim.treesitter.get_node_at_cursor()
					-- print("current node: " .. node_type)

					if node_type == "identifier" or node_type == "property_identifier" then
						vim.lsp.buf.document_highlight()
					end
				end
			end
		})
	end


	capabilities = vim.lsp.protocol.make_client_capabilities()

	local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then
		capabilities = cmp.default_capabilities()
	end

	vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
	vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })

	vim.diagnostic.config({
		virtual_text = {
			source = "if_many",
			prefix = "🤓"
		},
		signs = { active = signs },
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			source = "always",
			header = "",
			prefix = "",
			border = "rounded"
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	local servers = {
		"bashls",
		"cssls",
		"clangd",
		"emmet_ls",
		"html",
		"jsonls",
	}

	for _, server in ipairs(servers) do
		lsp[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	-- `lspconfig`
	lsp["rust_analyzer"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities,
	})

	-- `rust-tools.nvim`
	-- local rust_ok, rt = pcall(require, "rust-tools")
	-- if rust_ok then
	-- 	rt.setup({
	-- 		tools = {
	-- 			inlay_hints = {
	-- 				auto = true,
	-- 				only_current_line = true,
	-- 				show_parameter_hints = true,
	-- 				highlight = "Comment",
	-- 			},
	-- 			server = {
	-- 				standalone = true,
	-- 				on_attach = function(client, _bufnr)
	-- 					client.server_capabilities.document_formatting = false
	-- 					client.server_capabilities.document_range_formatting = false
	-- 				end
	-- 			}
	-- 		}
	-- 	})
	-- end

	lsp["tsserver"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities,
	})

	local null_ls_ok, null_ls = pcall(require, "null-ls")
	if null_ls_ok then
		local diag = null_ls.builtins.diagnostics
		local format = null_ls.builtins.formatting
		local actions = null_ls.builtins.code_actions

		local null_sources = {
			format.prettierd.with({
				env = {
					PRETTIERD_DEFAULT_CONFIG = os.getenv("HOME") .. "/.config/prettier/prettier.config.js"
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
			stop = os.getenv("HOME"),
			type = "file",
			limit = 1,
		})

		if eslint_check[1] then
			table.insert(null_sources, diag.eslint_d)
			table.insert(null_sources, actions.eslint_d)
		end

		null_ls.setup({
			debug = false,
			sources = null_sources,
			on_attach = on_attach,
		})

		_AUTOCMD("LspDetach", {
			group = _AUGROUPS.lsp,
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
if ls_ok then
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

		snip("err!", fmt([[log::error!("[{{}}]: {{}} => {{:?}}", file!(), line!(), why);]], {}))
	})

	local cmp_ok, cmp = pcall(require, "cmp")
	if cmp_ok then
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
					vim_item.kind = vim.g.icons[vim_item.kind] or ""
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
end

--[[ coq ]]--
vim.g.coq_settings = {
	auto_start = "shut-up",
	display = {
		ghost_text = {
			enabled = true
		},
		pum = {
			source_context = { "(", ")" }
		}
	},
	keymap = {
		-- disable default keymaps and set custom ones if autopairs is installed (see down below)
		-- recommended = (function()
		-- 	local ok, _ = pcall(require, "nvim-autopairs")
		-- 	if ok then
		-- 		return false
		-- 	else
		-- 		return true
		-- 	end
		-- end)(),
		recommended = false,
		manual_complete = "<C-Space>",
		jump_to_mark = "<C-j>",
		pre_select = true
	}
}

local coq_ok, coq = pcall(require, "coq")
if coq_ok then
	local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
	if autopairs_ok then
		vim.keymap.set("i", "<esc>", [[pumvisible() ? "<C-e><esc>" : "<esc>"]], { expr = true })
		vim.keymap.set("i", "<C-c>", [[pumvisible() ? "<C-e><C-c>" : "<C-c>"]], { expr = true })
		vim.keymap.set("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true })
		vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<bs>"]], { expr = true })

		vim.keymap.set("i", "<cr>", function()
			if vim.fn.pumvisible() ~= 0 then
				if vim.fn.complete_info({ "selected" }).selected ~= -1 then
					return autopairs.esc("<C-y>")
					-- -- automatically replace first arg in the snippet
					-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, false, true), "i", true)
					-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "i", true)
					-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a", true, false, true), "n", true)
					-- return
				else
					return autopairs.esc("<C-e>") .. autopairs.autopairs_cr()
				end
			else
				return autopairs.autopairs_cr()
			end
		end, { expr = true })
	end
end

--[[ telescope ]]--
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	local actions = require("telescope.actions")
	-- local fb_actions = telescope.extensions.file_browser.actions

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
			-- file_browser = {
			-- 	theme = "dropdown",
			-- 	hijack_netrw = true,
			-- 	hidden = true,
			-- 	previewer = false,
			-- 	initial_mode = "normal";
			-- 	mappings = {
			-- 		n = {
			-- 			a = fb_actions.create,
			-- 			d = fb_actions.remove,
			-- 			r = fb_actions.rename,
			-- 		},
			-- 		i = {
			-- 			["<C-a>"] = fb_actions.create,
			-- 			["<C-d>"] = fb_actions.remove,
			-- 			["<C-r>"] = fb_actions.rename,
			-- 			["<esc>"] = actions.close,
			-- 		},
			-- 	},
			-- },
		},
	})

	-- telescope.load_extension("file_browser")
	telescope.load_extension("harpoon")

	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")
	-- local fb = telescope.extensions.file_browser

	local cwd = vim.fn.expand("%:p:h")

	map("n", "<C-f>", function()
		builtin.current_buffer_fuzzy_find(themes.get_ivy({
			prompt_title = "Buffer Grep",
			hidden = true,
			layout_config = {
				height = 0.35,
			},
		}))
	end)

	map("n", "<leader>fl", function()
		builtin.live_grep(themes.get_ivy({
			prompt_title = "Project Grep",
			hidden = true,
			layout_config = {
				height = 0.35,
			},
		}))
	end)

	map("n", "<leader>ff", function()
		builtin.find_files({
			prompt_title = "Fuzzy Search",
			hidden = true,
		})
	end)

	map("n", "<leader><tab>", function()
		builtin.buffers(themes.get_dropdown({
			prompt_title = "Buffers",
			previewer = false,
			initial_mode = "normal",
			layout_config = {
				width = 0.5,
				height = 0.35,
				anchor = "N",
				prompt_position = "bottom"
			}
		}))
	end)

	map("n", "<leader>fr", function()
		builtin.lsp_references(themes.get_ivy({
			prompt_title = "LSP References",
			layout_config = {
				height = 0.35,
			},
		}))
	end)

	map("n", "<leader>fs", function()
		builtin.lsp_workspace_symbols(themes.get_ivy({
			prompt_title = "LSP Symbols",
			layout_config = {
				height = 0.35,
			},
		}))
	end)

	map("n", "<leader>fd", function()
		builtin.diagnostics(themes.get_ivy({
			prompt_title = "Diagnostics",
			layout_config = {
				height = 0.35,
			},
		}))
	end)

	-- map("n", "<leader>e", function()
	-- 	fb.file_browser(themes.get_dropdown({
	-- 		previewer = false,
	-- 		hidden = true,
	-- 		cwd = vim.fn.expand("%:p:h"),
	-- 		initial_mode = "normal",
	-- 		layout_config = {
	-- 			width = 0.65,
	-- 			height = 0.65,
	-- 		}
	-- 	}))
	-- end)

	-- map("n", "<leader>df", function()
	-- 	fb.file_browser(themes.get_dropdown({
	-- 		prompt_title = "~/.dotfiles",
	-- 		previewer = false,
	-- 		hidden = true,
	-- 		cwd = "~/.dotfiles",
	-- 		initial_mode = "normal",
	-- 		layout_config = {
	-- 			width = 0.65,
	-- 			height = 0.65,
	-- 		}
	-- 	}))
	-- end)

	local ui = require("harpoon.ui")
	local mark = require("harpoon.mark")

	map("n", "<leader>a", mark.add_file)
	map("n", "<leader>j", ui.toggle_quick_menu)

	map("n", "<F1>", function() ui.nav_file(1) end)
	map("n", "<F2>", function() ui.nav_file(2) end)
	map("n", "<F3>", function() ui.nav_file(3) end)
	map("n", "<F4>", function() ui.nav_file(4) end)
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
			return lsp.diagnostics_exist(lsp_severity.HINT)
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
			return lsp.diagnostics_exist(lsp_severity.INFO)
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
			return lsp.diagnostics_exist(lsp_severity.WARN)
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
			return lsp.diagnostics_exist(lsp_severity.ERROR)
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
