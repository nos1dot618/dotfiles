#!/usr/bin/env bash
set -xeu

for file in $DOTFILES_ROOT/desktop/*.desktop; do
  filename=$(basename "$file")
  ln -sf "$file" "$MY_HOME/.local/share/applications/$filename"
  chmod +x "$MY_HOME/.local/share/applications/$filename"
done
