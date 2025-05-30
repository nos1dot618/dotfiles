#!/usr/bin/env bash
set -xeu

bash "$DOTFILES_ROOT/profiles/orava/setup.sh"

# Make the Cosmic Dock show only windows that are present in the current workspace.
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
