$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

Install-PortableArchive -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\windows-terminal\Manifest.psd1")

New-SymbolicLink `
    -Destination (Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal\settings.json") `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\windows-terminal\settings.json")
