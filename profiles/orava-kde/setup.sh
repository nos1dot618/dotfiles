#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

sudo -E bash "$PROFILE/install.sh"

bash "$PROFILE/applications/spectacle/setup.sh"
bash "$PROFILE/applications/tesseract-ocr/setup.sh"
log_info "Set up \"Orave-KDE\" specific applications successfully."

bash "$PROFILE/autostart.sh"
log_info "Set up KDE autostart script successfully."

log_info "Set up profile \"Orave-KDE\" successfully."
