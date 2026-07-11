$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

Install-PowerShellModule -Name "PSReadLine" -MinimumVersion 2.2.6

New-SymbolicLink `
    -Destination $PROFILE `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\powershell\Profile.ps1")
