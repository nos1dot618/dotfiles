#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

SHELL_PATH=/usr/bin/fish
sudo chsh -s "$SHELL_PATH" "$MY_USER"
log_info "Default Shell set to \"$SHELL_PATH\"."

mkdir -p "$MY_HOME/.config/fish"
create_symlink "$DOTFILES_ROOT/applications/fish/config.fish" "$MY_HOME/.config/fish/config.fish"

log_info "Set up Fish successfully."
