local W = require("wezterm")

return {
	default_prog = { "/usr/bin/zsh" },
	color_scheme = "Catppuccin Mocha",
	--[[ font = W.font_with_fallback({
		"Fira Code",
		"JetBrains Mono"
	}), ]]
	font = W.font("Fira Code"),
	font_size = 14.0,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_background_opacity = 0.85,
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0
	},
	window_close_confirmation = "NeverPrompt"
}
