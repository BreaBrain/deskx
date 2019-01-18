#!/bin/bash
tightvncserver -kill :1
sudo apt-get purge xorg lxde-core tighvncserver
sudo apt-get purge lxde
rm /bin/vncstart
rm /bin/vncstop
