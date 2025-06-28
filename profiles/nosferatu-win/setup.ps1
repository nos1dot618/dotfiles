$ErrorActionPreference = "Stop"

New-Item -ItemType SymbolicLink -Path $PROFILE -Target (Join-Path $env:DOTFILES_PROFILE "Microsoft.PowerShell_profile.ps1") -Force | Out-Null

& (Join-Path $env:DOTFILES_ROOT "apps\emacs\setup.ps1")
& (Join-Path $env:DOTFILES_ROOT "apps\git\setup.ps1")
& (Join-Path $env:DOTFILES_ROOT "apps\ssh\setup.ps1")
