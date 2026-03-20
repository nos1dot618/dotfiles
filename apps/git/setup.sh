#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/apps/bash/commons.sh"

# Set global username and email
git config --global user.name "ninthcircle"
git config --global user.email "mainlakshayhoon@gmail.com"
log_note "Set up Git user details."

# Set SSH as the signing format
git config --global gpg.format ssh
# Set the signing key
git config --global user.signingkey "$MY_HOME/Keys/gitlab/gitlab_id_ed25519.pub"
chmod 600 "$MY_HOME/Keys/gitlab/gitlab_id_ed25519"
chmod 600 "$MY_HOME/Keys/github/github_id_ed25519"
# Enable commit signing by default
git config --global commit.gpgSign true
log_note "Set up Git signing keys."

# Set the default branch name for new repositories
git config --global init.defaultBranch master
log_note "Set Git default branch to master."

# Remember the merge resolution and reuse when needed.
git config --global rerere.enabled true

# Enable column UI in git.
git config --global column.ui auto

# Remove existing aliases before adding new
git config --global --remove-section alias 2>/dev/null || true
# Aliases
bash "$DOTFILES_ROOT/apps/git/Aliases.sh"
log_note "Set up Git aliases."

log_info "Set up Git successfully."
