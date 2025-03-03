#!/bin/bash

TOOLS=(
	tmux
	xclip # for copying to clipboard in tmux
	emacs
	nitrogen brightnessctl gnome-screenshot playerctl # for i3wm
)

sudo apt install $TOOLS[@]
