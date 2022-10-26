local term = require("wezterm")

return {
	default_prog = { "/usr/bin/zsh" },
	color_scheme = "Catppuccin Mocha",
	font = term.font("JetBrains Mono"),
	font_size = 16.0,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_background_opacity = 1.0,
	window_padding = {
		left = 4,
		right = 4,
		top = 0,
		bottom = 0
	},
}
