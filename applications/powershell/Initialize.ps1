$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

if (Get-Module PSReadLine) {
    Remove-Module PSReadLine -Force -ErrorAction SilentlyContinue
}
Install-ModuleIfMissing -Name "PSReadLine" -MinimumVersion 2.2.6

New-SymbolicLink `
    -Destination $PROFILE `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\powershell\Profile.ps1")
