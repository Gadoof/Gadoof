#!/bin/bash

myvar=(1 2 3)
for i in ${myvar[*]}
do
	echo $i
done


#echo "Please provide the network ID of your local subnet"
#read network_id
#echo "Scanning $network_id now..."
#nmap $network_id -sn


#echo "Here are your IP Addresses"
#ifconfig > network.txt
#cat network.txt | grep netmask | awk -F " " '{print $2}' | grep -v '127.0.0.1'
#rm network.txt
