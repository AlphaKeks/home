local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local widgets = {}

widgets.menu = awful.menu({
  items = {
    { "Restart", awesome.restart },
    {
      "👋",
      function()
        awesome.quit()
      end
    },
    {
      "Shutdown",
      function()
        os.execute("shutdown now")
      end,
    },
  },
})

widgets.launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = widgets.menu,
})

widgets.clock = wibox.widget({
  widget = wibox.widget.textclock,
  format = "  %H:%M %a %d/%m/%Y  ",
  refresh = 1,
})

widgets.separator = wibox.widget.separator()

widgets.systray = wibox.widget.systray()
widgets.systray:set_base_size(16)

return widgets

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
