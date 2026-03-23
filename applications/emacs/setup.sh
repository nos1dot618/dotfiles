#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

# Build Emacs 30.1.
if [ ! -x "/usr/local/bin/emacs" ]; then
		# Download Source Code from <https://ftp.gnu.org/pub/gnu/emacs>.
		mkdir -p "$MY_HOME/ThirdParty/"
		sudo chown -R "$MY_USER" "$MY_HOME/ThirdParty"
		cd "$MY_HOME/ThirdParty/"

		log_note "Downloading official Emacs source-code."
		wget -nc https://ftp.gnu.org/pub/gnu/emacs/emacs-30.1.tar.xz

		log_note "Decompressing Emacs source-code."
		tar -axvf emacs-30.1.tar.xz

		install_package build-essential
		log_note "Building Emacs dependencies."
		sudo apt-get build-dep -y emacs
		
		cd "$MY_HOME/ThirdParty/emacs-30.1"
		mkdir build
		cd build
		../configure
		make -j"$(nproc)"
		log_note "Building Emacs 30.1."
		sudo make -j"$(nproc)" install
		rm -f "$MY_HOME/ThirdParty/emacs-30.1.tar.gz"
fi

# Delete these PATHs, s.t. emacs gives priority to "$MY_HOME/.config/emacs".
rm -rf "$MY_HOME/.emacs" "$MY_HOME/.emacs.d"
mkdir -p "$MY_HOME/.config/emacs"
create_symlink "$DOTFILES_ROOT/applications/emacs/init.el" "$MY_HOME/.config/emacs/init.el"
create_symlink "$DOTFILES_ROOT/applications/emacs/custom.el" "$MY_HOME/.config/emacs/custom.el"
create_symlink "$DOTFILES_ROOT/applications/emacs/lsp.el" "$MY_HOME/.config/emacs/lsp.el"

log_info "Set up Emacs successfully."
