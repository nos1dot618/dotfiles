#!/usr/bin/env bash
set -xeu

for file in $DOTFILES_ROOT/desktop/*.desktop; do
  filename=$(basename "$file")
  ln -sf "$file" "$HOME/.local/share/applications/$filename"
  chmod +x "$HOME/.local/share/applications/$filename"
done
