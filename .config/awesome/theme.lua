local assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")

local colors = {
	rosewater = "#F5E0DC",
	flamingo = "#F2CDCD",
	pink = "#F5C2E7",
	mauve = "#CBA6F7",
	red = "#F38BA8",
	maroon = "#EBA0AC",
	peach = "#FAB387",
	yellow = "#F9E2AF",
	green = "#A6E3A1",
	teal = "#94E2D5",
	sky = "#89DCEB",
	sapphire = "#74C7EC",
	blue = "#89B4FA",
	lavender = "#B4BEFE",

	text = "#CDD6F4",
	subtext1 = "#BAC2DE",
	subtext0 = "#A6ADC8",
	overlay2 = "#9399B2",
	overlay1 = "#7F849C",
	overlay0 = "#6C7086",
	surface2 = "#585B70",
	surface1 = "#45475A",
	surface0 = "#313244",

	base = "#1E1E2E",
	mantle = "#181825",
	crust = "#11111B",

	poggers = "#7480C2",
}

return {
	font = "SFMono Nerd Font 12",
	bg_normal = colors.mantle,
	bg_focus = colors.base,
	bg_urgent = colors.red,
	bg_minimize = colors.surface1,
	bg_systray = colors.mantle,
	systray_icon_spacing = 12,
	fg_normal = colors.overlay2,
	fg_focus = colors.text,
	fg_urgent = colors.text,
	fg_minimze = colors.text,
	useless_gap = xresources.apply_dpi(0),
	border_with = xresources.apply_dpi(0),
	border_color_normal = colors.mantle,
	border_color_active = colors.base,
	border_color_marked = colors.poggers,
	taglist_fg_focus = colors.text,
	taglist_bg_focus = colors.surface0,
	taglist_squares_sel = assets.taglist_squares_sel(xresources.apply_dpi(0), colors.red),
	taglist_squares_unsel = assets.taglist_squares_unsel(xresources.apply_dpi(0), colors.red),
	tasklist_bg_normal = colors.mantle,
	tasklist_bg_focus = colors.mantle,
	menu_height = xresources.apply_dpi(15),
	menu_width = xresources.apply_dpi(100),
	titlebar_fg_normal = colors.lavender,
	titlebar_focus = colors.text,
}

-- vim: filetype=lua:noexpandtab:shiftwidth=4:tabstop=4:softtabstop=4:textwidth=69
