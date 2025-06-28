$ErrorActionPreference = "Stop"

$CurPath = (Join-Path $env:DOTFILES_ROOT "apps\emacs")
$EmacsInitfilePath = (Join-Path $env:USERPROFILE "AppData\Roaming\.emacs")

New-Item -ItemType SymbolicLink -Path $EmacsInitfilePath -Target (Join-Path $CurPath "init.el") -Force | Out-Null
