-- THEME : catppuccin
local theme_status, catppuccin = pcall(require, "catppuccin")
if (not theme_status) then
	print("theme failed to load")
	return
end

catppuccin.setup {
	transparent_background = true,
	term_colors = true,
	compile = {
		enabled = true,
		path = vim.fn.stdpath "cache" .. "/catppuccin"
	},
	styles = {
		comments = { "italic" },
		properties = { "italic" }
	},
	integration = {
		treesitter = { enabled = true },
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
		TSComment = { style = { "italic" } }
  }
}

vim.g.catppuccin_flavour = "mocha"
vim.cmd [[colorscheme catppuccin]]
