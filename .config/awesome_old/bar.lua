local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local function set_wallpaper(screen)
	if not beautiful.wallpaper then
		return
	end

	local wallpaper = beautiful.wallpaper

	if type(wallpaper) == "function" then
		wallpaper = wallpaper(screen)
	end

	gears.wallpaper.maximized(wallpaper, screen, true)
end

local clock = wibox.widget({
	widget = wibox.widget.textclock,
	refresh = 1,
	format = " %a %d/%m/%Y %H:%M:%S ",
})

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local systray = wibox.widget.systray()
systray:set_base_size(16)

-- Wallpapers
local wallpapers = {
	"/home/alphakeks/Pictures/Dawn/Wallpapers/catppuccinxdawn2.png",
	"/home/alphakeks/Pictures/Wallpapers/Catppuccin/hashtags-black.png",
	"/home/alphakeks/Pictures/Dawn/Wallpapers/lofi_dawn_tshirt_schnose.png",
	"/home/alphakeks/Pictures/Wallpapers/Catppuccin/hashtags-black.png",
}

for screen, wallpaper in ipairs(wallpapers) do
	awful.wallpaper({
		screen = screen,
		widget = {
			widget = wibox.container.tile,
			tiled = false,
			halign = "center",
			valign = "center",
			{
				widget = wibox.widget.imagebox,
				downscale = true,
				upscale = true,
				image = wallpaper,
			},
		},
	})
end

awful.screen.connect_for_each_screen(function(screen)
	awful.tag(
		{ "1", "2", "3", "4", "5", "6", "7", "8", "9" },
		screen,
		awful.layout.layouts[1]
	)

	screen.taglist = awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,
		buttons = gears.table.join(
			awful.button({ }, 1, function(t)
				t:view_only()
			end)
		)
	})

	screen.wibox = awful.wibar({
		screen = screen,
		position = "bottom",
	})

	screen.wibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			clock,
			screen.taglist,
		},
		awful.widget.separator,
		{
			layout = wibox.layout.fixed.horizontal,
			ram_widget({
				color_used = Colors.poggers,
				color_free = Colors.surface0,
			}),
			cpu_widget({
				width = 69,
				step_spacing = 0,
				color = Colors.poggers,
			}),
			systray,
		},
	})
end)

-- vim: filetype=lua:noexpandtab:shiftwidth=4:tabstop=4:softtabstop=4:textwidth=69
