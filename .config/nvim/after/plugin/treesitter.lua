local treesitter_installed, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_installed then return end

treesitter.setup({
	ensure_installed = {},
	highlight = {
		enable = true
	},
	indent = {
		enable = true
	}
})

local autopairs_installed, autopairs = pcall(require, "nvim-autopairs")
if autopairs_installed then
	autopairs.setup({
		check_ts = true,
		disable_filetypes = {
			"TelescopePrompt"
		}
	})
end

local autotag_installed, autotag = pcall(require, "nvim-ts-autotag")
if autotag_installed then
	autotag.setup()
end


local comment_installed, comment = pcall(require, "Comment")
if comment_installed then
	comment.setup({
		mappings = {
			basic = false,
			extra = false
		}
	})

	vim.keymap.set("n", "<Leader>c", "<Plug>(comment_toggle_linewise_current)")
	vim.keymap.set("v", "<Leader>c", "<Plug>(comment_toggle_blockwise_visual)")
	vim.keymap.set("x", "<Leader>c", "<Plug>(comment_toggle_linewise_visual)")
end
