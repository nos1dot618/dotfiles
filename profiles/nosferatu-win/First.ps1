$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")
. Source-Script (Join-Path $env:DOTFILES_PROFILE "Install.ps1")
