#!/usr/bin/env bash
set -xeu

# Build Emacs 30.1
if [ ! -x "/usr/local/bin/emacs" ]; then
  sudo apt -y install build-essential
  sudo apt build-dep emacs
  cd "$MY_HOME/ThirdParty/emacs-30.1"
  mkdir build
  cd build
  ../configure
  make -j"$(nproc)"
  sudo make -j"$(nproc)" install
fi

mkdir -p "$MY_HOME/.config/emacs"
ln -sf "$DOTFILES_ROOT/apps/emacs/init.el" "$MY_HOME/.config/emacs/init.el"
ln -sf "$DOTFILES_ROOT/apps/emacs/custom.el" "$MY_HOME/.config/emacs/custom.el"
ln -sf "$DOTFILES_ROOT/apps/emacs/lsp.el" "$MY_HOME/.config/emacs/lsp.el"
