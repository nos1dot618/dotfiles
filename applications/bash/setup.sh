#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

create_symlink "$DOTFILES_ROOT/applications/bash/config.sh" "$MY_HOME/.bashrc"
create_symlink "$DOTFILES_ROOT/applications/bash/profile.sh" "$MY_HOME/.profile"
