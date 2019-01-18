#!/bin/bash      
#----------------------------
#works with:        debian
#doesn't work with:    opensuse
#----------------------------
sudo apt-get update                                                                                                 
sudo apt-get -y upgrade                                                                                                
sudo apt-get -y install lxde
sudo apt-get install -y nano
sudo apt-get install -y xorg lxde-core tightvncserver
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

sudo apt-get -y install ristretto

clear
echo "---------------------------"
echo ": Finished!               :"
echo ": VNC IP:   localhost:1   :" 
echo ": Start:    vncstart      :"
echo ": Stop:     vncstop       :"
echo "---------------------------"
