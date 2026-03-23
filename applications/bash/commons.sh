#!/usr/bin/env bash

# Colors
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
GRAY="\033[0;90m"
RESET="\033[0m"

log_info() {
    echo -e "[${BLUE}INFO${RESET}] $*"
}

log_note() {
    echo -e "[${GRAY}NOTE${RESET}] $*"
}

log_warn() {
    echo -e "[${YELLOW}WARN${RESET}] $*"
}

log_error() {
    echo -e "[${RED}ERROR${RESET}] $*" >&2
}

log_debug() {
    echo -e "[${CYAN}DEBUG${RESET}] $*"
}

log_fatal() {
    echo -e "[${RED}FATAL${RESET}] $*" >&2
    exit 1
}

create_symlink() {
    local src="$1"
    local dest="$2"

    ln -sf "$src" "$dest"
    log_note "Created symlink \"$dest\" -> \"$src\"."
}

install_package() {
    for package in "$@"; do
        log_note "Installing package \"$package\"."
        sudo apt-get -y install "$package" > /dev/null 2>&1
    done
}

setup_pipx() {
    pipx ensurepath > /dev/null 2>&1
    log_info "Added pipx to the PATH."
}

install_pipx_package() {
    for package in "$@"; do
        log_note "Installing package \"$package\" through pipx."
        pipx install "$package" > /dev/null 2>&1
    done
}
