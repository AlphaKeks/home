require("autocmds")
require("options")
require("keymaps")

function Print(item)
	vim.pretty_print(item)
	return item
end

if vim.g.neovide then
	vim.api.nvim_create_autocmd("VimEnter", {
		group = vim.g.AlphaKeks,
		command = "cd ~/Projects"
	})

	vim.g.neovide_transparency = 0.85
	vim.g.neovide_refresh_rate = 240
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_cursor_trail_size = 0.8
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

vim.api.nvim_create_user_command("PackerSetup", function()
	require("plugins").PackerSetup()
	vim.api.nvim_del_user_command("PackerSetup")
end, {})
