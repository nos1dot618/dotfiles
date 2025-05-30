#!/usr/bin/env bash
set -xeu

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

bash "$DOTFILES_ROOT/devices/touchpad/setup.sh"
