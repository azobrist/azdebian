#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
	echo "Must run script as root" 2>&1
	exit 1
fi

user=$(id -u -n 1000)
home=$(pwd)
repo=/home/$user/azdebian

mkdir -p /home/$user/.config
mkdir -p /home/$user/.config/i3

apt update
apt upgrade -y

# install user desktop
apt install -y i3 xinit 

# isntall needed tools 
apt install -y kitty firefox-esr

touch /home/$user/.Xauthority
chmod 600 /home/$user/.Xauthority
chown $user:$user /home/$user/.Xauthority
echo "exec i3" > /home/$user/.xinitrc
chmod 600 /home/$user/.xinitrc
chown $user:$user /home/$user/.xinitrc

ln -svf $repo/i3.config /home/$user/.config/i3/config
#ln -svf $repo/kitty.conf /home/$user/config/kitty/kitty.conf

chown -R $user:$user /home/$user/.config
