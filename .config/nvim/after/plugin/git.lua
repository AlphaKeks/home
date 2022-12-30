local gitsigns_installed, gitsigns = pcall(require, "gitsigns")
if gitsigns_installed then
	gitsigns.setup()
end

local neogit_installed, neogit = pcall(require, "neogit")
if not neogit_installed then return end

neogit.setup({
	disable_context_highlighting = true,
	commit_popup = {
		kind = "vsplit"
	},
	popup = {
		kind = "split"
	},
})

vim.keymap.set("n", "<Leader>gs", neogit.open)
vim.keymap.set("n", "<Leader>gc", function()
	neogit.open({ "commit" })
end)
vim.keymap.set("n", "<Leader>gl", function()
	neogit.open({ "log" })
end)
