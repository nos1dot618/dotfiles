$ErrorActionPreference = "Stop"

$env:DOTFILES_ROOT = (Get-Location).Path
# In Windows this environment variable is renamed to DOTFILES_PROFILE from PROFILE,
# to not confuse it with $PROFILE environment variable which points to powershell profile directory.
$env:DOTFILES_PROFILE = (Join-Path $env:DOTFILES_ROOT "profiles\nosferatu-win")
