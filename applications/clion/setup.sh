#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

FILE="CLion-2026.1.1.tar.gz"
URL="https://download.jetbrains.com/cpp/${FILE}"
DEST="${MY_HOME}/Downloads/${FILE}"

if [ ! -x "${MY_HOME}/ThirdParty/clion-2026.1.1/bin/clion" ]; then
    log_note "Downloading \"clion 2026.1.1\" binary."
    wget -O "$DEST" "$URL" > /dev/null 2>&1
    tar -xzf "$DEST" -C "${MY_HOME}/Downloads/" > /dev/null 2>&1
    mv "${MY_HOME}/Downloads/clion-2026.1.1/" "${MY_HOME}/ThirdParty/"
    rm -f "$DEST"
fi

create_symlink "${DOTFILES_ROOT}/applications/clion/clion.desktop" \
               "${MY_HOME}/.local/share/applications/clion.desktop"
chmod +x "${MY_HOME}/.local/share/applications/clion.desktop"
