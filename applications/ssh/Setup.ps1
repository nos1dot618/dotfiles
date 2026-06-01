$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

$ConfigPath = (Join-Path $env:DOTFILES_ROOT "applications\ssh\config")

Create-Directory -Path (Join-Path $env:USERPROFILE ".ssh")
Create-SymbolicLink -Destination (Join-Path $env:USERPROFILE ".ssh\config") -Target $ConfigPath
