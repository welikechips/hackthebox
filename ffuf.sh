#!/bin/bash
#fix - $command comment
clear
url=$1
fuzz=$2
wordlist=$3
if [ -z "$1" ]
then
	read -r -p "What is the url?" url
  read -r -p "What is the fuzz?" fuzz
  read -r -p "What is the wordlist?" wordlist  
	command="ffuf -u \"${url}\" -H \"Host: ${fuzz}\" -w ${wordlist} -mc 200"
	echo $command
	echo $command | xclip -sel clip
else
	read -r -p "Do you want to run FFUF? [y/N] " r
	case "$r" in
	    [yY][eE][sS]|[yY])
		ffuf -u "${url}" -H "Host: ${fuzz}" -w "${wordlist}" -mc 200
		;;
	    *)
		;;
	esac
fi
