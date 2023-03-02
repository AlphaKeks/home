#!/usr/bin/env bash

# credits for the original version: https://github.com/Carbon-Bl4ck/Rofi-Beats

ARGS="--volume=25.0 --shuffle --no-video"

notify() {
	notify-send "Playing now: $@"
}

menu() {
	printf "1. Lofi\n"
	printf "2. Other Lofi\n"
	printf "3. osu!playlist\n"
	printf "4. ayayaJAM\n"
	printf "5. Nuke's BANGERS\n"
	printf "6. Prime's BANGERS\n"
}

main() {
	CHOICE=$(menu | rofi -dmenu -p "☕️" | cut -d. -f1)

	case $CHOICE in
		1)
			notify "Lofi Girl ☕️🎶";
			URL="https://www.youtube.com/watch?v=jfKfPfyJRdk"
			;;
		2)
			notify "Other Lofi ☕️🎶";
			URL="https://www.youtube.com/watch?v=u30517KYWhI"
			;;
		3)
			notify "osu!playlist 🎶";
			URL="https://www.youtube.com/playlist?list=PLt2s8p17wbVywg7bINV9nj7GPG5Oj0B4W"
			;;
		4)
			notify "Nightcore 🎶";
			URL="https://www.youtube.com/playlist?list=PLWegcLJnQNryAvLhavIJ64-6EGumD3gsD"
			;;
		5)
			notify "Nuke's BANGERS 🎶";
			URL="https://www.youtube.com/playlist?list=PL3TQ_Yh5IQkrBJFn53Hbnw4k6L_9BjGEy"
			;;
		6)
			notify "Prime's BANGERS 🎶";
			URL="https://www.youtube.com/playlist?list=PLm323Lc7iSW9oSIDihesMJXmMNfh8U59k"
			;;
	esac

	mpv $ARGS --title="radio-mpv" $URL
}

pkill -f radio-mpv && notify-send "Music stopped." || main

