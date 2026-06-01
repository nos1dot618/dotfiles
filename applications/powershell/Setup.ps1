$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

$CustomProfile = Join-Path $env:DOTFILES_ROOT "applications\powershell\Profile.ps1"
Create-Symboliclink -Destination $PROFILE -Target $CustomProfile
