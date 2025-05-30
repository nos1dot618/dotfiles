#!/usr/bin/env bash
set -xeu

# Set global username and email
git config --global user.name "ninthcircle"
git config --global user.email "mainlakshayhoon@gmail.com"
# Set SSH as the signing format
git config --global gpg.format ssh
# Set the signing key
git config --global user.signingkey "~/Keys/gitlab/gitlab_id_ed25519.pub"
# Enable commit signing by default
git config --global commit.gpgSign true
# Set the default branch name for new repositories
git config --global init.defaultBranch master
