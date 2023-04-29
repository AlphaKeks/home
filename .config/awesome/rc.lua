-- awesome_mode: api-level=4:screen=on
pcall(require, "luarocks.loader")
require("awful.autofocus")

-- Report potential errors
require("core.error_report")

-- Setup monitors
require("core.xrandr")

-- Initialize my own global namespace
require("alphakeks")

-- Load keymaps
require("alphakeks.keymaps")

-- layouts (tiling (in a tiling window manager))
require("core.layouts")

-- anime waifus
require("core.wallpapers")

-- theme (catppuccin (the best))
local beautiful = require("beautiful")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/core/theme.lua")

-- bars
require("core.bars")

-- window rulez
require("core.rules")


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
-- noties
require("core.notifications")
