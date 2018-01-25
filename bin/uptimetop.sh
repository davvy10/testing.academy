#!/bin/bash

uptime

RUN=$(ps au r --noheader | wc -l)
SLEEP=$(ps -eo s,pid | egrep 'S' | wc -l)
STOP=$(ps au | awk '{print $8}' | egrep -i 't' | wc -l)
ZOMBIE=$(ps -e j | egrep Z | head -1 | wc -l)
TASKS=$(echo "$RUN + $SLEEP + $STOP + $ZOMBIE" | bc ) 

echo TASKS: $TASKS total, $RUN running, $SLEEP sleeping, $STOP stopped, $ZOMBIE zombie

#CPU=$(ps aux | awk '{print $3}' | awk '{sum+=$1} END{print "sum=",sum}' | awk '{print $2}')
CPU=$(mpstat | awk '{print $4}' | tail -1)
SSY=$(mpstat | awk '{print $6}' | tail -1)
NICE=$(mpstat | awk '{print $5}' | tail -1)
WAIT=$(mpstat | awk '{print $7}' | tail -1)
HI=$(mpstat | awk '{print $8}' | tail -1)
SI=$(mpstat | awk '{print $9}' | tail -1)
ST=$(mpstat | awk '{print $10}' | tail -1)
FREE=$(free -k | sed -n '2p')
FREE2=$(free -k | tail -1)

echo "%CPU(s)": $CPU us, $SSY sy, $NICE ni, $WAIT wa, $HI hi, $SI si, $ST st
echo "KiB : "$FREE 
echo "KiB : "$FREE2

echo 
ps au | head -15 | awk '{print $1,$2,$3,$4,$10,$11}' | column -t
















#RESULT=$(echo "scale=2; 3 / 4" | bc /proc/uptime)

#UPTIME=$(cut -f1 -d' ' /proc/uptime )
#DAYS=$(echo $UPTIME/60/60/24 | bc)
#HOURS=$(echo "($UPTIME/60/60)%24" | bc)
#MINS=$(echo "($UPTIME/60)%60" | bc)
#SECS=$(echo "($UPTIME)%60" | bc)

