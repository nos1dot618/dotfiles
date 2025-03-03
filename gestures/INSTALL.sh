#!/bin/bash

# Reference: https://github.com/bulletmark/libinput-gestures
# IMPORTANT: DO NOT RUN WITH SUDO

sudo gpasswd -a $USER input
sudo apt-get install wmctrl xdotool libinput-tools

mkdir -p ~/ThirdParty
cd ~/ThirdParty

git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo ./libinput-gestures-setup install
