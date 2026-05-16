#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

sudo -E bash "$PROFILE/install.sh"

bash "$PROFILE/autostart.sh"
log_info "Set up KDE autostart script successfully."

log_info "Set up profile \"Orave-KDE\" successfully."
