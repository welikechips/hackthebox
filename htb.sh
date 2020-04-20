#!/usr/bin/env bash
# Description: Creates folders and setups tmux
### Research launching from inside another tmux
scriptdir="/root/tools/hackthebox"
basedir="/root/ctf/htb/"
mkdir -p $basedir
read -r -p "What box are you working on?" test_name
read -r -p "What is the IP address?" ip_address

mkdir -p $basedir/$test_name/
mkdir -p $basedir/$test_name/nmap
mkdir -p $basedir/$test_name/burp
mkdir -p $basedir/$test_name/dirb
cd $basedir/$test_name

#launchs new session with box name
tmux new-session -d -s $test_name
tmux new-window -d -t "$test_name" -n nmap
tmux send-keys -t "$test_name:nmap" "bash $scriptdir/nmap.sh $test_name $ip_address $scriptdir" Enter
tmux send-keys -t "$test_name" "openvpn /root/ctf/htb/client.ovpn" Enter
#Passess the variables to the nmap script to start scanning
tmux attach -t $test_name
