#!/bin/bash
outdir=${basedir}${test_name}
declare -a common_ports
common_ports=(80 139 443 445)
inputfile=$basedir/$test_name/nmap/${test_name}_full
for i in "${common_ports[@]}"
do
	isopen=`(cat $inputfile | grep $i)`
	if [[ $isopen == 80/tcp ]] ;then
		tmux new-window -d -n dirb
		tmux send-keys -t dirb "bash ${scriptdir}dirb_http.sh ${ip_address} ${outdir}" Enter
	elif [[ $isopen == 139/tcp  ||  $isopen == 445/tcp ]]; then
		tmux new-window -d -n smb
		tmux send-keys -t smb "smblclient -L ${ip_address} -N" Enter
	elif [[ $isopen == 443/tcp  ||  $isopen == 443/tcp ]]; then
		tmux new-window -d -n dirbs
		tmux send-keys -t dirbs "bash ${scriptdir}dirb_https.sh ${ip_address} ${outdir}" Enter
	else 
		continue	
	fi
done

