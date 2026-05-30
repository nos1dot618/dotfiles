#!/usr/bin/env bash
set -eu
source "${DOTFILES_ROOT}/commons/utils.sh"

VERSION="1.110.01571"
FILE="codium_${VERSION}_amd64.deb"
URL="https://github.com/VSCodium/vscodium/releases/download/${VERSION}/${FILE}"
DEST="${MY_HOME}/Downloads/${FILE}"

if ! command -v codium >/dev/null 2>&1; then
    log_note "Downloading \"vscodium ${VERSION}\" package."
    wget -O "$DEST" "$URL" > /dev/null 2>&1
    sudo apt-get install -y "$DEST" > /dev/null 2>&1
    rm -f "$DEST"
fi
