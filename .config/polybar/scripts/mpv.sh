#!/bin/bash

if pidof mpv > /dev/null
    then
	    METADATA=$(echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | cut -b 10-30)
			printf "$METADATA"
    else
	    exit
fi
