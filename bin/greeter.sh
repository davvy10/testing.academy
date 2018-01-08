#!/bin/bash

HOUR=0

while [[ ! -n $HOUR ]] || [[ $HOUR =~ ^[0-9]+$ ]] || [[ ! $HOUR -ge 0 ]] || [[ ! $HOUR -le 23 ]]; do
  
  read -p  "Ahoj, zadaj cislo len cislo v rozsahu 00-23: " HOUR

  if [[ $HOUR -gt 0 ]] && [[ $HOUR -lt 8 ]]; then
    echo "dobre rano"

    else

  if [[ $HOUR -gt 8 ]] && [[ $HOUR -lt 18 ]]; then
    echo "dobry den" 
    else
    echo "dobry vecer"
    fi
    fi
done
