#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

sudo DOTFILES_ROOT="$DOTFILES_ROOT" \
    PROFILE="$PROFILE" \
    MY_HOME="$MY_HOME" \
    MY_USER="$MY_USER" \
    bash "$PROFILE/install.sh"

log_info "Set up profile \"Orave-Cosmic\" successfully."
