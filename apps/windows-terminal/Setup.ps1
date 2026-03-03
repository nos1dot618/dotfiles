$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

New-Item `
    -ItemType SymbolicLink `
    -Path (Join-Path $env:USERPROFILE "\AppData\Local\Microsoft\Windows Terminal\settings.json") `
    -Target (Join-Path $env:DOTFILES_ROOT "apps\windows-terminal\settings.json") `
    -Force | Out-Null
Info -Message "Successfully setup 'Windows Terminal'."