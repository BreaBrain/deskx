#!/bin/bash                                                                                                         
#----------------------------                                                                                       
#works with:        debian                                                                                          
#doesn't work with:    opensuse                                                                                     
#----------------------------
clear
echo "Do you want to install VNC for vServer? (y/n)"
read q
if [ $q == "y" ]; then
#echo "Resoltion [ Width x height ] ? (normal)"
echo "Different resolution? (y/n)"
read r
if [ $r == "y" ]; then
echo "width"
read w
echo "heigth"
read h
res="-geometry $w\x$h"
fi
clear
echo "---=OS=---"
echo "1. Debian"
echo "2. Ubuntu"
echo "more comming soon.."
read os
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install lxde
sudo apt-get install -y nano

if [ $os == "1" ]; then
sudo apt-get -y install xorg lxde-core
sudo apt-get -y install vnc4server
fi
if[ $os == "2" ]

sudo apt-get -y install xfce4 xfce4-goodies
sudo apt-get -y install tightvncserver
fi
tightvncserver :1
tightvncserver -kill :1
if [ $os == "1" ];then
echo "lxterminal &"  >> ~/.vnc/xstartup
echo "/usr/bin/lxsession -s LXDE &" >> ~/.vnc/xstartup
fi
if [ $os == "2" ]; then
mv /root/.vnc/xstartup /root/.vnc/xstartup.bak
echo "
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
" >> /root/.vnc/xstartup
sudo chmod +x  /root/.vnc/xstartup
fi
echo "#!/bin/bash" >> /bin/vncstart
echo "vncserver :1 $res -depth 24 -localhost no ">> /bin/vncstart
sudo chmod +x /bin/vncstart
echo "#!/bin/bash" >> /bin/vncstop
echo "vncserver -kill :1" >> /bin/vncstop
#echo "tightvncserver -kill :1" >> /bin
sudo chmod +x /bin/vncstop

sudo apt-get -y install ristretto
sudo apt-get -y install mpv
sudo apt-get -y install firefox-esr
sudo apt-get -y install chromium-browser
sudo apt-get -y install nautilus
sudo apt-get -y install smplayer
sudo apt-get -y install python

if [ $os == "2" ]; then
clear
echo "Do you want to install Tor Browser? (y/n)"
read tor
if [ $tor == "y" ]; then
sudo printf "deb http://deb.debian.org/debian stretch-backports main contrib" > /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt install -y torbrowser-launcher
sudo mv tor /root/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/start-tor-browser.desktop
fi
fi


clear
echo "---------------------------"
echo ": Finished!               :"
echo ": VNC IP:   localhost:1   :"
echo ": Start:    vncstart      :"
echo ": Stop:     vncstop       :"
echo "---------------------------"
