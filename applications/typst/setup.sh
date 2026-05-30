#!/usr/bin/env bash
set -eu
source "${DOTFILES_ROOT}/commons/utils.sh"

VERSION="0.14.2"
FILE="typst-x86_64-unknown-linux-musl.tar.xz"
URL="https://github.com/typst/typst/releases/download/v${VERSION}/${FILE}"
DEST="${MY_HOME}/Downloads/${FILE}"
INSTALL_PATH="${MY_HOME}/ThirdParty/typst-${VERSION}"

if [ ! -x "${INSTALL_PATH}/typst" ]; then
    log_note "Downloading \"typst ${VERSION}\" portable archive."
    wget -O "$DEST" "$URL" > /dev/null 2>&1
    tar -xvf "$DEST" -C "${MY_HOME}/Downloads/" > /dev/null 2>&1
    mkdir -p "${MY_HOME}/ThirdParty"

    mv "${MY_HOME}/Downloads/typst-x86_64-unknown-linux-musl" "$INSTALL_PATH"
    rm -f "$DEST"
fi

create_symlink "$INSTALL_PATH" "${MY_HOME}/ThirdParty/typst"
