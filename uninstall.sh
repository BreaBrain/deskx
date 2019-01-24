#!/bin/bash
vncserver -kill :1
sudo apt-get purge xorg lxde-core vncserver
sudo apt-get purge lxde
rm /bin/vncstart
rm /bin/vncstop
