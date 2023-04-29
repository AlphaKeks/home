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

-- noties
require("core.notifications")

-- autostart
require("alphakeks.autostart")

-- fancy titlebars
local nice = require("plugins.nice")
nice({
  titlebar_color = AlphaKeks.colors.crust,
  titlebar_height = 24,
  button_size = 14,
  mb_resize = nice.MB_MIDDLE,
  mb_contextmenu = nice.MB_RIGHT,
  titlebar_items = {
    left = {},
    middle = "title",
    right = { "maximize", "close" },
  },
  maximize_color = AlphaKeks.colors.green,
  close_color = AlphaKeks.colors.red,
})

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
