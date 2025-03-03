#!/bin/bash

TOOLS=(
	tmux
	xclip # for copying to clipboard in tmux
	emacs
	nitrogen brightnessctl gnome-screenshot # for i3wm
)

sudo apt install $TOOLS[@]
