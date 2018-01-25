#!/bin/bash


#date | cut -d ' ' -f4 && cut -d ' ' -f1-3 /proc/loadavg 

#w | head -1   

DATE=$(date +%T)
LOADAVG=$(cut -d ' ' -f1-3 /proc/loadavg)
TIME=$(cut -d ' ' -f1 /proc/uptime)
RESULT=$(echo "scale=0; $TIME / 3600" | bc )
UPTIME=$(cut -f1 -d' ' /proc/uptime )
RESULT2=$(echo "($UPTIME/60)%60" | bc )

USER=$(who | wc -l)
echo $DATE "up" $RESULT:$RESULT2 $USER "user, "     "load average:" $LOADAVG

#RESULT=$(echo "scale=2; 3 / 4" | bc /proc/uptime)

#UPTIME=$(cut -f1 -d' ' /proc/uptime )
#DAYS=$(echo $UPTIME/60/60/24 | bc)
#HOURS=$(echo "($UPTIME/60/60)%24" | bc)
#MINS=$(echo "($UPTIME/60)%60" | bc)
#SECS=$(echo "($UPTIME)%60" | bc)

