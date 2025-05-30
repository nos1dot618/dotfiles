#!/usr/bin/env bash
set -xeu

source $DOTFILES_ROOT/profiles/orava/install.sh

sudo apt -y install nitrogen brightnessctl gnome-screenshot playerctl
