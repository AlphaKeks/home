local term_status, term = pcall(require, "toggleterm")
if (not term_status) then
	print("toggleterm failed to load")
	return
end

term.setup {
	size = 69,
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
