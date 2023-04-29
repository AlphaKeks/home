local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local create_tags = require("core.tags").create_tags
local widgets = require("alphakeks.widgets")

awful.screen.connect_for_each_screen(function(screen)
  local tags = create_tags(screen)

  screen.taglist = awful.widget.taglist({
    screen = screen,
    filter = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
      awful.button({}, 1, function(tag)
        tag:view_only()
      end)
    ),
  })

  screen.wibar = awful.wibar({
    screen = screen,
    position = "top",
  })

  screen.wibar:setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      widgets.launcher,
      widgets.clock,
      screen.taglist,
    },

    widgets.separator,

    {
      layout = wibox.layout.fixed.horizontal,
      widgets.systray,
    },
  })
end)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
