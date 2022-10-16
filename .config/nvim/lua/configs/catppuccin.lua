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
		CursorLine = { bg = cp.surface0 },
		EndOfBuffer = { fg = "#7480C2" },
		Whitespace = { fg = cp.surface2 },

		-- syntax
		["@field"] = { fg = cp.blue },
		["@property"] = { fg = cp.blue },

		["@include"] = { fg = cp.subtext0 },
		Operator = { fg = cp.yellow },
		["@operator"] = { fg = cp.yellow },
		Keyword = { fg = cp.sky },
		["@keyword.operator"] = { fg = cp.sky },
		["@punctuation.special"] = { fg = cp.sky },

		Number = { fg = cp.yellow },
		["@number"] = { fg = cp.yellow },
		Float = { fg = cp.yellow },
		["@float"] = { fg = cp.yellow },
		Boolean = { fg = cp.yellow },
		["@boolean"] = { fg = cp.yellow },

		["@constructor"] = { fg = cp.sapphire },
		Constant = { fg = cp.sapphire },
		["@constant"] = { fg = cp.sapphire },
		["@constant.builtin"] = { fg = cp.sapphire },
		Conditional = { fg = cp.sky },
		["@conditional"] = { fg = cp.sky },
		Repeat = { fg = cp.sky },
		["@repeat"] = { fg = cp.sky },
		["@exception"] = { fg = cp.sky },

		["@namespace"] = { fg = cp.pink },
		Type = { fg = cp.sapphire },
		["@type"] = { fg = cp.sapphire },
		["@type.builtin"] = { fg = cp.sapphire },

		Function = { fg = cp.sky },
		["@function"] = { fg = cp.sky },
		["@function.macro"] = { fg = cp.sky },
		["@parameter"] = { fg = cp.lavender },
		["@keyword"] = { fg = cp.sky },
		["@keyword.function"] = { fg = cp.sky },
		["@keyword.return"] = { fg = cp.sky },
		["@method"] = { fg = cp.blue },

		Delimiter = { fg = cp.sapphire },
		["@punctuation.delimiter"] = { fg = cp.sapphire },
		["@punctuation.bracket"] = { fg = cp.sapphire },

		String = { fg = cp.lavender },
		["@string"] = { fg = cp.lavender },
		["@string.regex"] = { fg = cp.mauve },
		["@variable"] = { fg = cp.blue },
		["@variable.builtin"] = { fg = cp.sapphire },
		["@tag"] = { fg = cp.blue },
		["@tag.delimiter"] = { fg = cp.blue },

		["@text"] = { fg = cp.text },

		Character = { fg = cp.teal },
		Identifier = { fg = cp.sky },
		Statement = { fg = cp.sky },
		Structure = { fg = cp.sky },
		Error = { fg = cp.red },
		Todo = { fg = cp.mauve },
	}
}

vim.cmd "colorscheme catppuccin"

vim.api.nvim_create_user_command("ReloadColors", ":luafile ~/.config/nvim/lua/configs/catppuccin.lua", {})
