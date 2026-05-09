$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$Destination = Join-Path $env:USERPROFILE "\AppData\Local\Microsoft\Windows Terminal\settings.json"
$Target = Join-Path $env:DOTFILES_ROOT "applications\windows-terminal\settings.json"
Create-Symboliclink -Destination $Destination -Target $Target
