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
echo "---OS---"
echo "1. Debian"
echo "2. Ubuntu"
echo "more comming soon.."
read os
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install lxde
sudo apt-get install -y nano
if [ $os == "1" ]; then
sudo apt-get -y install xorg lxde-core tightvncserver
elif[ $os == "2" ]; then
sudo apt-get install -y xfce4 xfce4-goodies
sudo apt-get -y install tightvncserver
fi
tightvncserver :1
tightvncserver -kill :1
if [ $os == "1" ]; then
echo "lxterminal &"  >> ~/.vnc/xstartup
echo "/usr/bin/lxsession -s LXDE &" >> ~/.vnc/xstartup
elif[ $os == "2"]; then
mv /root/.vnc/xstartup /root/.vnc/xstartup.bak
echo "
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
" >> /root/.vnc/xstartup
sudo chmod +x  /root/.vnc/xstartup
fi
echo "#!/bin/bash" >> /bin/vncstart
echo "tightvncserver :1 $res">> /bin/vncstart
sudo chmod +x /bin/vncstart
echo "#!/bin/bash" >> /bin/vncstop
echo "tightvncserver -kill :1" >> /bin/vncstop
sudo chmod +x /bin/vncstop

sudo apt-get -y install ristretto
sudo apt-get -y install mpv

clear
echo "---------------------------"
echo ": Finished!               :"
echo ": VNC IP:   localhost:1   :"
echo ": Start:    vncstart      :"
echo ": Stop:     vncstop       :"
echo "---------------------------"
else
echo $q
echo "ok"
fi
