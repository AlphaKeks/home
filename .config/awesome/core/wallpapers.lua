local awful = require("awful")
local wibox = require("wibox")

local wallpapers = {
  "/home/alphakeks/Pictures/Dawn/Wallpapers/catppuccinxdawn2.png",
  "/home/alphakeks/Pictures/Wallpapers/Catppuccin/hashtags-black.png",
  "/home/alphakeks/Pictures/Dawn/Wallpapers/lofi_dawn_tshirt_schnose.png",
  "/home/alphakeks/Pictures/Wallpapers/Catppuccin/hashtags-black.png",
}

for screen, wallpaper in ipairs(wallpapers) do
  awful.wallpaper({
    screen = screen,
    widget = {
      widget = wibox.container.tile,
      {
        widget = wibox.widget.imagebox,
        image = wallpaper,
      },
    },
  })
end

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
