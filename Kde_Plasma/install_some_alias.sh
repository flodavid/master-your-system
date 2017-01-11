#!/bin/bash

echo 'alias upate-grub="grub2-mkconfig -o /boot/grub2/grub.cfg"' >> ~/.bashrc

echo 'alias g++-5="g++"' >> ~/.bashrc

echo 'PATH=$PATH:/usr/lib ' >> ~/.bashrc
echo 'export PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib' >> ~/.bashrc

# echo '' >> ~/.bashrc


source ~/.bashrc
