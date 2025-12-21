#!/usr/bin/env bash
set -xeu

: "${MY_HOME:?ERROR: MY_HOME environment-variable is not set.}"

# Set global username and email
git config --global user.name "ninthcircle"
git config --global user.email "mainlakshayhoon@gmail.com"
# Set SSH as the signing format
git config --global gpg.format ssh
# Set the signing key
git config --global user.signingkey "$MY_HOME/Keys/gitlab/gitlab_id_ed25519.pub"
chmod 600 "$MY_HOME/Keys/gitlab/gitlab_id_ed25519"
chmod 600 "$MY_HOME/Keys/github/github_id_ed25519"
# Enable commit signing by default
git config --global commit.gpgSign true
# Set the default branch name for new repositories
git config --global init.defaultBranch master
# Remove existing aliases before adding new
git config --global --remove-section alias 2>/dev/null || true
# Remember the merge resolution and reuse when needed.
git config --global rerere.enabled true
# Enable column UI in git.
git config --global column.ui auto
# Aliases
git config --global alias.s "status"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.tmp "commit -m 'Fly me to the moon'"
git config --global alias.l "log --oneline -n 10"
git config --global alias.p "push origin HEAD"
