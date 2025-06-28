$ErrorActionPreference = "Stop"

$CurPath = (Join-Path $env:DOTFILES_ROOT "apps\ssh")

New-Item -ItemType Directory -Path (Join-Path $env:USERPROFILE ".ssh") -Force | Out-Null
New-Item -ItemType SymbolicLink -Path (Join-Path $env:USERPROFILE ".ssh\config") -Target (Join-Path $CurPath "config") -Force | Out-Null
