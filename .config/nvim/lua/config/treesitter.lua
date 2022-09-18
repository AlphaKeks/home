local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

treesitter.setup {
	ensure_installed = 'all',
	highlight = { enable = true },
	indent = { enable = true },
	autopairs = { enable = true }
}

local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if autopairs_ok then
	autopairs.setup { check_ts = true, disable_filetypes = { 'TelescopePrompt', 'vim' } }
end

local autotag_ok, autotag = pcall(require, 'nvim-ts-autotag')
if autotag_ok then autotag.setup {} end

local comment_ok, comment = pcall(require, 'Comment')
if comment_ok then
	comment.setup {}

	local h_ok, h = pcall(require, 'alphakeks.keymaps')
	if not h_ok then return end

	local api = require('Comment.api')

	h.map('n', '<leader>c', function()
		api.toggle.linewise()
	end, h.def)

	h.map('v', '<leader>c', function()
		api.toggle.blockwise()
	end, h.def)

	h.map('x', '<leader>c', function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'nx', false)
		api.toggle.blockwise(vim.fn.visualmode())
	end, h.def)
end

