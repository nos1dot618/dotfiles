Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

Elevate

. Source-Script (Join-Path $env:DOTFILES_PROFILE "First.ps1")
