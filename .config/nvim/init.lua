vim.opt.colorcolumn = "100"
vim.opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.fillchars = { fold = " " }
vim.opt.foldenable = false
vim.opt.foldlevel = 1
vim.opt.foldmethod = "indent"
vim.opt.guicursor = "a:block-blinkwait0-blinkoff300-blinkon150,i:ver20,v:hor20-blinkon0,r:hor20"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "-" }
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 12
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
vim.opt.undofile = true
vim.opt.updatetime = 100

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.autoindent = true
		vim.opt.breakindent = true
		vim.opt.expandtab = false
		vim.opt.formatoptions = "crqn2lj"
		vim.opt.shiftwidth = 4
		vim.opt.tabstop = 4
		vim.opt.textwidth = 100
	end
})

vim.cmd.colorscheme("habamax")
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_bufsettings = "rnu"
vim.g.AlphaKeks = vim.api.nvim_create_augroup("AlphaKeks", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.highlight.on_yank({ timeout = 69 })
	end
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = true
		vim.wo.scrolloff = 0
	end
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<c-s>", vim.cmd.write)
vim.keymap.set("n", "<c-w>", vim.cmd.close)
vim.keymap.set("n", "U", "<c-r>")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>Y", "\"+y$")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")
vim.keymap.set("n", "J", "V:m '>+1<cr>gv=gv<esc>", { silent = true })
vim.keymap.set("n", "K", "V:m '<-2<cr>gv=gv<esc>", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set({ "n", "t" }, "<c-h>", function()
	vim.cmd.wincmd("h")
end)
vim.keymap.set({ "n", "t" }, "<c-j>", function()
	vim.cmd.wincmd("j")
end)
vim.keymap.set({ "n", "t" }, "<c-k>", function()
	vim.cmd.wincmd("k")
end)
vim.keymap.set({ "n", "t" }, "<c-l>", function()
	vim.cmd.wincmd("l")
end)
vim.keymap.set({ "n", "t" }, "<c-1>", function()
	vim.cmd.norm("1gt")
end)
vim.keymap.set({ "n", "t" }, "<c-2>", function()
	vim.cmd.norm("2gt")
end)
vim.keymap.set({ "n", "t" }, "<c-3>", function()
	vim.cmd.norm("3gt")
end)
vim.keymap.set({ "n", "t" }, "<c-4>", function()
	vim.cmd.norm("4gt")
end)
vim.keymap.set({ "n", "t" }, "<c-5>", function()
	vim.cmd.norm("5gt")
end)
vim.keymap.set("n", "<leader>ss", vim.cmd.split)
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set({ "n", "t" }, "<c-up>", function()
	vim.cmd.resize("+2")
end)
vim.keymap.set({ "n", "t" }, "<c-down>", function()
	vim.cmd.resize("-2")
end)
vim.keymap.set({ "n", "t" }, "<c-right>", function()
	vim.cmd("vertical resize +2")
end)
vim.keymap.set({ "n", "t" }, "<c-left>", function()
	vim.cmd("vertical resize -2")
end)
vim.keymap.set({ "n", "t" }, "<c-d>", "<c-d>zz")
vim.keymap.set({ "n", "t" }, "<c-u>", "<c-u>zz")
vim.keymap.set("t", "<c-esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<c-t>", function()
	vim.cmd.tabnew()
	vim.cmd.term()
end)
vim.keymap.set("n", "<c-cr>", "za")

vim.api.nvim_create_user_command("InstallPacker", function()
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim" })
	vim.cmd.packadd("packer.nvim")
end, {})

local packer_installed, packer = pcall(require, "packer")
if not packer_installed then
	print("packer is not installed")
	return
end

packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			local palette = require("catppuccin.palettes").get_palette()
			local colors = {
				none = "NONE",
				slate = "#3C5E7F",
				ponggers = "#7480C2"
			}

			require("catppuccin").setup({
				transparent_background = true,
				custom_highlights = {
					Comment = { fg = colors.slate },
					SpecialComment = { fg = colors.slate },
					Constant = { fg = palette.red },
					String = { fg = palette.lavender },
					Number = { fg = palette.red },
					Float = { link = "Number" },
					Boolean = { link = "Number" },
					Identifier = { fg = palette.lavender },
					Operator = { fg = palette.yellow },
					StorageClass = { fg = palette.sapphire },
					Structure = { fg = colors.ponggers },
					Type = { fg = colors.ponggers, italic = true, bold = true },
					Typedef = { fg = colors.ponggers, italic = true, bold = true },
					Delimiter = { fg = palette.sapphire },

					ColorColumn = { bg = palette.surface0 },
					CursorLine = { link = "ColorColumn" },
					CursorLineNr = { fg = palette.yellow },
					EndOfBuffer = { fg = colors.slate },
					IncSearch = { fg = palette.text, bg = "#7480c2" },
					MatchParen = { fg = palette.lavender },
					Whitespace = { fg = palette.surface2 },

					WinSeparator = { fg = colors.none, bg = colors.none },
					NormalFloat = { bg = colors.none },

					DiagnosticHint = { bg = colors.none },
					DiagnosticInfo = { bg = colors.none },
					DiagnosticWarn = { bg = colors.none },
					DiagnosticError = { bg = colors.none },
					DiagnosticVirtualTextHint = { bg = colors.none },
					DiagnosticVirtualTextInfo = { bg = colors.none },
					DiagnosticVirtualTextWarn = { bg = colors.none },
					DiagnosticVirtualTextError = { bg = colors.none },

					TelescopeBorder = { fg = colors.slate }
				}
			})

			vim.cmd.colorscheme("catppuccin")
		end
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup({
						check_ts = true
					})
				end
			},
			{
				"numToStr/Comment.nvim",
				config = function()
					require("Comment").setup({
						mappings = {
							basic = false,
							extra = false
						}
					})

					vim.keymap.set("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)")
					vim.keymap.set("v", "<leader>c", "<Plug>(comment_toggle_blockwise_visual)")
					vim.keymap.set("x", "<leader>c", "<Plug>(comment_toggle_linewise_visual)")
				end
			}
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {},
				highlight = {
					enable = true
				},
				indent = {
					enable = true
				}
			})
		end
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		},
		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local i = ls.insert_node
			local t = ls.text_node
			local f = require("luasnip.extras.fmt").fmt

			ls.add_snippets("rust", {
				s("ttest", f(
					[[
					#[tokio::test]
					async fn {1}_test() {{
						{2}
					}}
					]],
					{
						i(1, "fn"),
						i(2, "// test_me_daddy()")
					}
				)),

				s("print", f(
					[[
					println!("{1}");
					]],
					{
						i(1, "")
					}
				)),

				s("cli", f(
					[[
					use {{
						color_eyre::Result as Eyre,
						clap::Parser
					}};

					#[derive(Debug, Parser)]
					struct Args {{
						{1}
					}}

					#[tokio::main]
					async fn main() -> Eyre<()> {{
						color_eyre::install()?;
						let args = Args::parse();

						{2}

						Ok(())
					}}
					]],
					{
						i(1, "// "),
						i(2, "")
					}
				)),
			})

			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<cr>"] = cmp.mapping.confirm({ select = true }),
					["<c-space>"] = cmp.mapping.complete(),
					["<c-j>"] = cmp.mapping.scroll_docs(4),
					["<c-k>"] = cmp.mapping.scroll_docs(-4),
					["<tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end),
					["<s-tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end),
					["<c-n>"] = function()
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						end
					end,
					["<c-p>"] = function()
						if ls.jumpable(-1) then
							ls.jump(-1)
						end
					end
				}),
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer", max_item_count = 1, keyword_length = 5 },
				},
				formatting = {
					expandable_indicator = false,
					format = function(_, item)
						item.menu = ""
						item.kind = ({
							Text = "", Method = "", Function = "", Constructor = "",
							Field = "", Variable = "", Class = "", Interface = "",
							Module = "", Property = "", Unit = "", Value = "", Enum = "",
							Keyword = "", Snippet = "", Color = "", File = "", Reference = "",
							Folder = "", EnumMember = "", Constant = "", Struct = "",
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
						ls.lsp_expand(args.body)
					end
				}
			})
		end
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{
				"ThePrimeagen/harpoon",
				config = function()
					require("telescope").load_extension("harpoon")
					local ui = require("harpoon.ui")
					local mark = require("harpoon.mark")

					vim.keymap.set("n", "<leader>a", mark.add_file)
					vim.keymap.set("n", "<leader>j", ui.toggle_quick_menu)
					vim.keymap.set("n", "<F1>", function()
						ui.nav_file(1)
					end)
					vim.keymap.set("n", "<F2>", function()
						ui.nav_file(2)
					end)
					vim.keymap.set("n", "<F3>", function()
						ui.nav_file(3)
					end)
					vim.keymap.set("n", "<F4>", function()
						ui.nav_file(4)
					end)
				end
			}
		},
		config = function()
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			local ivy = require("telescope.themes").get_ivy

			require("telescope").setup({
				defaults = {
					mappings = {
						["i"] = {
							["<esc>"] = actions.close,
							["<c-j>"] = actions.move_selection_next,
							["<c-k>"] = actions.move_selection_previous,
						}
					}
				}
			})

			vim.keymap.set("n", "<c-f>", builtin.current_buffer_fuzzy_find)

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files(ivy({
					hidden = true,
					follow = true,
					layout_config = {
						height = 0.4
					}
				}))
			end)

			vim.keymap.set("n", "<leader>fl", function()
				builtin.live_grep(ivy({
					hidden = true,
					follow = true,
					layout_config = {
						height = 0.4
					},
					glob_patterns = {
						"!node_modules/*",
						"!target/*"
					}
				}))
			end)

			vim.keymap.set("n", "<c-/>", function()
				builtin.grep_string({
					layout_strategy = "cursor",
					layout_config = {
						height = 0.5,
						width = 0.75
					}
				})
			end)

			vim.keymap.set("n", "<leader>fd", function()
				builtin.diagnostics(ivy({
					layout_config = {
						height = 0.4
					}
				}))
			end)

			vim.keymap.set("n", "<leader>fs", function()
				builtin.lsp_workspace_symbols(ivy({
					layout_config = {
						height = 0.4
					}
				}))
			end)

			vim.keymap.set("n", "<leader>fr", function()
				builtin.lsp_references(ivy({
					layout_config = {
						height = 0.4
					}
				}))
			end)
		end
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"williamboman/mason.nvim",
				config = function()
					require("mason").setup()
				end
			},
		},
		config = function()
			local lsp = require("lspconfig")

			local function format_on_save(bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.g.AlphaKeks,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end
				})
			end

			local function highlight_word(bufnr)
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					group = vim.g.AlphaKeks,
					buffer = bufnr,
					callback = function()
						local utils = require("nvim-treesitter.ts_utils")
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
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
				vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
				vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
				vim.keymap.set("n", "gL", vim.diagnostic.goto_next, { buffer = bufnr })
				vim.keymap.set("n", "gr", function()
					vim.ui.input({ prompt = "New Name: " }, function(input)
						if input then
							vim.lsp.buf.rename(input)
						end
					end)
				end, { buffer = bufnr })
				vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, { buffer = bufnr })
				vim.keymap.set("n", "gp", function()
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
					local bufnr = vim.api.nvim_get_current_buf()
					local win_id = vim.fn.win_getid()
					vim.keymap.set("n", "q", function()
						vim.api.nvim_win_close(win_id, true)
						vim.keymap.del("n", "q")
					end)
				end, { buffer = bufnr })
			end

			local capabilities = nil
			local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
			if cmp_installed then
				capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = cmp.default_capabilities(capabilities)
			end

			lsp["rust_analyzer"].setup({
				standalone = true,
				on_attach = function(_, bufnr)
					apply_keymaps(bufnr)
					format_on_save(bufnr)
					highlight_word(bufnr)
				end,
				capabilities = capabilities,
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all"
						},
						checkOnSave = {
							enable = true,
							command = "clippy",
							features = "all"
						}
					}
				}
			})

			lsp["tsserver"].setup({
				on_attach = function(client, bufnr)
					apply_keymaps(bufnr)
					highlight_word(bufnr)
					client.server_capabilities.document_formatting = false
					client.server_capabilities.document_range_formatting = false
				end,
				capabilities = capabilities
			})

			local servers = {
				"bashls",
				"cssls",
				"emmet_ls",
				"html",
				"jsonls",
				"taplo"
			}

			for _, server in ipairs(servers) do
				lsp[server].setup({
					on_attach = function(client, bufnr)
						if client.server_capabilities.documentFormattingProvider then
							format_on_save(bufnr)
						end
						if client.server_capabilities.documentHighlightProvider
							and server ~= "bashls"
						then
							highlight_word(bufnr)
						end
						apply_keymaps(bufnr)
					end,
					capabilities = capabilities
				})
			end

			vim.diagnostic.config({
				virtual_text = {
					source = false,
					prefix = "",
					severity = vim.diagnostic.severity.ERROR
				},
				underline = false,
				severity_sort = true,
				float = {
					focusable = true,
					source = "always",
					header = "Diagnostics",
					prefix = " ",
					border = "single"
				}
			})
			
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
		end
	})

	use({
		"TimUntersberger/neogit",
		requires = {
			{
				"lewis6991/gitsigns.nvim",
				config = function()
					local gitsigns = require("gitsigns")
					gitsigns.setup()
					vim.keymap.set("n", "gb", gitsigns.blame_line)
					vim.keymap.set("n", "gB", function()
						gitsigns.blame_line({ full = true })
					end)
				end
			}
		},
		config = function()
			local neogit = require("neogit")

			neogit.setup({
				disable_context_highlighting = true,
				commit_popup = {
					kind = "vsplit"
				},
				popup = {
					kind = "split"
				}
			})

			vim.keymap.set("n", "<Leader>gs", neogit.open)
		end
	})

	use({
		"feline-nvim/feline.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons"
		},
		config = function()
			local feline_ok, feline = pcall(require, "feline")
			local palette_ok, palette = pcall(require, "catppuccin.palettes")
			local git_ok, git = pcall(require, "gitsigns")
			if (not feline_ok) or (not palette_ok) or (not git_ok) then return end

			palette = palette.get_palette()
			local bg_color = palette.mantle

			local feline_lsp = require("feline.providers.lsp")
			local severity = vim.diagnostic.severity

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
				["!"] = "SHELL"
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
									return string.format("<%s>", vim.o.filetype)
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
							}
						}
					}
				}
			})

			feline.winbar.setup()
		end
	})
end)
