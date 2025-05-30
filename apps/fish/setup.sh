#!/usr/bin/env bash
set -xeu

sudo chsh -s /usr/bin/fish "$MY_USER"

mkdir -p "$MY_HOME/.config/fish"
ln -sf "$DOTFILES_ROOT/apps/fish/config.fish" "$MY_HOME/.config/fish/config.fish"
