local catppuccin_installed, catppuccin = pcall(require, "catppuccin")
if not catppuccin_installed then return end

vim.g.catppuccin_flavour = "mocha"
local palette = require("catppuccin.palettes").get_palette()

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
		TelescopeBorder = { fg = palette.lavender },
		["@storageclass"] = { fg = palette.sapphire },
		MatchParen = { fg = palette.sky }
	}
})

vim.cmd.colorscheme("catppuccin")
