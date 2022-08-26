-- SYNTAX HIGHLIGHTING : treesitter
local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not treesitter_status) then
	print("treesitter failed to load")
	return
end

treesitter.setup {
	ensure_installed = "all",
	ignore_install = { "" },
	highlight = { enable = true },
	autopairs = {	enable = true },
	indent = { enable = true },
}
