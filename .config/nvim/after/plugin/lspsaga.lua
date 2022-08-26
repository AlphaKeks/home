-- LSP UI : lspsaga
local lspsaga_status, lspsaga = pcall(require, "lspsaga")
if (not lspsaga_status) then
	print("lspsaga failed to load")
	return
end

lspsaga.init_lsp_saga {
	border_style = "rounded",
	diagnostic_header = { " ", " ", " ", "ﴞ " },
	show_diagnostic_source = true,
	finder_icons = {
		def = " ",
		ref = "諭",
		link = " ",
	},
	finder_action_keys = {
		open = "<CR>",
		vsplit = "v",
		split = "s",
		tabe = "t",
		quit = "<ESC>",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>"
	},
	definition_preview_icon = " ",
	show_outline = {
		win_position = "right",
		win_with = "",
		win_width = 30,
		auto_enter = true,
		auto_preview = true,
		virt_text = "┃",
		jump_key = "<CR>",
		auto_refresh = true
	},
	custom_kind = { Field = "#7480c2" },
	server_filetype_map = {}
}
