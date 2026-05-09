$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$CurrentPath = (Join-Path $env:DOTFILES_ROOT "applications\emacs")
$EmacsInitFilePath = (Join-Path $env:USERPROFILE "AppData\Roaming\.emacs")

Create-Symboliclink -Target (Join-Path $CurrentPath "init.el") -Destination $EmacsInitFilePath
