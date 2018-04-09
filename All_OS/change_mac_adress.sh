#!/bin/bash
#apt purge teamviewer-host
#wget http://download.teamviewer.com/download/linux/version_13x/teamviewer-host_armhf.deb

RANGE=255
#set integer ceiling

number=$RANDOM
numbera=$RANDOM
numberb=$RANDOM
#generate random numbers

let "number %= $RANGE"
let "numbera %= $RANGE"
let "numberb %= $RANGE"
#ensure they are less than ceiling

octets='00-60-2F'
#set mac stem

octeta=`echo "obase=16;$number" | bc`
octetb=`echo "obase=16;$numbera" | bc`
octetc=`echo "obase=16;$numberb" | bc`
#use a command line tool to change int to hex(bc is pretty standard)
#they're not really octets.  just sections.

macadd="${octets}-${octeta}-${octetb}-${octetc}"

echo "$macadd"

read a

echo "#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will \"exit 0\" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Generate the SSH keys if non-existent
ssh-keygen -A
ifconfig eth0 hw ether $macadd
exit 0" > /etc/rc.local


#dpkg -i ./teamviewer-host_armhf.deb

echo "reboot"
read a

reboot
