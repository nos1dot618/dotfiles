#!/usr/bin/env bash
set -xeu

# Reference: https://github.com/bulletmark/libinput-gestures
mkdir -p "$MY_HOME/ThirdParty"
if [ ! -x "$MY_HOME/ThirdParty/libinput-gestures" ]; then
  sudo gpasswd -a $MY_USER input
  sudo apt-get -y install wmctrl xdotool libinput-tools
  cd "$MY_HOME/ThirdParty"
  git clone https://github.com/bulletmark/libinput-gestures.git
  cd libinput-gestures
  sudo ./libinput-gestures-setup install
fi

ln -sf "$DOTFILES_ROOT/devices/touchpad/libinput-gestures.conf" "$MY_HOME/.config/libinput-gestures.conf"
sudo ln -sf "$DOTFILES_ROOT/devices/touchpad/90-touchpad.conf" "/etc/X11/xorg.conf.d/90-touchpad.conf"
