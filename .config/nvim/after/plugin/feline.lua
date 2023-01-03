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

git.setup()

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
						return string.format("<%s>", vim.opt.filetype._value)
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
				},
				filler,
				{
					provider = function()
						if next(vim.lsp.buf_get_clients()) ~= nil then
							return " "
						else
							return ""
						end
					end,
					hl = { fg = palette.blue, bg = bg_color }
				}
			}
		}
	}
})

feline.winbar.setup({
	disable = {
		filetypes = { "nnp" }
	}
})
