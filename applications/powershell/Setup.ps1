$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$CustomProfile = (Join-Path $env:DOTFILES_ROOT "applications\powershell\Profile.ps1")
New-Item -ItemType SymbolicLink -Path $PROFILE -Target $CustomProfile -Force | Out-Null
Info -Message "Symbolically linked `$PROFILE with '$CustomProfile'."