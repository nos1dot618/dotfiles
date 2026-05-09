$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$CustomProfile = Join-Path $env:DOTFILES_ROOT "applications\powershell\Profile.ps1"
Create-Symboliclink -Destination $PROFILE -Target $CustomProfile
