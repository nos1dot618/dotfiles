$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$PowerShellProfile = (Join-Path $env:DOTFILES_PROFILE "PowerShellProfile.ps1")
New-Item -ItemType SymbolicLink -Path $PROFILE -Target $PowerShellProfile -Force | Out-Null
Info -Message "Symbolically linked `$PROFILE with '$PowerShellProfile'."

. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\emacs\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\git\Setup.ps1")
. Source-Script -Script (Join-Path $env:DOTFILES_ROOT "apps\ssh\Setup.ps1")
