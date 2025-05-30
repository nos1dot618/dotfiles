#!/usr/bin/env bash
set -xeu

ln -sf "$DOTFILES_ROOT/apps/bash/config.sh" "$MY_HOME/.bashrc"
ln -sf "$DOTFILES_ROOT/apps/bash/profile.sh" "$MY_HOME/.profile"
