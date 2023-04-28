local awful = require("awful")

local screen_configs = {
  "xrandr --output DisplayPort-0 --mode 1920x1080 --rate 240.30 --primary --dpi 96",
  "xrandr --output DisplayPort-1 --mode 1920x1080 --rate 60.00 --dpi 96 --left-of DisplayPort-0",
  "xrandr --output DisplayPort-2 --mode 1920x1080 --rate 60.00 --dpi 96 --above DisplayPort-0",
  "xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60.00 --dpi 96 --right-of DisplayPort-0",
}

for _, config in ipairs(screen_configs) do
  awful.spawn(config)
end

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
