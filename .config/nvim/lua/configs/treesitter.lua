local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then return end

ts.setup {
	ensure_installed = "all",
	ignore_install = {},
	highlight = { enable = true },
	indent = {
		enable = true,
		disable = { "python" }
	},
	autopairs = { enable = true }
}

local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if autopairs_ok then
	autopairs.setup { check_ts = true, disable_filetypes = { "TelescopePrompt", "vim" } }
end

local autotag_ok, autotag = pcall(require, "nvim-ts-autotag")
if autotag_ok then autotag.setup {} end

local comment_ok, comment = pcall(require, "Comment")
if comment_ok then
	comment.setup {
		mappings = {
			basic = false,
			extra = false
		}
	}

	vim.keymap.set("n", "<leader>c", function()
		return vim.v.count == 0
			and "<Plug>(comment_toggle_linewise_current)"
			or "<Plug>(comment_toggle_linewise_count)"
	end, { silent = true, expr = true })

	vim.keymap.set({ "v", "x" }, "<leader>c", "<Plug>(comment_toggle_linewise_visual)")
end
