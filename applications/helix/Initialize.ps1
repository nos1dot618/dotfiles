$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

Install-PortableArchive -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\helix\Manifest.psd1")

New-SymbolicLink `
    -Destination (Join-Path $env:APPDATA "helix") `
    -Target (Join-Path $env:DOTFILES_ROOT "applications\helix\config")
