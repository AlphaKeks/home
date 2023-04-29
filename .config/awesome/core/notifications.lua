local ruled = require("ruled")
local awful = require("awful")
local naughty = require("naughty")

ruled.notification.connect_signal("request::rules", function()
  ruled.notification.append_rule({
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  })
end)

naughty.connect_signal("request::display", function(notification)
  naughty.layout.box({ notification = notification })
end)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
