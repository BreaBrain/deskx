#!/bin/bash                                                                                                         
sudo apt-get update                                                                                                 
sudo apt-get upgrade                                                                                                
sudo apt-get install lxde
apt-get install nano
apt-get install xorg lxde-core tightvncserver
tightvncserver :1
tightvncserver -kill :1
echo "lxterminal &"  >> ~/.vnc/xstartup
echo "/usr/bin/lxsession -s LXDE &" >> ~/.vnc/xstartup
