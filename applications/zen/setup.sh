#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

FILE="zen.linux-x86_64.tar.xz"
URL="https://github.com/zen-browser/desktop/releases/latest/download/${FILE}"
DEST="${MY_HOME}/Downloads/${FILE}"

if [ ! -x "${MY_HOME}/ThirdParty/zen/zen" ]; then
    log_note "Downloading \"zen latest\" binary."
    wget -O "$DEST" "$URL" > /dev/null 2>&1
    tar -xvf "$DEST" -C "${MY_HOME}/Downloads/" > /dev/null 2>&1
    mv "${MY_HOME}/Downloads/zen/" "${MY_HOME}/ThirdParty/"
    rm -f "$DEST"
fi

create_symlink "${DOTFILES_ROOT}/applications/zen/zen.desktop" \
               "${MY_HOME}/.local/share/applications/zen.desktop"
chmod +x "${MY_HOME}/.local/share/applications/zen.desktop"

log_info "Set up \"zen latest\" successfully."
