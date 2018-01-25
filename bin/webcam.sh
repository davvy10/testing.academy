#!/bin/bash

#wget -q -O ${HOME}/Pictures/zem/zem-x.jpg "http://www.opentopia.com/images/data/sunlight/world_sunlight_map_rectangular.jpg"

#PIC="${HOME}/Pictures/zem/zem-x.jpg"



DEST="/home/david/Pictures/zem/"
NR=$(ls ${DEST}/zem-*.jpg 2> /dev/null | wc -l)
NR=$((NR + 1))
wget -q -O "${DEST}zem-${NR}.jpg" "http://www.opentopia.com/images/data/sunlight/world_sunlight_map_rectangular.jpg"

gsettings set org.gnome.desktop.background picture-uri ${DEST}/zem-${NR}.jpg 

