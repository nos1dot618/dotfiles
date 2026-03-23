#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

install_package tesseract-ocr tesseract-ocr-eng wl-clipboard

chmod +x "$DOTFILES_ROOT/profiles/orava-kde/applications/tesseract-ocr/ocr.sh"

log_info "Set up OCR using \"tesseract\" successfully."
