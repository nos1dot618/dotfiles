#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

mkdir -p "$MY_HOME/.ssh"
create_symlink "$DOTFILES_ROOT/applications/ssh/config" "$MY_HOME/.ssh/config"
