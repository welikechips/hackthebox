#!/bin/bash
### Take out the echo before going live.
basedir="/root/ctf/htb/"
#variables passed in during tmux creation
test_name=$1
ip_address=$2
scriptdir=$3
clear
read -r -p "Do you want to run NMAP? [y/N] " nmapresponse
case "$nmapresponse" in
    [yY][eE][sS]|[yY])
		#Starts nmaping all ports on box
        nmap -sC -sV $ip_address -oA ${basedir}${test_name}/nmap/${test_name}_full -p-
        ;;
    *)
        
         ;;
esac

# Launchs script and maintains all variables
. ${scriptdir}/suggester.sh
cat ${basedir}${test_name}/nmap/${test_name}_full.nmap | grep open > ${basedir}${test_name}/notes.txt
subl ${basedir}${test_name}