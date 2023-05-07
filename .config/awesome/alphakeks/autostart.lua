local awful = require("awful")

awful.spawn.with_shell("/usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1")

local autostart = {
  ["picom"] = "/usr/bin/picom -b --experimental-backends --config /home/alphakeks/.config/picom/picom.conf",
  ["flameshot"] = "/usr/bin/flameshot & disown",
  ["signal-desktop"] = "/usr/bin/flatpak run org.signal.Signal",
  ["discord"] = "/usr/bin/flatpak run com.discordapp.Discord",
  ["steam"] = "/usr/bin/flatpak run com.valvesoftware.Steam -silent",
  -- ["nextcloud"] = "/usr/bin/flatpak run com.nextcloud.desktopclient.nextcloud",
  ["bitwarden"] = "/usr/bin/flatpak run com.bitwarden.desktop",
}

for command_name, command in pairs(autostart) do
  awful.spawn.with_shell(string.format(
    "pgrep -u $USER '%s' > /dev/null || (%s)",
    command_name, command
  ))
end

awful.spawn.with_shell("source /home/alphakeks/.zlogin")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
