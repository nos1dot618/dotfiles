$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

New-SymbolicLink `
    -Destination (Join-Path $env:APPDATA ".emacs") `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\emacs\init.el")

$Version = (emacs --version | Select-Object -First 1) -replace "^GNU Emacs\s+", ""
Add-ToUserPath -PathToAdd (Join-Path $env:USERPROFILE "Thirdparty\emacs-$Version\bin")
