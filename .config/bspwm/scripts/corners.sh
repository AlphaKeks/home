#!/bin/sh

bspc subscribe node_state | while read -r _ _ _ node state status; do
    if [[ "$state" == "floating" ]]; then
        case "$status" in
            off) xprop -id "$node" -remove _PICOM_CORNERS;;
            on) xprop -id "$node" -f _PICOM_CORNERS 32c -set _PICOM_CORNERS 1;;
        esac
    fi
done
