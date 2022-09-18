local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then return end

vim.g.catppuccin_flavour = 'mocha'

local colors = require('catppuccin.palettes').get_palette()

catppuccin.setup {
	transparent_background = true,
	term_colors = true,
	styles = {
		comments = { 'italic' },
		conditionals = { 'italic' },
		functions = { 'italic' },
		types = { 'bold' },
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
