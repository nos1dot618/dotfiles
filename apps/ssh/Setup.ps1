$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$ConfigPath = (Join-Path $env:DOTFILES_ROOT "apps\ssh\config")

New-Item -ItemType Directory -Path (Join-Path $env:USERPROFILE ".ssh") -Force | Out-Null
New-Item -ItemType SymbolicLink -Path (Join-Path $env:USERPROFILE ".ssh\config") -Target $ConfigPath -Force | Out-Null

Info -Message "Successfully setup 'SSH'."
