#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

mkdir -p "$MY_HOME/.ssh"
create_symlink "$DOTFILES_ROOT/apps/ssh/config" "$MY_HOME/.ssh/config"

log_info "Set up SSH successfully."

