#!/bin/bash

ANSWER=y
while [[ $ANSWER =~ ^(y|YES|a|ANO|yes|ano)$ ]]; do
clear
echo "Myslim si cislo od 1 do 20"

SECRET=$(( ( RANDOM % 20 ) + 1 ))
TIP=0
POKUS=5

while [ $TIP -ne $SECRET ] && [ $POKUS -gt 0 ]; do

read -p "Zadaj tip: " TIP 

echo "Tvoj tip: $TIP"

while [[ -n $TIP ]] && [[ $TIP =~ ^[0-9]+$ ]] && [[ $TIP -ge 1 ]] && [[ $TIP -le 20 ]]; do  
    echo "zadaj cislo"
done


if [ $TIP -gt $SECRET ]; then
        echo "moje cislo je mensie ako $TIP"
    else
if [ $TIP -lt $SECRET ]; then
        echo "moje cislo je vacsie ako $TIP"
    else
        echo "genius"
        fi
    fi
POKUS=$((POKUS-1))
        echo "Zostavajuce pokusy $POKUS"

if [ $POKUS -eq 0 ]; then
        echo "game over"
    fi

done

read -p "Chces hrat opat? Ak ano stlac "y", ak nie stlac hocico: " ANSWER
done

        echo "Dakujem za hru"



