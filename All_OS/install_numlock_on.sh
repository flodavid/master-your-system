#!/bin/bash

location_script=/etc/profile.d/numlock_startup.sh
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo -e "#!/bin/bash \n if [ -x /usr/bin/numlockx ]; then \n /usr/bin/numlockx on \n fi" > $location_script
chmod +x $location_script
