#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

for file in $DOTFILES_ROOT/desktop/*.desktop; do
  filename=$(basename "$file")
  create_symlink "$file" "$MY_HOME/.local/share/applications/$filename"
  chmod +x "$MY_HOME/.local/share/applications/$filename"
	log_info "Created desktop application \"$file\"."
done
