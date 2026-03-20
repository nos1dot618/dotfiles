#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

PACKAGES=(
		# Base
		git
		tmux
		fish

		# C++
		clangd
		cmake
		clang
		libstdc++-12-dev
)

install_packages() {
		for package in "$@"; do
				install_package "$package"
		done
}

install_packages "${PACKAGES[@]}"

# Python
if apt-cache show python3.12-venv > /dev/null 2>&1; then
		install_packages python3.12 python3.12-venv
else
		log_warn "Python 3.12 is not available, falling back to Python 3.11."
		install_packages python3.11 python3.11-venv
fi

log_info "Packages installed successfully."
