#!/usr/bin/env bash
set -xeu

export DOTFILES_ROOT=$(pwd)
export PROFILE="$DOTFILES_ROOT/profiles/orava-popos"
# NOTE: This is need such that superuser scripts does not assume the user 'root'
#       and home '/root', when running commands as superuser.
export MY_USER="$USER"
export MY_HOME="$HOME"

bash "$PROFILE/setup.sh" || true
