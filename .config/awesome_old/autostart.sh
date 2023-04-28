#!/bin/sh

/usr/lib/polkit-kde-authentication-agent-1 &

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run "picom" "-b" "--config" "$HOME/.config/picom/picom.conf" &
run "nitrogen" "--restore" &
run "spectacle" "-s" &
run "easyeffects" "--gapplication-service" &

run "signal-desktop" &
flatpak run com.discordapp.Discord &
run "steam" "-silent" &
run "nextcloud" &
