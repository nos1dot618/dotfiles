#!/usr/bin/env bash
set -xeu

mkdir -p "$MY_HOME/.ssh"
ln -sf "$DOTFILES_ROOT/apps/ssh/config" "$MY_HOME/.ssh/config"
