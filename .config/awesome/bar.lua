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

local function get_window_list(screen)
	return awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		widget_template = {
			id = "background_role",
			widget = wibox.container.background,
			{
				widget = wibox.container.margin,
				left = 10,
				right = 10,
				{
					layout = wibox.layout.flex.horizontal,
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
				},
			},
		}
	})
end

local clock = wibox.widget({
	widget = wibox.widget.textclock,
	refresh = 1,
	format = "%H:%M:%S %a %d/%m/%Y",
})

local systray = wibox.widget.systray()
systray:set_base_size(16)
systray:set_horizontal(false)

awful.screen.connect_for_each_screen(function(screen)
	set_wallpaper(screen)

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
			screen.taglist,
		},
		get_window_list(screen),
		{
			layout = wibox.layout.fixed.horizontal,
			systray,
			clock,
		},
	})
end)

-- vim: filetype=lua:noexpandtab:shiftwidth=4:tabstop=4:softtabstop=4:textwidth=69
