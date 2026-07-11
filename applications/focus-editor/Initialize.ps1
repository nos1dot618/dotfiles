$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

Install-PortableExecutable -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\focus-editor\Manifest.psd1")
