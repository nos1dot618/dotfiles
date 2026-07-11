$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

Install-PortableArchive -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\notepad-plue-plus\Manifest.psd1")
