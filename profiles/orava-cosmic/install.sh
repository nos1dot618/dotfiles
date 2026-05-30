#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

PACKAGES=(
)

PIPX_PACKAGES=(
)

#install_package "${PACKAGES[@]}"
#setup_pipx
#install_pipx_package "${PIPX_PACKAGES[@]}"

log_info "Packages installed successfully."
