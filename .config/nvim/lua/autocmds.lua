vim.g.AlphaKeks = vim.api.nvim_create_augroup("AlphaKeks", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.highlight.on_yank({ timeout = 69 })
	end
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = vim.g.AlphaKeks,
	callback = function()
		vim.schedule(function()
			vim.cmd.nohlsearch()
		end)
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.g.AlphaKeks,
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "a", "<Plug>NetrwOpenFile", { remap = true, buffer = true })
		vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
	end
})
