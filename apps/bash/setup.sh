#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

create_symlink "$DOTFILES_ROOT/apps/bash/config.sh" "$MY_HOME/.bashrc"
create_symlink "$DOTFILES_ROOT/apps/bash/profile.sh" "$MY_HOME/.profile"

log_info "Set up Bash successfully."
