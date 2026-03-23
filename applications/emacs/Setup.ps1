$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$CurrentPath = (Join-Path $env:DOTFILES_ROOT "applications\emacs")
$EmacsInitFilePath = (Join-Path $env:USERPROFILE "AppData\Roaming\.emacs")

New-Item -ItemType SymbolicLink -Path $EmacsInitFilePath -Target (Join-Path $CurrentPath "init.el") -Force | Out-Null
Info -Message "Successfully setup 'Emacs'."