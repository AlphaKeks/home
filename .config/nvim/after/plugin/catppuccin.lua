local catppuccin_installed, catppuccin = pcall(require, "catppuccin")
if not catppuccin_installed then return end

vim.g.catppuccin_flavour = "mocha"
local palette = require("catppuccin.palettes").get_palette()
local colors = {
	none = "NONE",
	slate = "#3E5164",
	ponggers = "#7480C2"
}

catppuccin.setup({
	transparent_background = not vim.g.neovide,
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
		},
		lsp_saga = true
	},
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
		Type = { fg = colors.ponggers, italic = true },
		Typedef = { fg = colors.ponggers, italic = true },
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
