local ok, feline = pcall(require, 'feline')
if not ok then return end

local catppuccin_ok, catppuccin = pcall(require, 'catppuccin.groups.integrations.feline')
if catppuccin_ok then
	feline.setup {
		components = catppuccin.get()
	}
end
