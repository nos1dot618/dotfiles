#!/bin/sh

# I know I can use GNU stow but fuck it we ball

if [ -z $ROOT ]; then
    ROOT=$(pwd)
    echo "ROOT not set, defaulting to: ${ROOT}"
fi

EMACS_VERSION=27.1

ln -s -f $ROOT/i3/config                          ~/.config/i3/config
ln -s -f $ROOT/i3status/config                    ~/.config/i3status/config
ln -s -f $ROOT/gestures/libinput-gestures.conf    ~/.config/libinput-gestures.conf
ln -s -f $ROOT/fish/config.fish                   ~/.config/fish/config.fish
ln -s -f $ROOT/tmux/config                        ~/.tmux.conf
ln -s -f $ROOT/emacs/init.el                      ~/.emacs
ln -s -f $ROOT/Makefile                           ~/Makefile
# TODO: cannot not make emacs follow symlinks from elisp
ln    -f $ROOT/emacs/custom.el                    ~/.emacs.custom.el
ln    -f $ROOT/emacs/lsp.el                       ~/.emacs.lsp.el
# Sudo commands
sudo ln    -f $ROOT/emacs/theme.el                /usr/share/emacs/$EMACS_VERSION/etc/themes/wombat-theme.el

bash $ROOT/emacs/SETUP.sh
