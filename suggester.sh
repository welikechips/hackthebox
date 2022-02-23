#!/bin/bash
outdir=${basedir}${test_name}
declare -a common_ports
common_ports=(80 139  389 443 445)
inputfile=${basedir}${test_name}/nmap/${test_name}_full.nmap
echo $inputfile
for i in "${common_ports[@]}"
do
	isopen=`(cat $inputfile | grep -w ${i}/tcp | cut -d " " -f1)`
	if [[ $isopen == 80/tcp ]] ;then
		tmux new-window -d -n dirb
		tmux send-keys -t dirb "bash ${scriptdir}/dirb_http.sh ${ip_address} ${outdir}" Enter
		tmux new-window -d -n ffuf80
		tmux send-keys -t ffuf80 "ffuf -u http://${test_name}.htb -H \"Host: FUZZ.${test_name}.htb\" -w /usr/share/wordlists/SecLists/Discovery/DNS/shubs-subdomains.txt -mc 200" Enter
	elif [[ $isopen == 139/tcp ]]; then
		tmux new-window -d -n smb
		tmux send-keys -t smb "smbclient -L ${ip_address} -N" Enter
	elif [[ $isopen == 389/tcp  ||  $isopen == 389/tcp ]]; then
		tmux new-window -d -n ldap
		tmux send-keys -t ldap "ldapsearch -x -h "${ip_address}" -s base namingcontexts" Enter
	elif [[ $isopen == 443/tcp  ||  $isopen == 443/tcp ]]; then
		tmux new-window -d -n dirbs
		tmux send-keys -t dirbs "bash ${scriptdir}/dirb_https.sh ${ip_address} ${outdir}" Enter
		tmux new-window -d -n ffuf443
		tmux send-keys -t ffuf443 "ffuf -u https://${test_name}.htb -H \"Host: FUZZ.${test_name}.htb\" -w /usr/share/wordlists/SecLists/Discovery/DNS/shubs-subdomains.txt -mc 200" Enter
	elif [[ $isopen == 445/tcp ]]; then
		tmux new-window -d -n smb2
		tmux send-keys -t smb2 "smbclient -L ${ip_address} -N" Enter
  else
		continue
	fi
done

