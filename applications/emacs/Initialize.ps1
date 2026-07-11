$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

New-SymbolicLink `
    -Destination (Join-Path $env:APPDATA ".emacs") `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\emacs\init.el")

$Version = (emacs --version | Select-Object -First 1) -replace "^GNU Emacs\s+", ""
Add-PathEntry -Path (Join-Path $env:USERPROFILE "Thirdparty\emacs-$Version\bin")
