local awful = require("awful")

local autostart = {
  ["polkit-kde-authentication-agent-1"] = "/usr/lib/polkit-kde-authentication-agent-1",
  ["picom"] = "/usr/bin/picom -b --config /home/alphakeks/.config/picom/picom.conf",
  -- ["picom"] = "/usr/bin/picom -b --animations --animation-window-mass 0.069 --animation-for-open-window zoom --animation-stiffness 250 --animation-dampening 20 --experimental-backends --config ~/.config/picom/picom.conf",
  ["spectacle"] = "/usr/bin/spectacle -s",
  ["easyeffects"] = "/usr/bin/easyeffects --gapplication-service",
  ["signal-desktop"] = "/usr/bin/signal-desktop",
  ["discord"] = "/usr/bin/flatpak run com.discordapp.Discord",
  ["steam"] = "/usr/bin/steam -silent",
  ["nextcloud"] = "/usr/bin/nextcloud",
}

for command_name, command in pairs(autostart) do
  awful.spawn.with_shell(string.format(
    "pgrep -u $USER '%s' > /dev/null || (%s)",
    command_name, command
  ))
end

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
