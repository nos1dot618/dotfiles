#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

FONTS_DIR="$MY_HOME/.local/share/fonts"

mkdir -p $FONTS_DIR
cp "$DOTFILES_ROOT/fonts/"*.ttf "$FONTS_DIR"

# Refresh fonts cache.
fc-cache -fv > /dev/null 2>&1
log_note "Refreshed fonts cache."

log_info "Set up Fonts successfully."

