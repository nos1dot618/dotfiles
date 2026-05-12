#!/usr/bin/env bash

# Colors
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
GRAY="\033[0;90m"
RESET="\033[0m"

log() {
    local level="$1"
    local color="$2"
    shift 2

    [[ $# -eq 0 ]] && return

    local prefix="[$level]"
    local indent
    indent=$(printf '%*s' "${#prefix}" '')

    printf "[${color}%s${RESET}] %s\n" "$level" "$1"

    shift

    for line in "$@"; do
        printf "%s %s\n" "$indent" "$line"
    done
}

log_info() {
    log "INFO" "$BLUE" "$@"
}

log_note() {
    log "NOTE" "$GRAY" "$@"
}

log_warn() {
    log "WARN" "$YELLOW" "$@"
}

log_debug() {
    log "DEBUG" "$CYAN" "$@"
}

log_error() {
    log "ERROR" "$RED" "$@" >&2
}

log_fatal() {
    log "FATAL" "$RED" "$@" >&2
    exit 1
}

create_symlink() {
    local use_sudo=false
    if [[ "$1" == "--sudo" ]]; then
        use_sudo=true
        shift
    fi

    local src="$1"
    local dest="$2"

    if $use_sudo; then
        sudo ln -sf "$src" "$dest"
    else
        ln -sf "$src" "$dest"
    fi

    log_note "Created symlink" "from \"$dest\"" "to \"$src\"."
}

update_package_list() {
    log_info "Updating apt package-list."
    sudo apt-get update > /dev/null 2>&1
}

install_package() {
    local skip_installed=false
    if [[ "$1" == "--skip-installed" ]]; then
        skip_installed=true
        shift
    fi

    for package in "$@"; do
        if $skip_installed && dpkg -s "$package" >/dev/null 2>&1; then
            continue
        fi

        log_note "Installing package \"$package\"."
        sudo apt-get -y install "$package" >/dev/null 2>&1
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

make_executable() {
    chmod +x "$1"
    log_note "Made \"$1\" executable."
}
