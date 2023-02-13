local term = require("wezterm")

return {
	default_prog = { "/usr/bin/zsh" }, -- don't run as login shell
	color_scheme = "Catppuccin Mocha",
	font = term.font_with_fallback({
		"JetBrains Mono",
		"Fira Code Nerd Font"
	}),
	font_size = 10.5,
	line_height = 1,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_background_opacity = 1,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 0,
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	animation_fps = 240,
	scrollback_lines = 1000000,
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
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




































































































