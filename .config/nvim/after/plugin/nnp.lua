local nnp_installed, nnp = pcall(require, "no-neck-pain")
if not nnp_installed then return end

nnp.setup({
	debug = false,
	enableOnVimEnter = false,
	width = 108,
	disableOnLastBuffer = false,
	killAllBuffersOnDisable = false,
	buffers = {
		setNames = false,
		backgroundColor = "catppuccin-mocha",
		blend = 0,
		textColor = "#7480c2",
		bo = {
			filetype = "nnp",
			buftype = "nofile",
			bufhidden = "hide",
			buflisted = false,
			swapfile = false,
			modifiable = true
		},
		wo = {
			cursorline = false,
			cursorcolumn = false,
			number = false,
			relativenumber = false,
			foldenable = false,
			list = false,
			wrap = true,
			linebreak = true
		}
	}
})
