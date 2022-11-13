local term = require("wezterm")

return {
	default_prog = { "/usr/bin/zsh" },
	color_scheme = "Catppuccin Mocha",
	font = term.font_with_fallback({
		"JetBrains Mono",
		"monospace",
	}),
	font_size = 14.0,
	line_height = 1.25,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_background_opacity = 1.0,
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0
	},
	keys = {
		{ key = "f", mods = "CTRL|SHIFT", action = term.action.SendString("source ~/.local/bin/gtp.sh\r") }
	}
}

