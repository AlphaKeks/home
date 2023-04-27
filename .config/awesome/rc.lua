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

-- Autolaunch programs
awful.spawn.once({ "/usr/lib/polkit-kde-authentication-agent-1" })

awful.spawn.once({
	"/usr/bin/picom",
	"-b", "--config",
	"/home/alphakeks/.config/picom/picom.conf"
})

awful.spawn.once({ "/usr/bin/spectacle", "-s" })

awful.spawn.once({
	"/usr/bin/easyeffects",
	"--gapplication-service"
})

awful.spawn.once({ "/usr/bin/signal-desktop" })

awful.spawn.once({
	"/usr/bin/flatpak",
	"run",
	"com.discordapp.Discord"
})

awful.spawn.once({ "/usr/bin/steam", "-silent" })

awful.spawn.once({ "/usr/bin/nextcloud" })

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
		awful.client.focus.global_bydirection("left")
	end),

	awful.key({ AlphaKeks.mod }, "j", function()
		awful.client.focus.global_bydirection("down")
	end),

	awful.key({ AlphaKeks.mod }, "k", function()
		awful.client.focus.global_bydirection("up")
	end),

	awful.key({ AlphaKeks.mod }, "l", function()
		awful.client.focus.global_bydirection("right")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "h", function()
		awful.client.swap.global_bydirection("left")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "j", function()
		awful.client.swap.global_bydirection("down")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "k", function()
		awful.client.swap.global_bydirection("up")
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "l", function()
		awful.client.swap.global_bydirection("right")
	end)
)

for i = 1, 9 do
	GlobalKeybindings = gears.table.join(GlobalKeybindings,
		awful.key({ AlphaKeks.mod }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
				local timer = gears.timer.weak_start_new(0.001, function() end)
				timer:connect_signal("timeout", function(t)
					local c = mouse.object_under_pointer()
					if c then
						c:activate()
					end
					t:stop()
				end)
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
	awful.key({ AlphaKeks.mod }, "t", function(c)
		c.floating = false
		c:raise()
	end),

	awful.key({ AlphaKeks.mod }, "f", function(c)
		c.floating = true
		c:raise()
	end),

	awful.key({ AlphaKeks.mod, "Shift" }, "f", function(c)
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
	{ -- Default options
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

	{ -- Titlebars
		rule_any = {
			type = { "normal", "dialog" },
		},
		properties = {
			titlebars_enabled = true,
		},
	},

	{ -- Specific screen for discord
		rule = { class = "discord" },
		properties = {
			screen = 2,
			tag = "1",
		},
	},

	{ -- Specific screen for signal
		rule = { class = "Signal" },
		properties = {
			screen = 2,
			tag = "2",
		},
	},
}

local titlebars = require("nice-titlebars")
titlebars({
	titlebar_color = Colors.mantle,
	mb_resize = titlebars.MB_MIDDLE,
	mb_contextmenu = titlebars.MB_RIGHT,
	titlebar_items = {
		left = {},
		middle = "title",
		right = { "maximize", "close" },
	},
	maximize_color = Colors.lavender,
	close_color = Colors.red,
})

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
