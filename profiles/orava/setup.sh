#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

create_symlink "$DOTFILES_ROOT/profiles/orava/path.txt" "$MY_HOME/.config/path.txt"
create_symlink "$DOTFILES_ROOT/profiles/orava/.envrc" "$MY_HOME/.envrc"

log_info "Updating apt package list."
sudo apt-get update > /dev/null 2>&1

HOSTNAME="orava"
sudo hostnamectl set-hostname "$HOSTNAME"
log_info "Hostname set to \"$HOSTNAME\"."

sudo -E bash "$DOTFILES_ROOT/profiles/orava/install.sh"

direnv allow ~
log_info "Set up environment variables management via \"direnv\"".

bash "$DOTFILES_ROOT/desktop/setup.sh"

bash "$DOTFILES_ROOT/applications/bash/setup.sh"
bash "$DOTFILES_ROOT/applications/emacs/setup.sh"
bash "$DOTFILES_ROOT/applications/fish/setup.sh"
bash "$DOTFILES_ROOT/applications/git/setup.sh"
bash "$DOTFILES_ROOT/applications/ssh/setup.sh"
bash "$DOTFILES_ROOT/applications/cloudflare-warp/setup.sh"

bash "$DOTFILES_ROOT/fonts/setup.sh"

log_info "Set up profile \"Orave\" successfully."
