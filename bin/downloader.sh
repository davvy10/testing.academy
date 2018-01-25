#!/bin/env bash

while read -r LINK; do

DEST="/home/david/Pictures/komix/"
NR=$(ls ${DEST}*.jpg 2> /dev/null | wc -l)
NR=$((NR + 1))
PIC=$(printf "%02d" ${NR})

wget -q -O "${DEST}komix${PIC}.jpg" "$LINK"

done < $1
