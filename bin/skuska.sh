#!/bin/bash
#dialog --yesno 'are you happy?' 5 20
#case $? in
 #  0) echo "YES, you are happy.";;
  # 1) echo "NO, where is problem?";;
#esac

left=10
unit="seconds"
while test $left != 0; do
dialog --sleep 1 \
       --title "Read Carefuly" \
       --infobox "This text is important.\n\n
You have $left $unit to read this..." 10 52
left=`expr $left - 1`
test $left = 1 && unit="second"
done
