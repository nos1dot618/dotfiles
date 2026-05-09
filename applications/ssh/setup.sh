#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

mkdir -p "$MY_HOME/.ssh"
create_symlink "$DOTFILES_ROOT/applications/ssh/config" "$MY_HOME/.ssh/config"

log_info "Set up SSH successfully."
