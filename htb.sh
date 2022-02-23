#!/usr/bin/env bash
# Description: Creates folders and setups tmux
### Research launching from inside another tmux
scriptdir="/root/tools/hackthebox"
basedir="/root/ctf/htb"
read -r -p "What box are you working on? " test_name
read -r -p "What is the IP address? " ip_address

WD=$basedir/$test_name/
mkdir -p $WD
cd $WD
mkdir -p nmap
mkdir -p burp
mkdir -p dirb

export IP=${ip_address}
export WD=${WD}

server_name_found=$(grep -F "${ip_address}" /etc/hosts | awk '{ print $2 }')

if [ ! -z "$server_name_found" ]
then
    echo "${server_name_found} found in the /etc/hosts file with the ip address: ${ip_address}"
fi

read -r -p "Update hosts file? [y/N] " response

server_name=${test_name}.htb
case "$response" in
    [yY][eE][sS]|[yY])
        sudo echo -e "${IP}\t${server_name} ${test_name}" >> /etc/hosts
        echo "Current IP Address is ${IP}, server name is ${server_name} and current working directory is ${WD}"
        ;;
    *)
        echo "Current IP Address is ${IP} and current working directory is ${WD}"
	;;
esac

read -p "Press [Enter] key to start the process..."

#launchs new session with box name
tmux new-session -d -s $test_name
tmux new-window -d -t "$test_name" -n nmap
tmux send-keys -t "$test_name:nmap" "bash $scriptdir/nmap.sh $test_name $ip_address $scriptdir" Enter
tmux send-keys -t "$test_name" "openvpn /root/ctf/htb/client.ovpn" Enter
#Passess the variables to the nmap script to start scanning
tmux attach -t $test_name
tmux setenv IP ${ip_address}
tmux setenv WD ${WD}
