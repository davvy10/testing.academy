#!/bin/bash

systemctl ifconfig enp12s0 147.232.22.134 netmask 255.255.255.224 up

route add default gw 147.232.22.129

echo "nameserver 8.8.8.8" > /etc/resolv.conf

#ping sme.sk
