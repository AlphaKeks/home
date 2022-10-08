local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end

vim.g.catppuccin_flavour = "mocha"

local cp = require("catppuccin.palettes").get_palette()

catppuccin.setup {
	transparent_background = true,
	term_colors = true,
	compile = { enabled = false },
	styles = {
		comments = { "italic" },
		properties = { "italic" },
		types = { "bold" }
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
				warnings = { "italic" }
			}
		}
	},
	custom_highlights = {
		Whitespace = { fg = cp.surface2 },
		WinSeparator = { bg = cp.none, fg = cp.none },
		CursorLine = { bg = cp.surface0 },
		EndOfBuffer = { fg = cp.mauve },

		NormalFloat = { bg = "NONE" },
		DiagnosticError = { bg = "NONE" },
		DiagnosticWarn = { bg = "NONE" },
		DiagnosticInfo = { bg = "NONE" },
		DiagnosticHint = { bg = "NONE" },
		DiagnosticVirtualTextError = { bg = "NONE" },
		DiagnosticVirtualTextWarn = { bg = "NONE" },
		DiagnosticVirtualTextInfo = { bg = "NONE" },
		DiagnosticVirtualTextHint = { bg = "NONE" },
	}
}

vim.cmd "colorscheme catppuccin"
