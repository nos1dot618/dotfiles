$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

$CurrentPath = (Join-Path $env:DOTFILES_ROOT "applications\emacs")
$EmacsInitFilePath = (Join-Path $env:USERPROFILE "AppData\Roaming\.emacs")

New-SymbolicLink -Target (Join-Path $CurrentPath "init.el") -Destination $EmacsInitFilePath
