#!/bin/bash

TIME=$(date +%k)
#echo "$TIME"
#read -p "daj cislo" TIME 

if [[ $TIME -lt 2 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday1.png"
    else
if [[ $TIME -lt 4 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday2.png"

else

if [[ $TIME -lt 6 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday3.png"
else

if [[ $TIME -lt 8 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday4.png"
else

if [[ $TIME -lt 10 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday5.png"
else

if [[ $TIME -lt 12 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday6.png"
else

if [[ $TIME -lt 14 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday7.png"
else

if [[ $TIME -lt 16 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday8.png"
else

if [[ $TIME -lt 18 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday9.png"
else

if [[ $TIME -lt 20 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday10.png"
else

if [[ $TIME -lt 22 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday11.png"
else

if [[ $TIME -gt 22 ]]; then
    gsettings set org.gnome.desktop.background \
   picture-uri "file:///home/apollo-10/Pictures/bitday/bitday12.png"

    else

        echo "bitday.sh: There are no bitday images in your local Pictures/folder." 1>&2
        exit 1
    
    fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi

