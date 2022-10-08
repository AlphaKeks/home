require "alphakeks.settings"
require "alphakeks.keymaps"

-- markdown
local mgroup = vim.api.nvim_create_augroup("MarkdownThings", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "22*.md" },
	callback = function()
		vim.cmd("silent !$HOME/.local/bin/build_note.sh %:p")
	end,
	group = mgroup
})
