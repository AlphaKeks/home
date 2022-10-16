local ok, term = pcall(require, "toggleterm")
if ok then
	term.setup {
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = { border = "curved" }
	}

	vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>", { silent = true })
end
