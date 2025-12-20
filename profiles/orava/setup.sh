#!/usr/bin/env bash
set -xeu

sudo hostnamectl set-hostname "orava"

sudo -E bash "$DOTFILES_ROOT/profiles/orava/install.sh"

bash "$DOTFILES_ROOT/desktop/setup.sh"

bash "$DOTFILES_ROOT/apps/bash/setup.sh"
# bash "$DOTFILES_ROOT/apps/emacs/setup.sh"
bash "$DOTFILES_ROOT/apps/fish/setup.sh"
bash "$DOTFILES_ROOT/apps/git/setup.sh"
bash "$DOTFILES_ROOT/apps/ssh/setup.sh"
bash "$DOTFILES_ROOT/apps/cloudflare-warp/setup.sh"
