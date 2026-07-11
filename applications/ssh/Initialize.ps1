$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

New-Directory -Path (Join-Path $env:USERPROFILE ".ssh")
New-SymbolicLink `
    -Destination (Join-Path $env:USERPROFILE ".ssh\config") `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\ssh\config")
