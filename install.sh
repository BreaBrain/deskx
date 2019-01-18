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

echo "#!/bin/bash" >> /bin/vncstart
echo "tightvncserver :1 " >> /bin/vncstart
sudo chmod +x /bin/vncstart
echo "#!/bin/bash" >> /bin/vncstop
echo "tightvncserver -kill :1" >> /bin/vncstop
sudo chmod +x /bin/vncstop

sudo apt-get install ristretto

clear
echo "---------------------------"
echo ": Finished!               :"
echo ": VNC IP:   localhost:1   :" 
echo ": Start:    vncstart      :"
echo ": Stop:     vncstop       :"
echo "---------------------------"
