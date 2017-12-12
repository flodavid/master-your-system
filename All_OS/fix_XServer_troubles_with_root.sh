#!/bin/bash

location_script=/etc/profile.d/fix_XServer.sh
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

expert DISPLAY=:0

echo -e "#!/bin/bash \n xhost +local:" > $location_script
chmod +x $location_script 
