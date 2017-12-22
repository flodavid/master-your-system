#!/bin/bash

function help {
	echo "Syntax: $0 -[l][u] target(s)"
	echo " Parameters come first. Target is expressed as a IP address."
	echo " No specified parameter will ban the IP."
	echo " -l to list currently banned IPs."
	echo " -u to unban IP(s)."
	exit 1
}

# If no arguments are passed, call the "help" function.
if [ -z "$1" ]; then
	help
fi

# Define some variables
ACTION="-A"
txtred=$(tput setaf 1)
txtyel=$(tput setaf 3)
txtcya=$(tput setaf 6)
txtrst=$(tput sgr0)

while getopts "hul" OPTION
do
	case $OPTION in
		h)
			help
			;;
		u)
			ACTION="-D"
			shift $(($OPTIND - 1))
			;;
		l)
			ACTION="-L"
			shift $(($OPTIND - 1))
			;;
		\?)
			help
			;;
	esac
done

if [ $ACTION == "-L" ]; then
	echo $txtcya"List of Banned IPs:"$txtrst
	iptables -L INPUT -v -n | grep DROP
else
	# ban work loop
	for ZTARGET in "$@"
	do
		echo $txtcya"Applying action $txtred$ACTION$txtcya to $txtyel$ZTARGET"$txtrst
		iptables $ACTION INPUT -s $ZTARGET -j DROP
	done
fi
