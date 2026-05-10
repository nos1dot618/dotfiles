#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

install_package --skip-installed curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    > /dev/null 2>&1

sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
    https://brave-browser-apt-release.s3.brave.com/brave-browser.sources \
    > /dev/null 2>&1

log_info "Added \"brave-browser\" repository to apt package-list."

update_package_list
install_package brave-browser
