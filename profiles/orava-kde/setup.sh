#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

sudo -E bash "$DOTFILES_ROOT/profiles/orava-kde/install.sh"

# bash "$DOTFILES_ROOT/profiles/orava-kde/autostart.sh"

log_info "Set up profile \"Orave-KDE\" successfully."
