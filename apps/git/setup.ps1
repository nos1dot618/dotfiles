$ErrorActionPreference = "Stop"

# Set global username and email
git config --global user.name "ninthcircle"
git config --global user.email "mainlakshayhoon@gmail.com"
# Set SSH as the signing format
git config --global gpg.format ssh
# Set the signing key
$KeyPath = (Join-Path $env:USERPROFILE "Keys\gitlab\gitlab_id_ed25519.pub")
git config --global user.signingkey $KeyPath
# Enable commit signing by default
git config --global commit.gpgSign true
# Set the default branch name for new repositories
git config --global init.defaultBranch master
# Remove existing aliases before adding new
git config --global --remove-section alias 2>/dev/null || true
# Aliases
git config --global alias.s "status"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.tmp "commit -m 'Fly me to the moon'"
git config --global alias.l "log --oneline -n 10"