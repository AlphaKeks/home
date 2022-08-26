-- autopairs
local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
if (not autopairs_status) then
	print("nvim-autopairs failed to load")
	return
end

autopairs.setup { check_ts = true, disable_filetypes = { "TelescopePrompt", "vim" } }

-- autotag
local autotag_status, autotag = pcall(require, "nvim-ts-autotag")
if (not autotag_status) then
	print("nvim-ts-autotag failed to load")
	return
end

autotag.setup {}
