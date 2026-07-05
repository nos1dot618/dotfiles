$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

Install-Package -Choco -Package zig

Install-PortableArchive `
    -ManifestPath (Join-Path $env:DOTFILES_ROOT "applications\zig\zls\Manifest.psd1") `
    -Version (zig version)
