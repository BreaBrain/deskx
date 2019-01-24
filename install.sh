#!/bin/bash

function update {
        sudo apt-get -y update
        sudo apt-get -y upgrade
}

function programms {
        sudo apt-get -y install nano
        sudo apt-get -y install python
        sudo apt-get -y install ristretto
        sudo apt-get -y install mpv
        sudo apt-get -y install firefox-esr
        sudo apt-get -y install chromium-browser
        sudo apt-get -y install nautilus
        sudo apt-get -y install smplayer

}

function script {
        echo "#!/bin/bash" >> /bin/vncstart
        echo "vncserver :1 -geometry 1920x1080 -depth 24 -localhost no">> /bin/vncstart
        sudo chmod +x /bin/vncstart
        echo "#!/bin/bash" >> /bin/vncstop
        echo "vncserver -kill :1" >> /bin/vncstop
        sudo chmod +x /bin/vncstop
}


clear
echo "Do you want to install VNC for vServer? (y/n)"
read q
if [ $q == "y" ]; then
clear
echo "Operating System"
echo "================="
echo "1. Debian"
echo "2. Ubuntu"
echo "3. OpenSuse"
read os
if [ $os == "1" ]; then

        update
        apt-get install sudo
        sudo apt-get -y install lxde
        sudo apt-get -y install xorg lxde-core vnc4server
        #sudo apt-get -y install vnc4server
        sudo vncpasswd

        #echo "lxterminal &"  >> ~/.vnc/xstartup
        #echo "/usr/bin/lxsession -s LXDE &" >> ~/.vnc/xstartup
        echo "exec /usr/bin/mate-session &" >> ~/.vnc/xstartup

        vncserver :1
        vncserver -kill :1

        programms

        sudo printf "deb http://deb.debian.org/debian stretch-backports main contrib" > /etc/apt/sources.list
        update
        sudo apt-get install -y torbrowser-launcher
        sudo mv tor /root/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/start-tor-browser

        script
fi

if [ $os == "2" ]; then

        update
        apt-get install sudo
        sudo apt-get -y install xfce4 xfce4-goodies
        sudo apt-get -y install vnc4server
        sudo vncpasswd

        echo "exec /usr/bin/mate-session &" >> ~/.vnc/xstartup

        vncserver :1
        vncserver -kill :1

        programms

fi




clear
echo "------------------------------"
echo ": Finished!                  :"
echo ": VNC IP:   localhost:5901   :"
echo ": Start:    vncstart         :"
echo ": Stop:     vncstop          :"
echo "------------------------------"
fi
