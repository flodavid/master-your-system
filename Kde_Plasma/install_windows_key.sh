#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get install git gcc make libx11-dev libxtst-dev pkg-config
cd /usr/local/src
git clone https://github.com/hanschen/ksuperkey.git
cd ksuperkey
make
echo -e "#!/bin/bash \n /usr/local/src/ksuperkey/ksuperkey" >> /etc/profile.d/ksuperkey.sh
echo "type '/usr/local/src/ksuperkey/ksuperkey to run, it will autorun at your next reboot'"
