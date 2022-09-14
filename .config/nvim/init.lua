-- https://github.com/AlphaKeks
-- this config file is intended for neovim 0.7.3

--[[
	neovim settings
	you can read about these options with :help <option>
]]
local settings = {
	-- meta settings
	backup = false,
	belloff = 'all',
	bufhidden = 'wipe',
	cdhome = true,
	clipboard = 'unnamedplus',
	confirm = true,
	errorbells = false,
	fileencoding = 'utf-8',
	icon = true,
	mousehide = true,
	swapfile = false,
	undodir = '/home/max/.config/nvim/undo',
	undofile = true,
	updatetime = 50,
	verbose = 0,
	visualbell = false,

	-- indentation
	autoindent = true,
	breakindent = true,
	copyindent = true,
	expandtab = false,
	preserveindent = true,
	smartindent = true,
	smarttab = true,
	shiftwidth = 2,
	tabstop = 2,

	-- visuals
	background = 'dark',
	cmdheight = 1,
	cursorcolumn = false,
	cursorline = true,
	guicursor = 'a:block,i:ver50,v:hor50,r:hor50',
	guifont = 'JetBrains Mono:h16',
	helpheight = 8,
	list = false,
	listchars = {
		tab = '» ',
		space = '·',
	},
	menuitems = 8,
	number = true,
	pumheight = 8,
	relativenumber = true,
	scrolloff = 8,
	showmode = false,
	sidescroll = 1,
	sidescrolloff = 8,
	signcolumn = 'yes',
	splitbelow = true,
	splitright = true,
	syntax = 'ON',
	termguicolors = true,
	wrap = true,
	wrapmargin = 8,

	-- search settings
	hlsearch = false,
	incsearch = true,
	ignorecase = true
}

for name, value in pairs(settings) do
	vim.opt[name] = value
end

-- show whitespaces when in visual mode
local wgroup = vim.api.nvim_create_augroup('whitespaces', { clear = true })

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = { '*:v', '*:V' },
	callback = function()
		vim.opt.list = true
	end,
	group = wgroup
})

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = { 'v:*', 'V:*' },
	callback = function()
		vim.opt.list = false
	end,
	group = wgroup
})
--[[ keymaps ]]--
local map = vim.keymap.set
local o = { noremap = true, silent = true }

map('', '<Space>', '<Nop>', o)
vim.g.mapleader = ' '

map('n', 'U', '<C-R>', o)
map('n', '<C-s>', '<cmd>w<CR>', o)
map('n', 'x', '"_x', o) -- delete without yanking
map('n', 'yw', 'yiw', o) -- yank a word from anywhere
map('n', 'dw', '"_diw', o) -- delete a word from anywhere without yanking
map('n', 'cw', '"_ciw', o) -- change a word from anywhere without yanking
map('n', 'cc', '"_cc', o) -- change line without yanking
map('v', 'c', '"_c', o) -- change selection without yanking
map('v', 'p', '"_dP', o) -- override selected word without yanking it
map('x', 'p', '"_dP', o)
map('n', 'ss', '<cmd>split<CR>', o)
map('n', 'sv', '<cmd>vsplit<CR>', o)
map('n', '<leader>r', '<cmd>%s/', { noremap = true })

-- line navigation / movement
map('n', 'j', 'gj', o)
map('n', 'k', 'gk', o)
map('n', 'J', 'V:m \'>+1<CR>gv=gv<ESC>', o)
map('n', 'K', 'V:m \'<-2<CR>gv=gv<ESC>', o)
map('v', 'J', ':m \'>+1<CR>gv=gv', o)
map('v', 'K', ':m \'<-2<CR>gv=gv', o)
map('x', 'J', ':m \'>+1<CR>gv=gv', o)
map('x', 'K', ':m \'<-2<CR>gv=gv', o)
map('n', '>', '>>', o)
map('n', '<', '<<', o)
map('x', '>', '>gv', o)
map('x', '<', '<gv', o)

-- buffer / window navigation
map('n', '<C-h>', '<C-w>h', o)
map('n', '<C-j>', '<C-w>j', o)
map('n', '<C-k>', '<C-w>k', o)
map('n', '<C-l>', '<C-w>l', o)
map('n', '<S-h>', '<cmd>bprevious<CR>', o)
map('n', '<S-l>', '<cmd>bnext<CR>', o)
map('n', '<C-w>', '<cmd>bdelete<CR>', o)
map('t', '<S-h>', '<cmd>bprevious<CR>', o)
map('t', '<S-l>', '<cmd>bnext<CR>', o)

-- telescope
map('n', '<leader>ff', function()
	require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
		prompt_title = 'Fuzzy Find',
		previewer = false,
		layout_config = {
			anchor = 'N',
			prompt_position = 'top'
		}
	})
end, o)
map('n', '<leader>fd', function()
	require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
		prompt_title = '~ dotfiles ~',
		cwd = '~/.dotfiles',
		hidden = true,
		layout_config = {
			height = 0.35
		}
	})
end, o)
map('n', '<leader>fc', function()
	require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
		prompt_title = 'config files',
		cwd = '~/.config',
		hidden = true,
		layout_config = {
			height = 0.35
		}
	})
end, o)
map('n', '<leader>fg', function()
	require('telescope.builtin').git_status {
		prompt_title = 'git',
		hidden = true,
		layout_config = {
			height = 0.90,
			width = 0.90
		}
	}
end, o)
map('n', '<leader><Tab>', function()
	require('telescope.builtin').buffers {
		prompt_title = 'buffers',
		initial_mode = 'normal',
		sort_lastused = true,
		sort_mru = true,
		layout_config = {
			height = 0.60,
			width = 0.60
		}
	}
end, o)
map('n', '<C-f>', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		prompt_title = 'Fuzzy Find',
		previewer = false,
		layout_config = {
			anchor = 'NE',
			prompt_position = 'top'
		}
	})
end, o)

-- harpoon
map('n', '<leader>j', function()
	require('harpoon.ui').toggle_quick_menu()
end, o)
map('n', '<leader>m', function()
	require('harpoon.mark').add_file()
end, o)
map('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, o)
map('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, o)
map('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, o)
map('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, o)

-- nvim-tree
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', o)

-- commenting
map('n', '<leader>c', function()
	require('Comment.api').toggle.linewise()
end, o)
map('v', '<leader>c', function()
	require('Comment.api').toggle.blockwise()
end, o)
map('x', '<leader>c', function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
	require('Comment.api').toggle.blockwise(vim.fn.visualmode())
end, o)

-- lsp
map('n', '<leader><leader>', '<cmd>lua vim.lsp.buf.hover()<CR>', o)
map('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', o)
map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', o)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', o)
map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', o)
map('n', 'gL', function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float()
end, o)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', o)
map('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', o)
map('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', o)
map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', o)
map('n', 'gR', function()
	require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy {
		prompt_title = 'References',
		layout_config = {
			height = 0.2
		}
	})
end, o)

-- terminal
map('n', '<C-t>', '<cmd>ToggleTerm<CR>', o)
map('t', '<C-t>', '<cmd>ToggleTerm<CR>', o)

--[[ plugins ]]--
local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		packer_path
	})

	print 'Installing packer...\nclose and reopen neovim after the installation has finished'

	vim.cmd [[packadd packer.nvim]]
end

local packer_ok, packer = pcall(require, 'packer')
if packer_ok then
	packer.startup(function(use)

		-- let packer manage itself
		use { 'wbthomason/packer.nvim' }

		-- utility plugins
		use { 'nvim-lua/plenary.nvim', commit = '4b66054e75356ac0b909bbfee9c682e703f535c2' }

		-- theme
		-- use { 'catppuccin/nvim', as = 'catppuccin' }
		use { 'AlphaKeks/catppuccin-nvim', as = 'catppuccin' }
		
		-- basic plugins
		use { 'nvim-treesitter/nvim-treesitter', commit = 'cd9dfc1e48e8ad27b75cf883ba036e83b7079b9a' }
		use { 'neovim/nvim-lspconfig', commit = '1fcd44ef5f5ada6b2d9b29001aa91e352f9b6c76' }
		use { 'hrsh7th/nvim-cmp', commit = '913eb8599816b0b71fe959693080917d8063b26a' }

		use { 'windwp/nvim-autopairs', commit = '5fe24419e7a7ec536d78d60be1515b018ab41b15' }
		use { 'windwp/nvim-ts-autotag', commit = 'fdefe46c6807441460f11f11a167a2baf8e4534b' }
		use { 'numToStr/Comment.nvim', commit = '30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6' }

		use { 'hrsh7th/cmp-nvim-lsp', commit = 'affe808a5c56b71630f17aa7c38e15c59fd648a8' }
		use { 'hrsh7th/cmp-nvim-lsp-signature-help', commit = '3dd40097196bdffe5f868d5dddcc0aa146ae41eb' }
		use { 'hrsh7th/cmp-path', commit = '447c87cdd6e6d6a1d2488b1d43108bfa217f56e1' }

		-- blazingly fast file navigation
		use { 'nvim-telescope/telescope.nvim', commit = '2584ff391b528d01bf5e8c04206d5902a79ebdde' }
		use { 'ThePrimeagen/harpoon', commit = 'f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971' }

		-- lsp extensions
		use { "jose-elias-alvarez/null-ls.nvim", commit = "753ad51790a966b42997ac935e26573fb6d5864a" }
		use { "williamboman/mason.nvim", commit = "6f30a4066c477617da95ecef8f88a697d2a7124c" }

		-- snippets
		use { 'L3MON4D3/LuaSnip', commit = '04f90900f2a57938921fd25169c7f282e7eefe85' }
		use { 'saadparwaiz1/cmp_luasnip', commit = 'a9de941bcbda508d0a45d28ae366bb3f08db2e36' }

		-- nicer UI
		use { 'feline-nvim/feline.nvim', commit = '331a79449d86668618a4e00fced153bce3ce2780' }
		use { 'kyazdani42/nvim-tree.lua', commit = 'c3ea264947671f44d836af5b7587e12c4b4611f9' }
		use { 'kyazdani42/nvim-web-devicons', commit = '2d02a56189e2bde11edd4712fea16f08a6656944' }
		use { 'akinsho/toggleterm.nvim', commit = '7abb25ec913b4edf4c0384346da0999726a3d7be' }

		if PACKER_BOOTSTRAP then
			require('packer').sync()
		end

	end)
end

--[[ theme ]]
local catppuccin_ok, catppuccin = pcall(require, 'catppuccin')
if catppuccin_ok then
	vim.g.catppuccin_flavour = 'mocha'
	local colors = require('catppuccin.palettes').get_palette()

	catppuccin.setup {
		transparent_background = false,
		term_colors = false,
		compile = { enabled = false	},
		styles = {
			comments = { 'italic' },
			conditionals = { 'italic' },
			loops = {},
			functions = { 'italic' },
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = { 'bold' },
			operators = {},
		},
		integration = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { 'italic' },
					hints = { 'italic' },
					warnings = { 'italic' },
					information = { 'italic' },
				}
			},
			telescope = true,
			nvimtree = {
				enabled = true,
				show_root = true,
				transparent_panel = true
			}
		},
		custom_highlights = {
			WinSeparator = { bg = colors.none }
		}
	}

	vim.cmd [[colorscheme catppuccin]]
end

--[[ treesitter
	• syntax highlighting
	• autopairs
	• indentation
	• commenting
]]
local ts_ok, ts = pcall(require, 'nvim-treesitter.configs')
if ts_ok then
	ts.setup {
		ensure_installed = 'all',
		ignore_install = { '' },
		highlight = { enable = true },
		autopairs = { enable = true },
		indent = { enable = true }
	}
end

--[[ nvim-lspconfig
	• code diagnostics
	• autocompletion
	• code actions
	• formatting
	• ...
]]
local lsp_ok, lsp = pcall(require, 'lspconfig')
if lsp_ok then
	format_on_save = function(client, bufnr)
		if client.supports_method('textDocument/formatting') then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd('BufWritePre', {
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
	local cmp_nvim_ok, cmp_nvim = pcall(require, 'cmp_nvim_lsp')
	if cmp_nvim_ok then capabilities = cmp_nvim.update_capabilities(capabilities) end

	vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', numhl = '' })
	vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', numhl = '' })
	vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', numhl = '' })
	vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', numhl = '' })

	vim.diagnostic.config {
		virtual_text = true,
		signs = { active = signs },
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = 'minimal',
			source = 'always',
			header = '',
			prefix = '',
			border = 'rounded'
		},
	}

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

	-- servers
	lsp['bashls'].setup {
		on_attach = function(client, bufnr)
			format_on_save(client, bufnr)
		end,
		capabilities = capabilities
	}

	lsp['cssls'].setup {
		on_attach = function(client, bufnrclient, bufnr)
			format_on_save(client, bufnrclient, bufnr)
		end,
		capabilities = capabilities
	}

	lsp['html'].setup {
		on_attach = function(client, bufnr)
			format_on_save(client, bufnr)
		end,
		capabilities = capabilities
	}

	lsp['jsonls'].setup {
		on_attach = function(client, bufnr)
			format_on_save(client, bufnr)
		end,
		capabilities = capabilities
	}

	lsp['rust_analyzer'].setup {
		on_attach = function(client, bufnr)
			-- rustfmt instead
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities,
		cmd = { 'rust-analyzer' }
	}

	lsp['tsserver'].setup {
		on_attach = function(client, bufnr)
			-- prettierd instead
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities
	}

	lsp['vuels'].setup {
		on_attach = function(client, bufnr)
			-- prettierd instead
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities
	}
end

--[[ nvim-cmp
	• completion engine
]]
local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then

	--[[ luasnip
		• snippet engine
	]]
	local luasnip_ok, luasnip = pcall(require, 'luasnip')
	if luasnip_ok then
		luasnip.config.set_config = {
			history = true,
			updateevents = 'TextChanged,TextChangedI'
		}

		local f = require('luasnip.extras.fmt').fmt
		local i = luasnip.insert_node
		local r = require('luasnip.extras').rep
		local snip = luasnip.snippet

		luasnip.add_snippets('typescript', {
			snip('imp', f('import {{ {} }} from \'{}\';', {
				i(1, 'obj'),
				i(2, 'package')
			}))
		})

		kind_icons = {
			Text = '',
			Method = '',
			Function = '',
			Constructor = '',
			Field = 'ﰠ',
			Variable = '',
			Class = 'ﴯ',
			Interface = '',
			Module = '',
			Property = 'ﰠ',
			Unit = '塞',
			Value = '',
			Enum = '',
			Keyword = '',
			Snippet = '',
			Color = '',
			File = '',
			Reference = '',
			Folder = '',
			EnumMember = '',
			Constant = '',
			Struct = 'פּ',
			Event = '',
			Operator = '',
			TypeParameter = ''
		}
	end

	cmp.setup {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end
		},
		mapping = cmp.mapping.preset.insert {
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' })
		},
		formatting = {
			format = function(_entry, vim_item)
				vim_item.kind = (kind_icons[vim_item.kind] or '')
				return vim_item
			end
		},
		sources = {
			{ name = 'luasnip' },
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'path' }
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		}
	}
end

--[[ nvim-autopairs && nvim-ts-autotag
	• automatically close (, [, {, ", ' and html tags
]]
local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if autopairs_ok then
	autopairs.setup { check_ts = true, disable_filetypes = { 'TelescopePrompt', 'vim' } }
end

local autotag_ok, autotag = pcall(require, 'nvim-ts-autotag')
if autotag_ok then autotag.setup {} end

--[[ Comment.nvim
	• comment stuff using treesitter
]]
local comment_ok, comment = pcall(require, 'Comment')
if comment_ok then comment.setup {} end

--[[ telescope
	• fuzzy finding
	• file navigation
]]
local telescope_ok, telescope = pcall(require, 'telescope')
if telescope_ok then
	local actions = require('telescope.actions')

	telescope.setup {
		defaults = {
			prompt_prefix = '  ',
			selection_caret = ' ',
			path_display = { 'smart' },
			mappings = {
				i = {
					['<Down>'] = actions.cycle_history_next,
					['<Up>'] = actions.cycle_history_prev,
					['<C-j>'] = actions.move_selection_next,
					['<C-k>'] = actions.move_selection_previous,
				}
			}
		},
	}

	telescope.load_extension('harpoon')
end

--[[ null-ls
	• custom language server
	• custom formatters
	• custom linters
	• custom debuggers
]]
local null_ok, null = pcall(require, 'null-ls')
if null_ok then
	local diagnostics = null.builtins.diagnostics
	local formatting = null.builtins.formatting
	local actions = null.builtins.code_actions

	null.setup {
		debug = false,
		sources = {
			actions.eslint_d.with {
				filetypes = { 'javascript', 'typescript', 'vue' }
			},
			formatting.prettierd.with {
				filetypes = { 'javascript', 'typescript', 'vue' },
				env = {
					PRETTIERD_DEFAULT_CONFIG = '/home/max/.config/prettier/prettier.config.js'
				}
			},
			formatting.rustfmt.with {
				extra_args = { '--edition=2021' }
			}
		},
		on_attach = function(client, bufnr)
			format_on_save(client, bufnr)
		end
	}
end

--[[ mason
	• installer for language servers, linters, formatters and debuggers
	• installs everything to $HOME/.local/share/nvim/mason/bin
]]
local mason_ok, mason = pcall(require, 'mason')
if mason_ok then mason.setup {} end

--[[ feline
	• statusline
]]
local feline_ok, feline = pcall(require, 'feline')
if feline_ok then
	local catppuccin_ok, catppuccin = pcall(require, 'catppuccin.groups.integrations.feline')
	if catppuccin_ok then
		feline.setup {
			components = catppuccin.get()
		}
	end
end

--[[ nvim-tree
	• file tree
]]
local tree_ok, tree = pcall(require, 'nvim-tree')
if tree_ok then
	local tree_cb = require('nvim-tree.config').nvim_tree_callback

	tree.setup {
		update_focused_file = {
			enable = true,
			update_cwd = true
		},
		renderer = {
			root_folder_modifier = ':t',
			icons = {
				glyphs = {
					default = '',
					symlink = '',
					folder = {
						arrow_open = '',
						arrow_closed = '',
						default = '',
						open = '',
						empty = '',
						empty_open = '',
						symlink = '',
						symlink_open = ''
					},
					git = {
						unstaged = '',
						staged = 'S',
						unmerged = '',
						renamed = '➜',
						untracked = 'U',
						deleted = '',
						ignored = '◌'
					}
				}
			}
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = '',
				info = '',
				warning = '',
				error = ''
			}
		},
		view = {
			width = 30,
			height = 30,
			side = 'left',
			mappings = {
				list = {
					{ key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
					{ key = 'h', cb = tree_cb('close_node') },
					{ key = 'v', cb = tree_cb('vsplit') }
				}
			}
		},
		filters = { dotfiles = false },
		git = { ignore = false }
	}
end

--[[ toggleterm
	• floating terminal
]]
local term_ok, term = pcall(require, 'toggleterm')
if term_ok then
	term.setup {
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = 'float',
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = { border = 'curved' }
	}
end
