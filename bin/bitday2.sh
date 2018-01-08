#!/usr/bin/env bash

HOUR=$(date +%k)
PICTURENR=$(( ($HOUR / 2) + 1 ))
FILE="${HOME}/Pictures/bitday/bitday${PICTURENR}.png"

if [[ ! -f ${FILE} ]]; then
    echo "File ${FILE} doesn't exist." 1>&2
    exit 1
fi

gsettings set org.gnome.desktop.background picture-uri ${FILE}


#/home/david/Pictures/bitday
# "file:///home/apollo-10/Pictures/bitday/bitday1.png"

