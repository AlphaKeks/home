-- BUFFER NAVIGATION : bufferline
local bufferline_status, bufferline = pcall(require, "bufferline")
if (not bufferline_status) then
	print("bufferline failed to load")
	return
end

bufferline.setup {
	options = {
		close_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		separator_style = "thin"
	}
}
