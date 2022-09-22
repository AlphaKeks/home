local feline_ok, feline = pcall(require, "feline")
local cp_ok, cp = pcall(require, "catppuccin.palettes")
if not (feline_ok and cp_ok) then return end

cp = cp.get_palette()
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
	}
}

local mode_colors = {
	["n"] = { "normal", cp.lavender },
	["no"] = { "n-pending", cp.lavender },
	["i"] = { "insert", cp.lavender },
	["ic"] = { "insert", cp.lavender },
	["t"] = { "terminal", cp.lavender },
	["v"] = { "visual", cp.lavender },
	["V"] = { "v-line", cp.lavender },
	[""] = { "v-block", cp.lavender },
	["R"] = { "replace", cp.lavender },
	["Rv"] = { "v-replace", cp.lavender },
	["s"] = { "select", cp.lavender },
	["S"] = { "s-line", cp.lavender },
	[""] = { "s-block", cp.lavender },
	["c"] = { "command", cp.lavender },
	["cv"] = { "command", cp.lavender },
	["ce"] = { "command", cp.lavender },
	["r"] = { "prompt", cp.lavender },
	["rm"] = { "more", cp.lavender },
	["r?"] = { "confirm", cp.lavender },
	["!"] = { "shell", cp.lavender }
}

local custom = {
	active = {
		{},
		{},
		{}
	},
	inactive = {
		{},
		{},
		{}
	}
}

custom.active[1][1] = {
	provider = assets.bar,
	hl = {
		bg = cp.mantle,
		fg = mode_colors[vim.fn.mode()][2]
	}
}

custom.active[1][2] = {
	provider = assets.mode_icon,
	hl = {
		bg = cp.mantle,
		fg = mode_colors[vim.fn.mode()][2]
	}
}

custom.active[1][3] = {
	provider = function()
		return " " .. mode_colors[vim.fn.mode()][1] .. " "
	end,
	hl = {
		bg = cp.mantle,
		fg = mode_colors[vim.fn.mode()][2]
	}
}

custom.active[2][1] = {
	provider = function()
		local filename = vim.fn.expand("%:t")
		local ext = vim.fn.expand("%:e")
		local icon = require("nvim-web-devicons").get_icon(filename, ext)
		if icon == nil then
			icon = assets.file
		end
		return icon .. " " .. filename
	end,
	hl = {
		bg = cp.mantle,
		fg = cp.blue
	}
}

custom.active[3][1] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.HINT)
	end,
	hl = {
		fg = cp.text,
		bg = cp.mantle
	},
	icon = assets.lsp.hint
}

custom.active[3][2] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = {
		fg = cp.teal,
		bg = cp.mantle
	},
	icon = assets.lsp.info
}

custom.active[3][3] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.WARN)
	end,
	hl = {
		fg = cp.yellow,
		bg = cp.mantle
	},
	icon = assets.lsp.warning
}

custom.active[3][4] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
	end,
	hl = {
		fg = cp.red,
		bg = cp.mantle
	},
	icon = assets.lsp.error
}

custom.active[3][5] = {
	provider = function()
		if next(vim.lsp.buf_get_clients()) ~= nil then
			return assets.lsp.server
		else
			return ""
		end
	end,
	hl = {
		fg = cp.blue,
		bg = cp.mantle
	},
	left_separator = " "
}

custom.active[3][6] = {
	provider = "line_percentage",
	left_sep = assets.bar,
	right_sep = assets.bar,
	hl = {
		bg = cp.mantle,
		fg = cp.lavender
	}
}

custom.active[3][7] = {
	provider = assets.bar,
	hl = {
		bg = cp.lavender,
		fg = cp.lavender
	}
}

feline.setup {
	components = custom
}
