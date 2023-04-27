local term = require("wezterm")

local function search_history()
	local test = os.execute("history | fzf")
	print(test)
end

return {
	default_prog = { "/usr/bin/zsh" },
	color_scheme = "Catppuccin Mocha",
	font = term.font_with_fallback {
		"Liga SFMono Nerd Font",
		"JetBrains Mono",
		"Fira Code Nerd Font",
	},
	font_size = 18,
	line_height = 1,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	window_background_opacity = 0.80,
	-- window_background_opacity = 1,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 727,
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	animation_fps = 240,
	scrollback_lines = 1000000,
	audible_bell = "Disabled",
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
			action = term.action.SendString("source ~/.local/bin/scripts/gtp.sh\r"),
		},
		{
			key = "^",
			mods = "CTRL",
			action = term.action.SendKey({
				key = "^",
				mods = "CTRL",
			}),
		},
		{
			key = "Backspace",
			mods = "CTRL",
			action = term.action.SendKey({
				key = "w",
				mods = "CTRL",
			}),
		},
	},
}
