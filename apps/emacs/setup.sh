#!/usr/bin/env bash
set -xeu

# Build Emacs 30.1
if [ ! -x "/usr/local/bin/emacs" ]; then
  # Download Source Code from <https://ftp.gnu.org/pub/gnu/emacs>
  mkdir -p "$MY_HOME/ThirdParty/"
  sudo chown -R "$MY_USER" "$MY_HOME/ThirdParty"
  cd "$MY_HOME/ThirdParty/"
  wget -nc https://ftp.gnu.org/pub/gnu/emacs/emacs-30.1.tar.xz
  tar -axvf emacs-30.1.tar.xz
  sudo apt -y install build-essential
  sudo apt build-dep emacs
  cd "$MY_HOME/ThirdParty/emacs-30.1"
  mkdir build
  cd build
  ../configure
  make -j"$(nproc)"
  sudo make -j"$(nproc)" install
  rm -f "$MY_HOME/ThirdParty/emacs-30.1.tar.gz"
fi

# Delete these PATHs, s.t. emacs gives priority to "$MY_HOME/.config/emacs"
rm -rf "$MY_HOME/.emacs" "$MY_HOME/.emacs.d"
mkdir -p "$MY_HOME/.config/emacs"
ln -sf "$DOTFILES_ROOT/apps/emacs/init.el" "$MY_HOME/.config/emacs/init.el"
ln -sf "$DOTFILES_ROOT/apps/emacs/custom.el" "$MY_HOME/.config/emacs/custom.el"
ln -sf "$DOTFILES_ROOT/apps/emacs/lsp.el" "$MY_HOME/.config/emacs/lsp.el"
