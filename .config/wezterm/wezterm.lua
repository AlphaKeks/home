local term = require("wezterm")

return {
	default_prog = { "/usr/bin/zsh" }, -- don't run as login shell
	color_scheme = "Catppuccin Mocha",
	font = term.font("Fira Code Nerd Font"),
	font_size = 15.0,
	line_height = 1.5,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_background_opacity = 0.85,
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 0
	},
	keys = {
		{
			key = "f",
			mods = "CTRL|SHIFT",
			action = term.action.SendString("source ~/.local/bin/scripts/gtp.sh\r")
		},
		{
			key = "^",
			mods = "CTRL",
			action = term.action.SendKey({
				key = "^",
				mods = "CTRL"
			})
		}
	},
}
