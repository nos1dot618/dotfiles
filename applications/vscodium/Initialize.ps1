$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

Install-PortableArchive -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\vscodium\Manifest.psd1")

New-SymbolicLink `
    -Destination (Join-Path $env:APPDATA "VSCodium\User\settings.json") `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\vscodium\settings.json")
