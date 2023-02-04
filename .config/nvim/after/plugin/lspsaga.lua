local saga_installed, saga = pcall(require, "lspsaga")
if not saga_installed then return end

saga.setup({
	ui = {
		theme = "round",
		-- single, double, rounded, solid, shadow
		border = "rounded",
		winblend = 0,
		expand = "",
		collapse = "",
		preview = "",
		code_action = "",
		diagnostic = "",
		incoming = "",
		outgoing = "",
		-- colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
		kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind()
	},
})
