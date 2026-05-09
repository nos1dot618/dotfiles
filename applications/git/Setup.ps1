$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

# Set global username and email.
git config --global user.name "ninthcircle"
git config --global user.email "mainlakshayhoon@gmail.com"

# Set SSH as the signing format.
git config --global gpg.format ssh
# Set the signing key.
$KeyPath = (Join-Path $env:USERPROFILE "Keys\gitlab\gitlab_id_ed25519.pub")
git config --global user.signingkey $KeyPath
# Enable commit signing by default.
git config --global commit.gpgSign true

# Set the default branch name for new repositories.
git config --global init.defaultBranch master

# Remove existing aliases before adding new.
try {
    git config --global --remove-section alias 2>$null
} catch {
    # ignore
}

# Remember the merge resolution and reuse when needed.
git config --global rerere.enabled true

# Enable column UI in git.
git config --global column.ui auto

# Aliases.
Get-Content (Join-Path $env:DOTFILES_ROOT "applications\git\Aliases.sh") | Invoke-Expression
