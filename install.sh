#!/bin/bash

function update {
        sudo apt-get -y update
        sudo apt-get -y upgrade
}

function programms {
        update
        sudo apt-get -y install nano
        sudo apt-get -y install python3 python
        sudo apt-get -y install python3-pip python-pip
        sudo apt-get -y install python3-curl python-curl
        sudo apt-get -y install ristretto
        sudo apt-get -y install mpv
        sudo apt-get -y install firefox-esr
        sudo apt-get -y install firefox
        sudo apt-get -y install chromium-browser
        sudo apt-get -y install nautilus
        sudo apt-get -y install smplayer

}

function script {
        echo "#!/bin/bash" > /bin/vncstart
        echo "tightvncserver :1 -geometry 1920x1080"> /bin/vncstart
        sudo chmod +x /bin/vncstart
        echo "#!/bin/bash" > /bin/vncstop
        echo "tightvncserver -kill :1" > /bin/vncstop
        sudo chmod +x /bin/vncstop
}

function f2b {
        sudo apt-get -y install fail2ban
        sudo systemctl stop fail2ban
        sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
        server=$(cat /etc/hostname)
        sudo echo "[tighvnc-auth]
                enabled = true
                port = 5901
                filter = tighvnc-auth
                logpath = /root/.vnc/$server:1.log
                bantime = 86400
                findtime = 3600
                maxretry = 3"  >> /etc/fail2ban/jail.local
        sudo touch /root/.vnc/vnc.log
        sudo touch /etc/fail2ban/filter.d/tighvnc-auth.conf
        sudo echo "[Definition]
                failregex = authentication failed from <HOST>
                ignoreregex =" >> /etc/fail2ban/filter.d/tighvnc-auth.conf
        sudo systemctl start fail2ban
        sudo echo "tail -f /var/log/auth.log" >> /bin/f2b
        sudo chmod +x /bin/f2b
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
        clear
        echo "1. LXDE"
        echo "2. XFCE4"
        read os1
        update
        apt-get install sudo
        
        if [ $os1 == 1 ]; then
        sudo apt-get -y install lxde
        sudo apt-get -y install xorg lxde-core tightvncserver -y
        #sudo apt-get -y install vnc4server
        #sudo vncpasswd
        fi
        if [ $os1 == 2 ]; then
        sudo apt install xfce4 xfce4-goodies tightvncserver -y
        fi
        vncserver :1
        vncserver -kill :1

        if [ $os1 == 1 ]; then
        echo "lxterminal &"  >> ~/.vnc/xstartup
        echo "/usr/bin/lxsession -s LXDE &" >> ~/.vnc/xstartup
        #echo "exec /usr/bin/mate-session &" >> ~/.vnc/xstartup
        fi 
        if [ $os1 == 2 ]; then
        sudo mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
        echo -e "#!/bin/bash
        xrdb $HOME/.Xresources
        startxfce4 &" > ~/.vnc/xstartup
        sudo chmod +x ~/.vnc/xstartup
        fi
        programms

        #sudo printf "deb http://deb.debian.org/debian stretch-backports main contrib" > /etc/apt/sources.list
        #update
        #sudo apt-get install -y torbrowser-launcher
        #sudo mv tor /root/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/start-tor-browser

        script
        #f2b
fi

if [ $os == "2" ]; then

        update
        apt-get install sudo
        sudo apt-get update
        sudo apt install xfce4 xfce4-goodies tightvncserver
        sudo vncpasswd
        vncserver :1
        vncserver -kill :1
        sudo mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
        echo -e "#!/bin/bash
        xrdb $HOME/.Xresources
        startxfce4 &" > ~/.vnc/xstartup
        sudo chmod +x ~/.vnc/xstartup
        vncserver :1
        ln -s /usr/share/backgrounds/xfce/ /wallpaper
        #echo "exec /usr/bin/mate-session &" >> ~/.vnc/xstartup

        script

        programms

fi


ip=$(curl ipecho.net/plain)
clear
echo "------------------------------"
echo ": Finished!                  :"
echo ": VNC IP:   $ip:5901   :"
echo ": Start:    vncstart         :"
echo ": Stop:     vncstop          :"
echo ": f2b Log:  f2b              :"
echo "------------------------------"
fi
