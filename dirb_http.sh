#!/bin/bash
#fix - $command comment
clear
outdir=$2
if [ -z "$1" ]
then
	read -r -p "What is the url?" url
	command="dirsearch -u $url -w /usr/share/wordlists/dirb/big.txt -f -t 100 -r -e php,html,js,txt -x 403"
	echo $command
	echo $command | xclip -sel clip
else
	command="dirsearch -u http://${1} -w /usr/share/wordlists/dirb/big.txt -f -t 20 -r -e php,html,js,txt -x 403"
	$command
fi
