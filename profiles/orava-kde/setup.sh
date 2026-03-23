#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

sudo -E bash "$PROFILE/install.sh"

# bash "$DOTFILES_ROOT/profiles/orava-kde/autostart.sh"

bash "$PROFILE/applications/spectacle/setup.sh"
bash "$PROFILE/applications/tesseract-ocr/setup.sh"
log_info "Set up \"Orave-KDE\" specific applications successfully."

log_info "Set up profile \"Orave-KDE\" successfully."
