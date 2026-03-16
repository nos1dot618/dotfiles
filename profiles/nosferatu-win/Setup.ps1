$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\powershell\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\emacs\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\git\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\ssh\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\windows-terminal\Setup.ps1")
