-- FUZZY FINDING : telescope
local telescope_status, telescope = pcall(require, "telescope")
if (not telescope_status) then
	print("telescope failed to load")
	return
end

telescope.setup {}
