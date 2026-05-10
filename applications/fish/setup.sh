#!/usr/bin/env bash
set -eu
source "${DOTFILES_ROOT}/commons/utils.sh"

SHELL_PATH=/usr/bin/fish
sudo chsh -s "$SHELL_PATH" "$MY_USER"
log_info "Default Shell set to \"${SHELL_PATH}\"."

mkdir -p "${MY_HOME}/.config/fish"
create_symlink "${DOTFILES_ROOT}/applications/fish/config.fish" \
               "${MY_HOME}/.config/fish/config.fish"

FISH_STARTUP_DIR_PATH="${MY_HOME}/.config/fish/conf.d/"
mkdir -p "$FISH_STARTUP_DIR_PATH"
create_symlink "${DOTFILES_ROOT}/applications/fish/commons.fish" \
               "${FISH_STARTUP_DIR_PATH}/commons.fish"
