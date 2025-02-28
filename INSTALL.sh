#!/bin/bash

TOOLS=(
	tmux
	xclip # for copying to clipboard in tmux
	emacs
)

sudo apt install $TOOLS[@]
