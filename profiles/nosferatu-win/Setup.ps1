$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\powershell\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\emacs\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\git\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\ssh\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\windows-terminal\Setup.ps1")
