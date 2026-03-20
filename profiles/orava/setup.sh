#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

create_symlink "$DOTFILES_ROOT/profiles/orava/path.txt" "$MY_HOME/.config/path.txt"

sudo apt-get update > /dev/null 2>&1
log_info "Updated apt package list."

HOSTNAME="orava"
sudo hostnamectl set-hostname "$HOSTNAME"
log_info "Hostname set to \"$HOSTNAME\"."

sudo -E bash "$DOTFILES_ROOT/profiles/orava/install.sh"

# bash "$DOTFILES_ROOT/desktop/setup.sh"

bash "$DOTFILES_ROOT/apps/bash/setup.sh"
bash "$DOTFILES_ROOT/apps/emacs/setup.sh"
bash "$DOTFILES_ROOT/apps/fish/setup.sh"
bash "$DOTFILES_ROOT/apps/git/setup.sh"
bash "$DOTFILES_ROOT/apps/ssh/setup.sh"
bash "$DOTFILES_ROOT/apps/cloudflare-warp/setup.sh"

bash "$DOTFILES_ROOT/fonts/setup.sh"
