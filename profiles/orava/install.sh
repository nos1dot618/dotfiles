#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

PACKAGES=(
    # Base.
    git
    tmux
    fish
    tree
    feh
    direnv

    # C++.
    clangd
    cmake
    clang
    libstdc++-12-dev

    # Python.
    python3-pip
    pipx
)

PIPX_PACKAGES=()

install_package "${PACKAGES[@]}"

# Python
if apt-cache show python3.12-venv > /dev/null 2>&1; then
    install_package python3.12 python3.12-venv
else
    log_warn "Python 3.12 is not available, falling back to Python 3.11."
    install_package python3.11 python3.11-venv
fi

setup_pipx
install_pipx_package "${PIPX_PACKAGES[@]}"

log_info "Packages installed successfully."
