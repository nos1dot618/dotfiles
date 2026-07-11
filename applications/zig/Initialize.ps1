$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

Install-ChocolateyPackage -Package zig

Install-PortableArchive `
    -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\zig\zls\Manifest.psd1") `
    -Version (zig version)
