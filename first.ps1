Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Elevate powershell environment to Administrator Priviledges, 
# which is needed for installing new packages.
# Reference: https://powershellcommands.com/powershell-elevate-to-admin-in-script
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

. (Join-Path (Get-Location) "vars.ps1")
& (Join-Path $env:DOTFILES_PROFILE "first.ps1")
