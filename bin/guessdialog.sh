#!/bin/bash

PLAY=0
while [[ $PLAY -eq 0 ]]; do
    dialog --infobox "Myslim si cislo od 1 do 20" 7 30
    sleep 3
    SECRET=6
    TIP=0
    ATTEMPTS=5
    while [[ $TIP -ne $SECRET ]] && [[ $ATTEMPTS -gt 0 ]]; do
        dialog --title "Zadaj tip" --inputbox "Zostavajuci pocet pokusov: $ATTEMPTS" 8 35 2> /tmp/guess
        TIP=$(cat /tmp/guess)
        while [[ ! -n $TIP ]] || [[ ! $TIP =~ ^[0-9]+$ ]] || [[ ! $TIP -ge 1 ]] || [[ ! $TIP -le 20 ]]; do
            dialog --title "Zly vstup" --inputbox "Nespravny vstup. Zadaj cislo" 8 35 2> /tmp/guess
            TIP=$(cat /tmp/guess)
        done
        if [[ $TIP -lt $SECRET ]]; then
            dialog --msgbox "Moje cislo je vacsie ako $TIP" 7 30
        else
            if [[ $TIP -gt $SECRET ]]; then
                dialog --msgbox "Moje cislo je mensie ako $TIP" 7 30
            else
                dialog --msgbox "Ta ty genius." 7 30
            fi
        fi
        ATTEMPTS=$((ATTEMPTS-1))
    done
    if [[ $TIP -ne $SECRET ]]; then
        dialog --msgbox "Uz ti dosli pokusy. Mas smolu. Life sucks." 7 30
    fi
    # dalsia hra?
    dialog --title "Otazka" --yesno "Chces si zahrat znova?" 8 35 2> /tmp/guess
    PLAY=$?
done
# credits
dialog --infobox "Dovidenia. Podpor ma malou sumou na cisle 158." 7 30


