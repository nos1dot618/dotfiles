#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

FILE="dmd_2.112.0-0_amd64.deb"
URL="https://downloads.dlang.org/releases/2.x/2.112.0/${FILE}"
DEST="${MY_HOME}/Downloads/${FILE}"

log_note "Installing \"dmd 2.112.0\"."
if ! command -v dmd >/dev/null 2>&1; then
    wget -O "$DEST" "$URL" > /dev/null 2>&1
    sudo apt install -y "$DEST" > /dev/null 2>&1
    rm -f "$DEST"
fi

log_note "Installing \"serve-d 0.8.0\"."
if ! command -v serve-d >/dev/null 2>&1; then
    FILE="serve-d_0.8.0-beta.18-linux-x86_64.tar.gz"
    URL="https://github.com/Pure-D/serve-d/releases/download/v0.8.0-beta.18/${FILE}"
    DEST="${MY_HOME}/Downloads/${FILE}"
    wget -O "$DEST" "$URL" > /dev/null 2>&1
    tar -xzf "$DEST" -C "${MY_HOME}/Downloads" > /dev/null 2>&1
    mkdir -p "${MY_HOME}/ThirdParty/serve-d/"
    mv "${MY_HOME}/Downloads/serve-d" "${MY_HOME}/ThirdParty/serve-d/"
    sudo create_symlink "${MY_HOME}/ThirdParty/serve-d/serve-d" "${MY_HOME}/.local/bin/serve-d"
    rm -f "$DEST"
fi
