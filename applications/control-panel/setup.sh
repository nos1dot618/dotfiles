#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

install_package python3-pyqt5
make_executable "$DOTFILES_ROOT/applications/control-panel/application.py"

create_symlink "${DOTFILES_ROOT}/applications/control-panel/control-panel.desktop" \
               "${MY_HOME}/.local/share/applications/control-panel.desktop"
chmod +x "${MY_HOME}/.local/share/applications/control-panel.desktop"
