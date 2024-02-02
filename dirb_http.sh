#!/bin/bash
#fix - $command comment
clear
outdir=$2
if [ -z "$1" ]
then
	read -r -p "What is the url?" url
	command="gobuster dir -u $url -w /usr/share/wordlists/dirb/big.txt -t 100 -r -x php,html,js,txt -k "
	echo $command
	echo $command | xclip -sel clip
else
	command="gobuster dir -u http://${1} -w /usr/share/wordlists/dirb/big.txt -t 20 -r -x php,html,js,txt -k "
	$command
fi
