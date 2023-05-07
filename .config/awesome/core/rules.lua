local ruled = require("ruled")
local awful = require("awful")

ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  ruled.client.append_rule({
    id = "titlebars",
    rule_any = {
      type = { "normal", "dialog" },
    },
    properties = {
      titlebars_enabled = true,
    },
  })

  ruled.client.append_rule({
    id = "discord",
    rule = {
      class = "discord",
    },
    properties = {
      screen = 2,
      tag = "1",
    },
  })

  ruled.client.append_rule({
    id = "signal",
    rule = {
      class = "Signal",
    },
    properties = {
      screen = 2,
      tag = "2",
    },
  })

  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      class = {
        "gnome-calculator",
      },

      role = {
        "pop-up",
      },
    },
    properties = {
      floating = true
    },
  })
end)

client.connect_signal("mouse::enter", function(c)
  c:activate({
    context = "mouse_enter",
    raise = false,
  })
end)

-- Who the fuck minimizes windows?
client.connect_signal("property::minimized", function(c)
  c.minimized = false
end)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
