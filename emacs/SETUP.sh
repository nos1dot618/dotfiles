#!/bin/sh

# I know I can use GNU stow but fuck it we ball

if [ -z $ROOT ]; then
    ROOT=$(pwd)
    echo "ROOT not set, defaulting to: ${ROOT}"
fi

SCRIPTS=~/.elsc
mkdir -p $SCRIPTS

# TODO: cannot not make emacs follow symlinks from elisp
ln    -f $ROOT/emacs/scripts/odin-mode/odin-mode.el       $SCRIPTS/odin-mode.el
