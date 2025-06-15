#!/usr/bin/env bash
set -xeu

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

bash "$DOTFILES_ROOT/profiles/orava-kde/autostart.sh"
