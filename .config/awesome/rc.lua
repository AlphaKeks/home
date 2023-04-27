-- If LuaRocks is installed, make sure that packages installed
-- through it are found (e.g. lgi). If LuaRocks is not installed, do
-- nothing.
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

-- Setup monitors
require("screens")

-- Any errors on startup?
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Error occurred during startup.",
		text = awesome.startup_errors,
	})
end

-- Listen for errors
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end

		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Error occurred.",
			text = tostring(err),
		})

		in_error = false
	end)
end

-- Load theme
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

-- Global Variables
AlphaKeks = {
	terminal = "wezterm",
	browser = "firefox",
	launcher = "rofi -show drun",
	editor = os.getenv("EDITOR") or "vim",
	mod = "Mod4",
}

-- Load layouts
require("layouts")

-- Load statusbar
require("bar")

GlobalKeybindings = gears.table.join(
	awful.key({ AlphaKeks.mod, "Shift" }, "r", function()
		awesome.restart()
	end),

	awful.key({ AlphaKeks.mod }, "Return", function()
		awful.spawn(AlphaKeks.terminal)
	end),

	awful.key({ AlphaKeks.mod }, "space", function()
		awful.spawn(AlphaKeks.launcher)
	end),

	awful.key({ AlphaKeks.mod }, "b", function()
		awful.spawn(AlphaKeks.browser)
	end),

	awful.key({ AlphaKeks.mod }, "m", function()
		awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi-beats.sh")
	end),

	awful.key({ AlphaKeks.mod }, "h", function()
		awful.client.focus.bydirection("left")
	end),

	awful.key({ AlphaKeks.mod }, "j", function()
		awful.client.focus.bydirection("down")
	end),

	awful.key({ AlphaKeks.mod }, "k", function()
		awful.client.focus.bydirection("up")
	end),

	awful.key({ AlphaKeks.mod }, "l", function()
		awful.client.focus.bydirection("right")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "h", function()
		awful.client.swap.bydirection("left")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "j", function()
		awful.client.swap.bydirection("down")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "k", function()
		awful.client.swap.bydirection("up")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "l", function()
		awful.client.swap.bydirection("right")
	end)
)

for i = 1, 9 do
	GlobalKeybindings = gears.table.join(GlobalKeybindings,
		awful.key({ AlphaKeks.mod }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end),

		awful.key({ AlphaKeks.mod, "Shift" }, "#" .. i + 9, function()
			if not client.focus then
				return
			end

			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:move_to_tag(tag)
			end
		end)
	)
end

ClientKeybindings = gears.table.join(
	awful.key({ AlphaKeks.mod }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end),

	awful.key({ AlphaKeks.mod }, "q", function(c)
		c:kill()
	end)
)

ClientButtons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),

	awful.button({ AlphaKeks.mod }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),

	awful.button({ AlphaKeks.mod }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

root.keys(GlobalKeybindings)

awful.rules.rules = {
	{
		rule = {},

		properties = {
			border_width = beautiful.border_with,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = ClientKeybindings,
			buttons = ClientButtons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		},
	},

	{ -- Floating Clients
		rule_any = {
			instance = {

			},

			class = {
			},
		},

		properties = {
			floating = true,
		},
	},

	{
		rule_any = {
			type = { "normal", "dialog" },
		},

		properties = {
			titlebars_enabled = true,
		},
	},
}

client.connect_signal("request::titlebars", function(c)
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end)
	)

	awful.titlebar(c):setup({
		layout = wibox.layout.flex.vertical,
		{
			layout = wibox.layout.flex.horizontal,
			buttons = buttons,
			{
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
		},
	})
end)

client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_color_active
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_color_active
end)

-- vim: filetype=lua:noexpandtab:shiftwidth=4:tabstop=4:softtabstop=4:textwidth=69
